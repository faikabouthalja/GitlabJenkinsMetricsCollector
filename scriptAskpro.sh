#!/bin/bash

cd /home/ansible/projetAskpro
git shortlog -s -n > /home/ansible/gitlogA.log

awk 'BEGIN { FS = " "}
        { print $1 ":" $2 }
' /home/ansible/gitlogA.log > /home/ansible/finalloggitA.log

tab1=( $( awk -F ":" '{print $2}' /home/ansible/finalloggitA.log) )
tab2=( $( awk -F ":" '{print $1}' /home/ansible/finalloggitA.log) )
nbUser=${#tab1[@]}
i=0
while [ "$i" -lt "$nbUser" ]
do
curl -i -XPOST "http://localhost:8086/write?db=telegraf&rp=twenty_days" --data-binary "Askproncommit_${tab1[$i]},host=jenkins value=${tab2[$i]}"
        ((i++))
    done

rm /home/ansible/gitlogA.log /home/ansible/finalloggitA.log
