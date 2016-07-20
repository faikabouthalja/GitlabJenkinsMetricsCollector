
Playbook programmé en cron job exécuté chaque minute pour exécuter les script de collecte des métriques de Gitlab et de Jenkins
==> il suffit de:
1) placer ce playbook et les scripts shell sous /home/ansible/playbook 
2) Dans le playbook modifier les champs <username>:<password> en insérant le username et le password de Gitlab pour cloner les projet
3) crontab -e
4) entrer ces 2 lignes:
	#Ansible: lancer playbook
	* * * * * ansible-playbook /home/ansible/playbook/playbook.yml
