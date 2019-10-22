#!/bin/bash
# simple password generator for bash

MATRIX="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
LENGTH="8" # change for longer passwords

while [ "${n:=1}" -le "$LENGTH" ]
do
    PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"

    let n+=1
done

echo "$PASS" # may also redirect

exit 0