#!/bin/bash

#########################################
####### Backup creation & storage #######
#########################################

#Defining variables for the script
timer=$(date +%s)
today=$(date +"%FT%H%M%z");
db_container=$(sudo docker ps |grep dockerdata_db | awk '{print $1}');

#Creating DB dump and compressing it
echo "Creating database dump from the container $db_container... Please standby, that might take a while."
sudo docker-compose exec db /usr/lib/postgresql/9.6/bin/pg_dumpall -Upostgres |gzip > "AT_test_DB_backup$today".gz
echo "Done!" #Sending to bucket now...

#Sending dump to the S3 bucket
#s3cmd put "AT_test_DB_backup$today".gz s3://audit-tools-db-backup/
#echo "Done! Cleaning up..."

cp "AT_test_DB_backup$today".gz db_backup/

#UNFINISHED script for smth.
#Cleaning up on host
#sudo rm -f "AT_test_DB_backup$today".gz
#echo "Done!"
#echo "Backup completed in $(($(date +%s)-$timer)) seconds. Thank you!"

###############################
####### Backup rotation #######
###############################

#echo "Starting backup rotation..."

#Defining variables
#timer=$(date +%s)
#fotm_backup=$(s3cmd ls s3://audit-tools-db-backup |awk '{print $4}' |grep "\-01" |awk -F / '{print $4}')

#Saving first backup of the month.
#echo "Checking for backup for the first day of the month."
#if [[ $fotm_backup != AT* ]]
#        then echo "Nothing to save or already saved!"
#        else echo "Moving $fotm_backup to another folder..."; s3cmd mv s3://audit-tools-db-backup/$fotm_backup s3://audit-tools-db-backup/fd/$fotm_backup; echo "Done!"
#fi



#echo "Backup rotation completed in $(($(date +%s)-$timer)) seconds. Thank you!"
#s3cmd ls s3://audit-tools-db-backup |grep -v DIR |wc -l
