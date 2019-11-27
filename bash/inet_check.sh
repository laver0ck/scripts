#!/bin/bash
HOST="google.com"
ping -c 1 $HOST > /dev/null 2>&1
RC=$?
if [ "$RC" -eq "0" ]
then
  echo "${HOST} reachable, inet OK"
else
  echo "${HOST} unreachable, check inet"
fi