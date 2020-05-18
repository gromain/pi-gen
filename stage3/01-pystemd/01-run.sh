#!/bin/bash -e

on_chroot << EOF
echo 'get pystemd'
cd /home/centipede
if cd pystemd; then git pull; else git clone -b master https://github.com/facebookincubator/pystemd.git; fi
python3 -m pip install -r requirements.txt
python3 -m pip install --upgrade cython
python3 setup.py install
EOF
