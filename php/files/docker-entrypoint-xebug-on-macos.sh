#!/bin/bash
# Native networking is not availabe using MacOS. So we have to adapt 
# the xdebug configuration

INI="[xdebug]
xdebug.remote_connect_back=off
xdebug.remote_host=host.docker.internal"

# If the host system uses a linuxkit kernel we are likely running on docker tools
if [[ $(uname --kernel-release) =~ ^[0-9]+\.[0-9]+\.[0-9]+-linuxkit$ ]]; then
	for PHP_ETC_BASE in /etc/php/*; do
		echo ${INI} > ${PHP_ETC_BASE}/cli/conf.d/99-docker.ini
		echo ${INI} > ${PHP_ETC_BASE}/fpm/conf.d/99-docker.ini
	done
fi
