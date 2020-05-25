#!/bin/bash
set -x

sed -i -e "s/centipede/\$(logname)/g" /home/centipede/install.sh
