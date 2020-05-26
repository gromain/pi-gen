#!/bin/bash
set -x
_user="${PWD##*/}"
cd /home/$_user
sed -i -e "s/\$(logname)/\$_user/g" /home/$_user/install.sh
