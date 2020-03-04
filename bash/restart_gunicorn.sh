#!/bin/bash

procs=$(pgrep gunicorn)
if [ -z "$1" ]
then
  app="main:app"
else
  app="$1"
fi

showProcs() {
  if [ -n "$procs" ]
  then
    echo -e "gunicorn processes running:\n$procs"
  else
    echo "no active 'gunicorn' processes"
  fi
}

if [ -n "$procs" ]
then
  showProcs
  pkill gunicorn
  if [ $? -eq "0" ]
  then
    echo "all processes killed"
  else
    echo "ERROR! Could not stop gunicorn! Exiting..."
    exit 1
  fi
  gunicorn $app -b 0.0.0.0:3000 -D -w 3
  if [ $? -eq "0" ]
  then
    echo "gunicorn restarted successfully"
  else
    echo "ERROR! Could not restart gunicorn! Exiting..."
    exit 1
  fi
else
  showProcs
  gunicorn $app -b 0.0.0.0:3000 -D -w 3
  if [ $? -eq "0" ]
  then
    echo "gunicorn started successfully"
  else
    echo "ERROR! COuld not start gunicorn! Exiting..."
    exit 1
  fi
fi
