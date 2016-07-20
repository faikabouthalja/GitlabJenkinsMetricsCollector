#!/bin/bash

sed  "/GitLabWebHook getDynamic/!d" /home/ansible/playbook/jenkins.log > /home/ansible/playbook/jenkins0.log
sed "/main build action completed: FAILURE/!d" /home/ansible/playbook/jenkins.log > /home/ansible/playbook/jenkins1.log
sed "/main build action completed: SUCCESS/!d"  /home/ansible/playbook/jenkins.log > /home/ansible/playbook/jenkins2.log

cat /home/ansible/playbook/jenkins0.log > /home/ansible/playbook/jenk2.log
cat /home/ansible/playbook/jenkins1.log >> /home/ansible/playbook/jenk2.log
cat /home/ansible/playbook/jenkins2.log >> /home/ansible/playbook/jenk2.log

nbbuild=`sed -n '/getDynamic/p' /home/ansible/playbook/jenk2.log | wc -l`
nbfailure=`sed -n '/FAILURE/p' /home/ansible/playbook/jenk2.log | wc -l`
nbsuccess=`sed -n '/ SUCCESS/p' /home/ansible/playbook/jenk2.log | wc -l`
curl -i -XPOST "http://localhost:8086/write?db=telegraf&rp=twenty_days" --data-binary "nbsuc,host=jenkins value=${nbsuccess}"
curl -i -XPOST "http://localhost:8086/write?db=telegraf&rp=twenty_days" --data-binary "nberr,host=jenkins value=${nbfailure}"

rm /home/ansible/playbook/jenkins0.log /home/ansible/playbook/jenkins1.log /home/ansible/playbook/jenkins2.log /home/ansible/playbook/jenk2.log
