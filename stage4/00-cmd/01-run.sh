#!/bin/bash -e

install -m 644 files/user-menu.js ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/
install -m 644 files/convbin.sh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/


on_chroot << EOF 
sudo apt-get -y autoremove npm nodejs
wget -c https://nodejs.org/dist/v8.9.0/node-v8.9.0-linux-armv6l.tar.gz
tar -xzf node-v8.9.0-linux-armv6l.tar.gz
cd  node-v8.9.0-linux-armv6l
sudo cp -R * /usr/local/
cd
wget --no-check-certificate -c -P ./ https://raw.githubusercontent.com/coderaiser/cloudcmd/master/package.json
npm install --production
npm install gritty -g --unsafe-perm
npm install cloudcmd -g --unsafe-perm
ls -l /home/${FIRST_USER_NAME}
mv /usr/local/lib/node_modules/cloudcmd/static/user-menu.js /usr/local/lib/node_modules/cloudcmd/static/user-menu.js.bak
ln -s /home/${FIRST_USER_NAME}/user-menu.js /usr/local/lib/node_modules/cloudcmd/static/user-menu.js
chmod +x /home/${FIRST_USER_NAME}/convbin.sh
EOF
