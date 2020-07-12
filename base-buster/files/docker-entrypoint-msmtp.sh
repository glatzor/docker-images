#!/bin/bash

declare -A rc

rc[host]="${MSMTP_HOST:=mail.dpool.net}"
rc[user]="${MSMTP_USER:=relay}"
rc[password]="${MSMTP_PASSWORD:=XXX}"
rc[from]="${MSMTP_FROM:=admin+docker@dpool.com}"

for key in ${!rc[@]}; do
       awk -f /usr/local/share/awk/set-option-to-value -v option=${key} -v value=${rc[${key}]} /etc/msmtprc > /etc/msmtprc.tmp
       mv /etc/msmtprc.tmp /etc/msmtprc
done
