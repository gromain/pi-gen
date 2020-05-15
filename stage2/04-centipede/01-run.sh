#!/bin/bash -e

on_chroot << EOF
rm -rf RTKLIB
git clone -b rtklib_2.4.3 --single-branch https://github.com/tomojitakasu/RTKLIB
#Install Rtklib app
#TODO add correct CTARGET in makefile?
    make -j8 --directory=RTKLIB/app/str2str/gcc
    make -j8 --directory=RTKLIB/app/str2str/gcc install
    make -j8 --directory=RTKLIB/app/rtkrcv/gcc
    make -j8 --directory=RTKLIB/app/rtkrcv/gcc install
    make -j8 --directory=RTKLIB/app/convbin/gcc
    make -j8 --directory=RTKLIB/app/convbin/gcc install
#deleting RTKLIB
    rm -rf RTKLIB
rm -rf rtkbase
git clone -b web_gui --single-branch https://github.com/stefal/rtkbase.git
python3 -m pip install -r rtkbase/web_app/requirements.txt
rtkbase/copy_unit.sh
systemctl enable rtkbase_web.service
systemctl daemon-reload
EOF
