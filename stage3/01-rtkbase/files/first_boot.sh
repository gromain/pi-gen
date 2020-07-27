#!/bin/bash

_user="${PWD##*/}"
echo 'USER IS: ' $_user
find . -name "*.sh" -exec sed -i "s/\$(logname)/$_user/g" {} \;
/home/$_user/rtkbase/tools/install.sh --unit-files --detect-usb-gnss --configure-gnss --start-services
find . -name "*.sh" -exec sed -i "s/$_user/\$(logname)/g" {} \;
