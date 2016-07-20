#!/bin/bash

cd /home/ansible/projetFriendscoach
git shortlog -s -n > /home/ansible/gitlog.log

awk 'BEGIN { FS = " "}
        { print $1 ":" $2 }
' /home/ansible/gitlog.log > /home/ansible/finalloggit.log

tab1=( $( awk -F ":" '{print $2}' /home/ansible/finalloggit.log) )
tab2=( $( awk -F ":" '{print $1}' /home/ansible/finalloggit.log) )
nbUser=${#tab1[@]}
i=0
while [ "$i" -lt "$nbUser" ]
do
curl -i -XPOST "http://localhost:8086/write?db=telegraf&rp=twenty_days" --data-binary "FriendsCoachcommit_${tab1[$i]},host=jenkins value=${tab2[$i]}"
        ((i++))
    done
rm /home/ansible/gitlog.log /home/ansible/finalloggit.log
