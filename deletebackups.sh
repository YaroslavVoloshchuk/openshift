#!/bin/bash

DIR1=/var/project//Coca-cola/
DIR2=/var/project/SmartLead/
DIR3=/var/project/IBM-UCB/
DIR4=/var/project/Adidas/

for i in $DIR1 $DIR2 $DIR3 $DIR4 ;

do

ls -1tr $i*.zip \
    | head -n -5 \
    | xargs -d '\n' rm -f 

done








