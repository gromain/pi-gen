#!/bin/bash -e

install -v -m 755 -d "${ROOTFS_DIR}/etc/hostapd/"
install -v -m 644 files/hostapd.conf "${ROOTFS_DIR}/etc/hostapd/hostapd.conf"
install -v -m 755 -d "${ROOTFS_DIR}/etc/default/"
install -v -m 644 files/hostapd "${ROOTFS_DIR}/etc/default/hostapd"
install -v -m 644 files/dnsmasq.conf "${ROOTFS_DIR}/etc/dnsmasq.conf"
install -v -m 664 files/dhcpcd.conf "${ROOTFS_DIR}/etc/dhcpcd.conf"
install -v -m 644 files/dhcpcd.enter-hook "${ROOTFS_DIR}/etc/dhcpcd.enter-hook"
install -v -m 755 -d "${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 644 files/autohotspot.service "${ROOTFS_DIR}/etc/systemd/system/autohotspot.service"
install -v -m 644 files/autohotspot.timer "${ROOTFS_DIR}/etc/systemd/system/autohotspot.timer"
install -v -m 755 -d "${ROOTFS_DIR}/usr/bin/"
install -v -m 755 files/autohotspotN "${ROOTFS_DIR}/usr/bin/autohotspotN"


on_chroot << EOF
	systemctl unmask hostapd
	systemctl disable dnsmasq
	systemctl disable hostapd
	systemctl enable autohotspot.service
	systemctl enable autohotspot.timer
EOF
