#!/bin/bash
for i in $1 
	do /usr/local/Cellar/icu4c/59.1_1/bin/uconv -f utf-8 -t utf-8 -x NFC -o ${i%%.*}_nfc.xml $i 
done
