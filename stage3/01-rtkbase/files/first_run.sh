#!/bin/bash
set -x
_user="${PWD##*/}"
cd /home/$_user
find ./ -type f -iname "install.sh*" -exec rm {} \;
wget https://raw.githubusercontent.com/stefal/rtkbase/web_gui/tools/install.sh &&
find ./ -type f -iname "*.sh" -exec chmod +x {} \;
echo '#####MODIFY $(logname) install.sh########'
sed -i -e "s/\$(logname)/$_user/g" /home/$_user/install.sh
sed -i -e "s/--flash-gnss/--configure-gnss/g" /home/$_user/install.sh
echo '#####DONE !##############################'
cat install.sh
./install.sh --dependencies --rtklib --rtkbase-release
echo '#####MODIFY $(logname) copy_unit.sh######'
sed -i -e "s/\$(logname)/$_user/g" /home/$_user/rtkbase/copy_unit.sh
sed -i -e "s/--flash-gnss/--configure-gnss/g" /home/$_user/rtkbase/tools/install.sh
echo '#####DONE !##############################'


