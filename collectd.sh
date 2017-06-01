#!/bin/bash
# `/sbin/setuser collectd` runs the given command as the user `collectd`.
# If you omit that part, the command will be run as root.

# Check for config directory
if [ ! -d /config ]; then
	mkdir -p /config
fi

# Copy default config if config empty
if [ ! -d  /config/etc ]; then
	mkdir -p /config/etc
fi

if [ ! "$(ls -A /config/etc/)" ]; then
	cp -rf /etc/collectd/* /config/etc/
fi

# Check for logs directory
if [ ! -d /config/logs ]; then
	mkdir -p /config/logs
fi


# Link to the config in the 
rm -rf /etc/collectd
ln -s /config/etc /etc/collectd

exec /usr/sbin/collectd -f >> /config/logs/collectd.log 2>&1
