#!/bin/bash

lighttpd-enable-mod fastcgi-php    
service lighttpd force-reload
systemctl restart lighttpd.service
cd /var/www/html
cp installers/raspap.sudoers /etc/sudoers.d/090_raspap
mkdir /etc/raspap/
mkdir /etc/raspap/backups
mkdir /etc/raspap/networking
mkdir /etc/raspap/hostapd
mkdir /etc/raspap/lighttpd
cat /etc/dhcpcd.conf | tee -a /etc/raspap/networking/defaults > /dev/null
cp raspap.php /etc/raspap 
chown -R www-data:www-data /var/www/html
chown -R www-data:www-data /etc/raspap
mv installers/*log.sh /etc/raspap/hostapd 
mv installers/service*.sh /etc/raspap/hostapd
chown -c root:www-data /etc/raspap/hostapd/*.sh 
chmod 750 /etc/raspap/hostapd/*.sh 
cp installers/configport.sh /etc/raspap/lighttpd
chown -c root:www-data /etc/raspap/lighttpd/*.sh
mv installers/raspapd.service /lib/systemd/system
systemctl daemon-reload
systemctl enable raspapd.service
mv /etc/default/hostapd ~/default_hostapd.old
cp /etc/hostapd/hostapd.conf ~/hostapd.conf.old
cp config/default_hostapd /etc/default/hostapd
cp config/hostapd.conf /etc/hostapd/hostapd.conf
cp config/dnsmasq.conf /etc/dnsmasq.d/090_raspap.conf
cp config/dhcpcd.conf /etc/dhcpcd.conf
cp config/config.php /var/www/html/includes/
systemctl stop systemd-networkd
systemctl disable systemd-networkd
cp config/raspap-bridge-br0.netdev /etc/systemd/network/raspap-bridge-br0.netdev
cp config/raspap-br0-member-eth0.network /etc/systemd/network/raspap-br0-member-eth0.network 
sed -i -E 's/^session\.cookie_httponly\s*=\s*(0|([O|o]ff)|([F|f]alse)|([N|n]o))\s*$/session.cookie_httponly = 1/' /etc/php/7.3/cgi/php.ini
sed -i -E 's/^;?opcache\.enable\s*=\s*(0|([O|o]ff)|([F|f]alse)|([N|n]o))\s*$/opcache.enable = 1/' /etc/php/7.3/cgi/php.ini
phpenmod opcache
echo "net.ipv4.ip_forward=1" | tee /etc/sysctl.d/90_raspap.conf > /dev/null
sysctl -p /etc/sysctl.d/90_raspap.conf
/etc/init.d/procps restart
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.50.0/24 ! -d 192.168.50.0/24 -j MASQUERADE
iptables-save | tee /etc/iptables/rules.v4
systemctl unmask hostapd.service
systemctl enable hostapd.service
wpa_supplicant -B -Dnl80211,wext -c/etc/wpa_supplicant/wpa_supplicant.conf -iwlan0
