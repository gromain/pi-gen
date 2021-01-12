#!/bin/bash

_user="${PWD##*/}"
cd /home/$_user
find ./ -type f -iname "install.sh*" -exec rm {} \;
wget https://raw.githubusercontent.com/stefal/rtkbase/dev/tools/install.sh
#wget https://raw.githubusercontent.com/stefal/rtkbase/master/tools/install.sh
find ./ -type f -iname "*.sh" -exec chmod +x {} \;
echo '#####MODIFY $(logname) install.sh########'
sed -i -e "s/\$(logname)/$_user/g" /home/$_user/install.sh
echo '#####DONE !##############################'
cat install.sh
./install.sh --dependencies --rtklib --rtkbase-release --gpsd-chrony
find ./ -type f -iname "*.sh" -exec chmod +x {} \;
