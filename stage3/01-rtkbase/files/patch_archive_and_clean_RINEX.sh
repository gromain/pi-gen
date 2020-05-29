#!/bin/bash
#This script should be run from a crontab
#You can customize archive_name and archive_rotate in settings.conf

BASEDIR=$(dirname "$0")
source <( grep = ${BASEDIR}/settings.conf )
cd ${datadir}

#make rinex files & zip
for file in $(find . -maxdepth 1 -type f -mmin +1 -name "*.ubx" )
do
fname="${file%.*}"
/usr/local/bin/convbin ${file} -v 2.11 -hm ${mnt_name} -od -os -oi -ot  -tt 0  -ti 5
find /home -regextype posix-egrep -regex '.*\.(obs|nav|lnav|gnav|cnav)$' -exec zip -jrm -D ${fname}_RINEX.zip {} +
done

#archive and compress previous day's gnss data.
find . -maxdepth 1 -type f -mtime -1 -mmin +60 -name "*.ubx*" -exec tar -jcvf ${archive_name} --remove-files {} +;

#delete gnss data older than x days.
find . -maxdepth 1 -type f -name "*.tar.bz2" -mtime +${archive_rotate} -delete
