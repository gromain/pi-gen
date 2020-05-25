#!/bin/bash
set -x

sed -i -e "s/\$(logname)/centipede/g" /home/centipede/install.sh
