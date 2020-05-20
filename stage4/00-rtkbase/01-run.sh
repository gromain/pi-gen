#!/bin/bash -e

install -m 644 files/install.sh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/
install -m 644 files/sed.sh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/

on_chroot << EOF
cd /home/centipede
chmod +x sed.sh
./sed.sh
EOF

on_chroot << EOF
cd /home/centipede
chmod +x install.sh
echo '################################'
echo 'START INSTALL'
echo '################################'
./install.sh --dependencies --rtklib --rtkbase-release
echo '################################'
echo 'INSTALL FINISH'
echo '################################'
EOF
