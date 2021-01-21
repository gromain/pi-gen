#!/bin/bash -e

install -m 644 files/init_ap.sh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/

on_chroot << EOF
cd /home/${FIRST_USER_NAME}
find ./ -type f -iname "*.sh" -exec chmod +x {} \;

sed -i -e "s/80/8080/g" /etc/lighttpd/lighttpd.conf
rm -rf /var/www/html
git clone https://github.com/billz/raspap-webgui /var/www/html

#rm init_ap.sh
EOF
