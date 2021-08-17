#!/bin/bash

DIR=/var/ftphome/inventory/

for i in `find $DIR -name *_Failed -type d` ;
 do

filecount=`find $i -type f | wc -l`

if [ $filecount -eq 0 ];
then
echo -e "Folder" "$i" "is empty" "\n"
else
echo -e "Folder" "$i" "has some file(s) failed to be processed:" "$filecount" "\n" ;
fi
done



