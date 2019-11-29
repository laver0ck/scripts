#!/bin/bash
# script takes file as argument and backup it to /tmp/{filename}
# put it in one of `bin` dirs

backup_file() {
  if [ -f "$1" ]
  then
    local BACKUP_FILE="/tmp/$(basename ${1}).$(date +%F).$$"
    echo "Backing up $1 to ${BACKUP_FILE}"
    cp $1 $BACKUP_FILE
  else
    return 1
  fi
}

backup_file $1

if [ $? -eq "0" ]
then
  echo "Backup succeded!"
else
  echo "Backup failed!"
  exit 1
fi