#!/bin/sh
echo "Checking php..."
curl http://localhost/phpinfo | grep -s "PHP Version 7.4."
exit $?
