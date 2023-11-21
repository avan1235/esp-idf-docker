#!/usr/bin/env bash
set -e

. $IDF_PATH/export.sh

/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config_esp_idf
