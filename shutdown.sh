#!/bin/bash

SIDLIST=cat ${1}| sed -n 's/.*\(sid_list\)/\1/p'|awk '{print $1}'|awk -F= '{print $2}'

findProfile() {
if [ ! $# -eq 0 ]
  then
    oraProfile=find $HOME -name "*profile.*${1}"
  else
    echo "Empty parameter. Exit 1"
    exit 1
fi
}

for sid in $SIDLIST
do
  findProfile $sid
  source "$oraProfile"
  timeout 900 echo "shutdown immediate;" | sqlplus / as sysdba
  rc="$?"
  if [ $rc -eq 124 ]; then
    echo "shutdown abort;" | sqlplus / as sysdba
  elif [ $rc -ne 0 ]; then
    echo "{'failed': true, 'msg': 'Error while stopping DB'}"
    exit 1
  elif [ $rc -eq 0 ]; then
    checkMem=$(sysresv -ifd on)
    echo $checkMem | grep "not alive for sid \"$sid\""
    if [ $? -ne 0 ]; then
      echo "{'failed': true, 'msg': 'Memory was not cleared!'}"
      exit 1
    fi
  fi
done

echo '{"changed": true}'
exit 0
