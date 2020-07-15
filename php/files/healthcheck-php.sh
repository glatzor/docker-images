#!/bin/sh
echo "Checking php..."
curl --silent http://localhost/phpinfo | grep --silent "PHP Version 7.4."
exit $?
