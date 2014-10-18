#!/bin/sh
mkdir -p -m0755 /var/run/sshd
mkdir -m0700 /root/.ssh
wget https://github.com/umireon.keys -q -O - > /root/.ssh/authorized_keys
exec /usr/sbin/sshd -D
