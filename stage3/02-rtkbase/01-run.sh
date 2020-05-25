#!/bin/bash -e

#install -m 644 files/install.sh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/
install -m 644 files/sed.sh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/
install -m 644 files/unsed.sh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/

on_chroot << EOF
cd /home/centipede
wget https://raw.githubusercontent.com/stefal/rtkbase/web_gui/tools/install.sh
find ./ -type f -iname "*.sh" -exec chmod +x {} \;
./sed.sh
EOF

on_chroot << EOF
cd /home/centipede
echo '################################'
echo 'START INSTALL'
echo '################################'
./install.sh --dependencies --rtklib --rtkbase-release
echo '################################'
echo 'INSTALL FINISH'
echo '################################'
EOF
