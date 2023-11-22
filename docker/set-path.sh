#!/usr/bin/env sh

. $IDF_PATH/export.sh

echo "export PATH=$(echo $PATH)" >> /root/.bashrc

mkdir -p /root/.ssh
echo "PATH=$(echo $PATH)" >> /root/.ssh/environment
