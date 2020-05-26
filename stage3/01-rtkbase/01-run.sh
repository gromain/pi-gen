#!/bin/bash -e

install -m 644 files/sed.sh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/
install -m 644 files/unsed.sh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/

on_chroot << EOF
_user="${PWD##*/}"
cd /home/$_user
find ./ -type f -iname "install.sh*" -exec rm {} \;
wget https://raw.githubusercontent.com/stefal/rtkbase/web_gui/tools/install.sh
find ./ -type f -iname "*.sh" -exec chmod +x {} \;
./sed.sh
EOF

on_chroot << EOF
_user="${PWD##*/}"
cd /home/$_user
echo '################################'
echo 'START INSTALL BASE RTK CENTIPEDE'
echo '################################'
./install.sh --dependencies --rtklib --rtkbase-release
EOF
