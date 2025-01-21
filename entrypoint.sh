#!/bin/bash
set -e

TTYD_ARGS="-p8888 -m1 -W"

if [ -f "/www/index.html" ]; then
    TTYD_ARGS="$TTYD_ARGS -I /www/index.html"
fi

# Create user account
adduser -D --shell=/bin/bash $USERNAME

# Add a password to the user
echo "$USERNAME:$PASSWORD" | chpasswd

# Set timezone
ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime
echo $TZ > /etc/timezone

# Auto login the user, if allowed
[ $AUTOLOGIN == "true" ] && TTYD_ARGS="$TTYD_ARGS -f $USERNAME"

# Start lighttpd server
lighttpd -f /etc/lighttpd/lighttpd.conf

# Start ttyd
exec ttyd $TTYD_ARGS login "$@"
