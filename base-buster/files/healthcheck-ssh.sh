#!/bin/sh
echo "Checking ssh..."
nc -w1  localhost 22 < /dev/null | grep -q "SSH-2.0"
exit $?
