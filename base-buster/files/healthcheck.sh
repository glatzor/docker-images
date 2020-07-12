#!/bin/sh

set -e

for CHECK in /usr/local/lib/healthcheck/*.sh; do
	sh $CHECK
done
