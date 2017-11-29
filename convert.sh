#!/bin/bash
for i in $1 
	do xsltproc -o ${i%%.*}_simple.xml MARC21slim2OAIDC-dnb.xsl $i
	mv *_simple.xml simple
done