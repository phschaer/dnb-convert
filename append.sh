#!/bin/bash
for i in $1
	do sed -i '' 1d $i
	(echo '<?xml version="1.0" encoding="UTF-8"?>
	<marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">'; cat $i) > tmpfile
	echo "</marc:collection>" >> tmpfile 
	mv tmpfile $i
done


