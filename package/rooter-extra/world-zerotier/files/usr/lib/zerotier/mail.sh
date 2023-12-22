#!/bin/sh

ROOTER=/usr/lib/rooter
ROOTER_LINK="/tmp/links"

log() {
	logger -t "Mail Setting" "$@"
}

sett=$1
smtp=$(echo $sett | cut -d, -f1)
euser=$(echo $sett | cut -d, -f2)
epass=$(echo $sett | cut -d, -f3)
sendto=$(echo $sett | cut -d, -f4)

uci set zerotier.configuration.smtp=$smtp
uci set zerotier.configuration.euser=$euser
uci set zerotier.configuration.epass=$epass
uci set zerotier.configuration.sendto=$sendto
uci commit zerotier