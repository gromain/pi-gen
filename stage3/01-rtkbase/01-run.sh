#!/bin/bash -e

install -m 644 files/install.sh ${ROOTFS_DIR}/
install -m 644 files/detect_gnss_flash-gnss.sh ${ROOTFS_DIR}/

on_chroot << EOF
chmod +x install.sh
chmod 770 detect_gnss_flash-gnss.sh
echo 'Install RtkBase'
./install.sh --from-repo
echo 'Done!!!'
EOF
