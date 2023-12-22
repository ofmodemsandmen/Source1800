#!/bin/sh
. /lib/functions.sh

ROOTER=/usr/lib/rooter
log() {
	logger -t "SetWizard" "$@"
}

getfirst() {
	flen=${act:1:2}
	fz=${flen:0:1}
	if [ "$fz" = "0" ]; then
		flen=${flen:1:1}
	fi
	first=${act:3:$flen}
}

getsecond() {
	let tt=$flen+3
	tlen=${act:$tt:2}
	fz=${tlen:0:1}
	if [ "$fz" = "0" ]; then
		tlen=${tlen:1:1}
	fi
	let tt=$tt+2
	second=${act:$tt:$tlen}
}
	
act="$1"

size=${#act}
i=0
str=""
while true; do
	b=${act:i:3}
	b=$(echo $b | sed 's/^0*//')
	b=$(printf "\x$(printf %x $b)")
	str=$str$b
	let i=$i+3
	if [ "$i" -ge "$size" ]; then
		break
	fi
done
act="$str"

action=${act:0:1}

if [ "$action" = "1" ]; then
	getfirst
	if [ -z "$first" ]; then
		sleep 1
		exit 0
	fi
	passw=$first
	echo -e "$passw\n$passw" | passwd root
	sleep 1
	exit 0
fi

if [ "$action" = "2" ]; then
	getfirst
	getsecond
	ssid="$first"
	passw="$second"
	chan=$(uci -q get wireless.radio0.channel)
	if [ "$chan" -lt 20 ]; then
		uci set wireless.default_radio0.ssid="$ssid"
		uci set wireless.default_radio0.key="$passw"
		uci commit wireless
		wifi up wlan0
	else
		uci set wireless.default_radio1.ssid="$ssid"
		uci set wireless.default_radio1.key="$passw"
		uci commit wireless
		wifi up wlan1
	fi
	sleep 1
	exit 0
fi

if [ "$action" = "3" ]; then
	getfirst
	getsecond
	ssid="$first"
	passw="$second"
	chan=$(uci -q get wireless.radio0.channel)
	if [ "$chan" -lt 20 ]; then
		uci set wireless.default_radio1.ssid="$ssid"
		uci set wireless.default_radio1.key="$passw"
		uci commit wireless
		wifi up wlan1
	else
		uci set wireless.default_radio0.ssid="$ssid"
		uci set wireless.default_radio0.key="$passw"
		uci commit wireless
		wifi up wlan0
	fi
	sleep 1
	exit 0
fi

if [ "$action" = "4" ]; then
	first=${act:1}
	cpin=$(uci -q get profile.simpin.pin)
	if [ "$first" = "$cpin" ]; then
		exit 0
	fi
	uci set profile.simpin.pin="$first"
	uci commit profile
	/usr/lib/rooter/luci/restart.sh 1 11 &
	uci set wizard.basic.detect="0"
	uci commit wizard
	sleep 1
	exit 0
fi

if [ "$action" = "5" ]; then
	wiz=$(uci -q get wizard.basic.wizard)
	uci set wizard.basic.wizard="0"
	uci set wizard.basic.detect="0"
	uci commit wizard
	con=$(uci -q get modem.modem1.connected)
	if [ "$con" != "1" ]; then
		/usr/lib/rooter/luci/restart.sh 1 11 &
	fi
	exit 0
fi

if [ "$action" = "6" ]; then
	getfirst
	getsecond
	name="$first"
	zone="$second"
	uci set system.@system[0].zonename="$name"
	uci set system.@system[0].timezone="$zone"
	uci commit system
	/etc/init.d/system restart
	sleep 1
	exit 0
fi

if [ "$action" = "7" ]; then
	getfirst
	getsecond
	nid="$first"
	enb="$second"
	uci set zerotier.zerotier.enabled="$enb"
	uci set zerotier.zerotier.join="$nid"
	uci commit zerotier
	/etc/init.d/zerotier restart
	rm -f /etc/zemail
	sleep 1
	exit 0
fi
