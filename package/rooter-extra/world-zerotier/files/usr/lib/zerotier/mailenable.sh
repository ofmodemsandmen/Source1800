#!/bin/sh
. /lib/functions.sh

log() {
	modlog "Enable" "$@"
}

enable=$1
enabled=$(uci -q get zerotier.configuration.enabled)
if [ "$enabled" != "$enable" ]; then
	uci set zerotier.configuration.enabled="$enable"
	uci commit zerotier
fi

