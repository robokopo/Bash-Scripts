#!/bin/bash

# Created by robokopo
# Script created during Jamf Expert training to automate process of installation Jamf Pro and restoring DB backup

file="/tmp/jamfproinstaller.run"

if [ ! -f "$file" ]
then
	echo "Jamf Pro installer missing from /tmp/ location..."
	exit 0
else
#hostname has to be set before as restart is required
#echo "Setting up hostname yoda.local"
#apt -y install avahi-daemon > /dev/null 2>&1
#hostnamectl set-hostname yoda
#sh -c "echo '127.0.1.1 yoda.local' >> /etc/hosts"
echo "Checking for updates..."
apt update > /dev/null 2>&1
echo "Done..."
echo "Installing OpenJDK..."
apt -y install openjdk-8-jdk > /dev/null 2>&1
update-ca-certificates -f > /dev/null 2>&1
apt update > /dev/null 2>&1
echo "Done..."
echo "Installing MySQl..."
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password jamf1234'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password jamf1234'
apt -y install mysql-server > /dev/null 2>&1
apt update > /dev/null 2>&1
echo "Done..."
echo "Creating Jamf Pro Database"
tee /tmp/my.cnf << EOF
[client]
user = root
password = jamf1234
EOF
mysql --defaults-file=/tmp/my.cnf -e "CREATE DATABASE jamfsoftware"
mysql --defaults-file=/tmp/my.cnf -e "GRANT ALL ON jamfsoftware.* TO jamfsoftware@localhost IDENTIFIED BY 'jamfsw03'"
echo "Done..."
echo "Restoring DB backup..."
mysql -uroot -pjamf1234 jamfsoftware < /tmp/JamfBackup.sql
echo "Installing Jamf Pro 10.5"
#Couldn't find how to install JPS silently
bash /tmp/jamfproinstaller.run
echo "Done. Access Jamf Pro on https://yoda.local:8443 or https://172.16.16.102:8443"
fi
exit 0