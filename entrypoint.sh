#!/bin/sh
exec snort -c /usr/local/etc/snort/snort.lua -R /opt/custom.rules -i eth0 -A cmg
