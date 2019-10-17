#!/bin/bash

findProfile() {
if [ ! $# -eq 0 ]
  then
    profilesNum=find $HOME -name "*profile.*${1}" | wc -l
    if [ "$profilesNum" -eq 1 ]; then
      profileName=find $HOME -name "*profile.*${1}"
      sidname=$(cat "$profileName" | grep 'ORACLE_SID=' | awk -F= '{print $2}' | awk '{print $1}' | sed 's/;//g')
      if [ "$sidname" != "${1}" ]; then
        echo "SID in profile and SID param are not equal!Exit 1"
        exit 1
      fi
    elif [ "$profilesNum" -gt 1 ]; then
      echo "More than one profile found for this SID"
      exit 1
    else
      echo "No profiles found. Exit 1"
      exit 1
    fi
  else
    echo "Empty parameter. Exit 1"
    exit 1
fi
}

for sid in $@
do
  findProfile $sid
  source "$profileName"
  timeout 300 echo "startup;" | sqlplus / as sysdba
  rc="$?"
  if [ $rc -eq 124 ]; then
    echo "DB startup timeout exceeded -- DBA attention needed"
    exit 1
  elif [ $rc -ne 0 ]; then
    echo "DB startup failed with error -- DBA attention needed"
    exit 1
  fi
done

echo "all DBs started successfully"
exit 0