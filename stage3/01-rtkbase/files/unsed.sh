#!/bin/bash
set -x
_user="${PWD##*/}"
cd /home/$_user
sed -i -e "s/\$_user/\$(logname)/g" /home/basegnss/install.sh
sed -i -e "s/\$_user/\$(logname)/g" /home/$_user/rtkbase/copy_unit.sh
