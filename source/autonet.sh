#!/bin/sh
ifconfig eth0 up
udhcpc -t 5 -q -s /bin/simple.script
