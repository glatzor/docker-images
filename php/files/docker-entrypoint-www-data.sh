#!/bin/bash
# Allow to change the user and group id of www-data
: ${WWW_DATA_USERID:=33}
: ${WWW_DATA_GROUPID:=$WWW_DATA_USERID}

usermod -u ${WWW_DATA_USERID} www-data
groupmod -g ${WWW_DATA_GROUPID} www-data
