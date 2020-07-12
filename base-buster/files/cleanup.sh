#!/bin/sh

set -ex 

apt-get clean
find /var/lib/apt/lists -type f -exec rm {} \;
