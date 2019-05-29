#!/bin/bash

#####################
### Creating dump ###
#####################

#Entering the folder where dumps will be stored
cd /home/prod/DBbackup

#Defining variables
total_disk_usage=$(du -sh |awk '{print $1}')
timer=$(date +%s)
now=$(date +"%FT%H%M%z");
dblist=`mysql -uroot -pfxnrjdjrjtyjj -e "show databases" | sed -n '2,$ p'`

#Creating dumps
for db in $dblist; do
	echo "Creating database dump from the base $db... Please standby, that might take a while."
	mysqldump -uroot -pfxnrjdjrjtyjj --routines --triggers $db | gzip --best > ""$db"-"$now.sql.gz""
	echo "Done!"
done

######################
### Dumps rotation ###
######################

#Removing dumps older than 7 days
find /home/prod/DBbackup -mtime +7 -exec /bin/rm {} \;

echo "Backup with rotation completed in $(($(date +%s)-$timer)) seconds."
echo "Total disk space occupied by backups: $total_disk_usage"
echo "Thank you!"
