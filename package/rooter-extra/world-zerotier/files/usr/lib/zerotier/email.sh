#!/bin/sh
. /lib/functions.sh

log() {
	modlog "Zerotier" "$@"
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
	echo "Subject: Router ID" >> $STEMP
	echo "$message" >> $STEMP
	mess=$(cat $STEMP)
	echo -e "$mess" | msmtp --read-envelope-from --read-recipients &>/tmp/suc
	suc=$(cat /tmp/suc)
}

secret=$(uci -q get zerotier.zerotier.secret)
while [ -z "$secret" ]; do
	sleep 10
	secret=$(uci -q get zerotier.zerotier.secret)
done
secret=${secret:0:10}

enabled=$(uci -q get zerotier.configuration.enabled)
while [ "$enabled" != "1" ]; do
	sleep 600
	enabled=$(uci -q get zerotier.configuration.enabled)
done

while [ true ]; do
	valid=$(cat /var/state/dnsmasqsec)
	st=$(echo "$valid" | grep "ntpd says time is valid")
	if [ ! -z "$st" ]; then
		break
	fi
	sleep 60
done

if [ -e /etc/zemail ]; then
	exit 0
fi

while [ true ]; do
	stat=$(zerotier-cli status)
	onl=$(echo "$stat" | grep "ONLINE")
	if [ ! -z "$onl" ]; then
		ID=$(uci -q get zerotier.zerotier.join)
		/usr/lib/zerotier/netid.sh 0 $ID
		break
	fi
done

while [ true ]; do
	host=$(uci -q get zerotier.configuration.smtp)
	user=$(uci -q get zerotier.configuration.euser)
	pass=$(uci -q get zerotier.configuration.epass)
	email=$(uci -q get zerotier.configuration.sendto)
	if [ "$host" = "" -o "$user" = "" -o "$pass" = "" -o "$email" = "" ]; then
		sleep 600
	else
		mc=$(ifconfig br-lan)
		mc=$(echo "$mc" | tr " " ",")
		mac=$(echo $mc | cut -d, -f9)
		sendmsg="Router ID : "$secret"  MAC Address : "$mac
		echo "$sendmsg" > /tmp/messg
		sendemail
		if [ -z "$suc" ]; then
			log "Router ID email sent"
			echo "0" > /etc/zemail
			break
		fi
		sleep 600
	fi
done