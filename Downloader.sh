#!/bin/bash

index=1
myFile=$1
directoryName=$(echo ${myFile##*/} | grep -oP '.*(?=\.)')
mkdir image/$directoryName

while IFS='' read -r line || [[ -n "$line" ]]; do
	myURL=$line
    picExtension=$(echo ${myURL##*/} | grep -oP '[^.]+$' | tr '[:upper:]' '[:lower:]' | grep -oP '(jpg|jpeg|png|gif)')
    echo $picExtension
    fileName="$index.$picExtension"
    wget --tries=1 --read-timeout=5 $line -O ./image/$directoryName/$fileName
    index=$(expr $index + 1)
done < "$1"