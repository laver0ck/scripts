#!/bin/bash
# shuts down oracle database on timeout

findProfile() {
if [ ! $# -eq 0 ]
  then
    oraProfile=find $HOME -name "*profile.*${1}"
  else
    echo "Empty parameter. Exit 1"
    exit 1
fi
}

for sid in $@
do
  findProfile $sid
  source "$oraProfile"
  timeout 900 echo "shutdown immediate;" | sqlplus / as sysdba
  rc="$?"
  if [ $rc -eq 124 ]; then
    echo "shutdown abort;" | sqlplus / as sysdba
  elif [ $rc -ne 0 ]; then
    echo "Error while stopping DB"
    exit 1
  elif [ $rc -eq 0 ]; then
    checkMem=$(sysresv -ifd on)
    echo $checkMem | grep "not alive for sid \"$sid\""
    if [ $? -ne 0 ]; then
      echo "Memory was not cleared!"
      exit 1
    fi
  fi
done

exit 0
