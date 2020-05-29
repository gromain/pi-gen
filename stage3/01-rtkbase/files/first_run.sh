#!/bin/bash
set -x
_user="${PWD##*/}"
cd /home/$_user
find ./ -type f -iname "install.sh*" -exec rm {} \;
wget https://raw.githubusercontent.com/stefal/rtkbase/web_gui/tools/install.sh &&
find ./ -type f -iname "*.sh" -exec chmod +x {} \;
echo '#####MODIFY $(logname) install.sh########'
sed -i -e "s/\$(logname)/$_user/g" /home/$_user/install.sh
echo '#####DONE !##############################'
cat install.sh
./install.sh --dependencies --rtklib --rtkbase-release
echo '#####MODIFY $(logname) copy_unit.sh######'
sed -i -e "s/\$(logname)/$_user/g" /home/$_user/rtkbase/copy_unit.sh
echo '#####DONE !##############################'
echo '#####MODIFY archive_and_clean with rinex ######'
mv patch_archive_and_clean_RINEX.sh /home/$_user/rtkbase/archive_and_clean.sh
chmod +x /home/$_user/rtkbase/archive_and_clean.sh
echo '#####DONE !####################################'


