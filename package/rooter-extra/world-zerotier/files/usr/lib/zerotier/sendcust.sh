#!/bin/sh
. /lib/functions.sh

log() {
	modlog "Email" "$@"
}

sendemail() {
	STEMP="/tmp/eemail"
	MSG="/usr/lib/zerotier/msmtprc"
	DST="/etc/msmtprc"
	rm -f $STEMP
	cp $MSG $STEMP
	sed -i -e "s!#HOST#!$host!g" $STEMP
	sed -i -e "s!#USER#!$user!g" $STEMP
	sed -i -e "s!#PASS#!$pass!g" $STEMP
	mv $STEMP $DST
	
	message='\n'$(cat /tmp/messg)
	STEMP="/tmp/emailmsg"
	rm -f $STEMP
	echo "From: Remote Access <$user>" >> $STEMP
	echo "To: $email" >> $STEMP
	echo "Subject: Customer Name" >> $STEMP
	echo "$message" >> $STEMP
	mess=$(cat $STEMP)
	echo -e "$mess" | msmtp --read-envelope-from --read-recipients &>/tmp/suc
	suc=$(cat /tmp/suc)
}

custn=$1
uci set zerotier.zerotier.cust="$custn"
uci commit zerotier
rm -f /tmp/sendcust
host=$(uci -q get zerotier.configuration.smtp)
user=$(uci -q get zerotier.configuration.euser)
pass=$(uci -q get zerotier.configuration.epass)
email=$(uci -q get zerotier.configuration.sendto)
if [ "$host" = "" -o "$user" = "" -o "$pass" = "" -o "$email" = "" ]; then
 exit 0
fi
secret=$(uci -q get zerotier.zerotier.secret)
secret=${secret:0:10}
mc=$(ifconfig br-lan)
mc=$(echo "$mc" | tr " " ",")
mac=$(echo $mc | cut -d, -f9)
sendmsg="Customer Name : "$custn"  Router ID : "$secret"  MAC Address : "$mac
echo "$sendmsg" > /tmp/messg
sendemail
if [ -z "$suc" ]; then
	echo "0" > /tmp/sendcust
fi