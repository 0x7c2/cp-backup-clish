#!/bin/bash

#
# Copyright 2021 by by 0x7c2, Simon Brecht.
# All rights reserved.
# This file is released under the "Apache License 2.0". Please see the LICENSE
# file that should have been included as part of this package.
#

FTP_HOST=ftp-server.domain.local
FTP_USER=checkpoint-backup-user
FTP_PASS=password

TIMESTAMP=`date "+%Y.%m.%d-%H.%M.%S"`
MYHOSTNAME=`/bin/hostname`

BACKUP_PATH="/tmp"
BACKUP_FILE="clish_${MYHOSTNAME}_${TIMESTAMP}.txt"

#
# Dump CLISH Configuration into file
#
/bin/clish -c "show configuration" > ${BACKUP_PATH}/${BACKUP_FILE}

#
# Transfer Dump to FTP Server
#
cd ${BACKUP_PATH}
ftp -inv ${FTP_HOST} <<EOF
user ${FTP_USER} ${FTP_PASS}
cd ${MYHOSTNAME,,}
mput ${BACKUP_FILE}
bye
EOF
