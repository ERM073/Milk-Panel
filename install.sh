#!/bin/bash
clear
if [ "$EUID" -ne 0 ]; then
   echo "Please run Script as root"
   exit
fi
clear
echo -e '\n'
echo '                                             '
echo ' _|      _|  _|_|_|  _|        _|    _|      '
echo ' _|_|  _|_|    _|    _|        _|  _|        '
echo ' _|  _|  _|    _|    _|        _|_|          '
echo ' _|      _|    _|    _|        _|  _|        '
echo ' _|      _|  _|_|_|  _|_|_|_|  _|    _|      '
echo '                                             '
echo '                                             '
echo -e "\n\n"
echo -n "Do you wish to continue? [Y/n]: "

read continue

case $continue in
n* | N*) exit ;;
esac
################################################################################
# setup passwor
PASSWORD=$(openssl rand -base64 14)
USERNAME='admin'
DB_PASSWORD=$(openssl rand -base64 14)
################################################################################
# Welcome and instructions
echo "It will take a few minits to complate all the installation "

sleep 5
################################################################################
# update repo
sudo apt-get upadate
sudo apt-get upgrade -y
################################################################################
#PHP7.4 PPA
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/apache2 -y
sudo add-apt-repository ppa:ondrej/php -y
################################################################################
#Update the repositories
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y php7.4
################################################################################
#Apache, Php, MySQL and required packages installation
sudo apt-get -y install apache2 php7.4 libapache2-mod-php7.4 php7.4-mcrypt php7.4-curl php7.4-mysql php7.4-gd php7.4-cli php7.4-dev mysql-client php7.4-xml php7.4-zip -y
pear install File_Archive
#this is another package
sudo pecl install mcrypt-1.0.2
sudo apt-get install libapache2-mod-php7.4 -y
sudo apt-get install php7.4-mbstring -y
################################################################################
#The following commands set the MySQL root password to MYPASSWORD123 when you install the mysql-server package.

#Genarate password
DB_PASSWORD=$(openssl rand -base64 16)
PASSWORD=$(openssl rand -base64 16)

sudo debconf-set-selections <<<'mysql-server mysql-server/root_password password '${DB_PASSWORD}
sudo debconf-set-selections <<<'mysql-server mysql-server/root_password_again password '${DB_PASSWORD}
################################################################################
# install mysql server
sudo apt-get -y install mysql-server
################################################################################
#Restart all the installed services to verify that everything is installed properly
printf "\n"
service apache2 restart && service mysql restart >/dev/null
################################################################################
#configure virtual host for milk
printf "\n"
php -v
################################################################################
# check for error
if [ $? -ne 0 ]; then
   printf "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
   #configure v host for milk ip:3000
   ip_add=($(hostname -I))
   declare -p ip_add
   mkdir /var/www/milk/
   chmod 777 /var/www/milk/
   mkdir /var/www/milk/logs/
   chmod 777 /var/www/milk/logs/

   echo '
#configure v host for milk ip:3000
Listen '${ip_add[0]}':3000
<VirtualHost '${ip_add[0]}':3000>
   DocumentRoot "/var/www/milk/"
   ErrorLog /var/www/milk/logs/error.log
</VirtualHost>' >'/etc/apache2/sites-available/milk.conf'

   sudo a2ensite milk
   systemctl reload apache2
   sudo service apache2 restart
   printf "\n"
   echo "
<?php
// this is main config page for milk
define('USERNAME','admin');
define('PASSWORD','"${PASSWORD}"');
define('MILK_FM_PATH','/var/www/html/');
define('BACKUP_DIR','/var/www/milk/backup/');" >"config.php"

   cp -r * /var/www/milk
   mkdir /var/www/milk/backup
   chown www-data -R /var/www/milk/backup
   chmod 755 /var/www/milk/backup
   chown www-data -R /var/www/html
   chown www-data -R /var/www/milk/phpMyAdmin/tmp
   chmod 755 /var/www/milk/phpMyAdmin/tmp

   sudo crontab -l 2 > cron_bkp
   sudo echo "0 18 * * * php /var/www/milk/functions/Backup.php" >> cron_bkp
   sudo crontab cron_bkp
   sudo rm cron_bkp

   clear
   printf "#################################################################\n"
   printf "#                                                                \n"
   printf "#                Milk Panel Is Installed Successfully            \n"
   printf "#                                                                \n"
   printf "#                    server - http://${ip_add[0]}:3000           \n"
   printf "#                    username - admin                            \n"
   printf "#                    Password - $PASSWORD                        \n"
   printf "#                    MySql User - root                           \n"
   printf "#                    MySql Password - $DB_PASSWORD               \n"
   printf "#                                                                \n"
   printf "#################################################################\n"
fi
