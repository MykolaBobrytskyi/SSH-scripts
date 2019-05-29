#!/bin/bash

#####################
### Creating dump ###
#####################

#Defining variables
db_user=
db_pass=
total_disk_usage=$(du -sh |awk '{print $1}')
timer=$(date +%s)
now=$(date +"%FT%H%M%z")
dblist=`mysql -u$db_user -p$db_pass -e "show databases" | sed -n '2,$ p'`

mkdir -p all_backup_$now
cd all_backup_$now

#Creating DB dumps
for db in $dblist; do
	echo "Creating database dump from the base $db... Please standby, that might take a while."
	mysqldump -u$db_user -p$db_pass --routines --triggers $db | gzip --best > ""$db"-"$now.sql.gz""
	echo "Done!"
done

#Copying data
sudo cp -R /var/www/html ~/site_publics ~/site_releases -t ./
sudo chown -R user:group ../all_backup_$now

#Packing it all up and cleaning
tar -zvcf ~/all_backup_$now.tar.gz ./
cd
rm -rf all_backup_$now

echo "Backup completed in $(($(date +%s)-$timer)) seconds."
echo "Total disk space occupied by the home folder with backups: $total_disk_usage"
echo "Download it via SCP using the following command: scp some_user@some_ip:~/all_backup_$now.tar.gz ./"
echo "Thank you!"
