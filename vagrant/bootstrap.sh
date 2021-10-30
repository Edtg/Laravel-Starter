#!/usr/bin/env bash
# MSSQL
#curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
#curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list


apt-get update

#essentials
apt-get install software-properties-common git vim curl language-pack-en -y

#get latest php repo
add-apt-repository -y ppa:ondrej/php
add-apt-repository -y ppa:chris-lea/redis-server
apt-get update

#apache and mod rewrite module
apt-get install -y apache2
a2enmod rewrite

#php
apt-get install -y php7.4
apt-get install -y php7.4-dev
apt-get install -y libapache2-mod-php7.4
apt-get install -y php7.4-curl
apt-get install -y php7.4-gd
apt-get install -y php7.4-mbstring
apt-get install -y php7.4-dom
apt-get install -y php7.4-zip
apt-get install -y php7.4-xml

apt-get install -y openssl
#Needed for larave 6 as predis is depreciated
apt-get install -y php-redis



# MSSQL
#ACCEPT_EULA=Y apt-get install -y msodbcsql mssql-tools unixodbc-dev
#sudo pecl install sqlsrv
#`wget http://pecl.php.net/get/pdo_sqlsrv-5.3.0.tgz
#`pear install pdo_sqlsrv-5.3.0.tgz
#echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
#echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini
#echo "extension=pdo_sqlsrv.so" >> /etc/php/7.4/apache2/conf.d/30-pdo_sqlsrv.ini
#echo "extension=sqlsrv.so" >> /etc/php/7.4/apache2/conf.d/20-sqlsrv.ini

# Freetds
#apt-get install -y freetds-common
#apt-get install -y freetds-bin
#apt-get install -y php7.4-sybase
#cp /vagrant/vagrant/freetds.conf /etc/freetds/freetds.conf

#redis
apt-get install -y redis-server

#postgres
apt-get install -y php7.4-pgsql
apt-get install -y postgresql postgresql-contrib
useradd app
sudo chpasswd << 'END'
app:app
END
echo "CREATE USER app WITH PASSWORD 'app';" | sudo -u postgres psql
echo "CREATE DATABASE app;" | sudo -u postgres psql
echo "GRANT ALL PRIVILEGES ON DATABASE app to app;" | sudo -u postgres psql

#mysql
#sudo apt-key adv --keyserver pgp.mit.edu --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5
#if the keys are out of date for my sql run the above
# export DEBIAN_FRONTEND=noninteractive
# echo mysql-apt-config mysql-apt-config/select-server select mysql-5.7 | debconf-set-selections
# echo mysql-apt-config mysql-apt-config/repo-codename select xenial | debconf-set-selections
# echo mysql-apt-config mysql-apt-config/repo-distro select ubuntu | debconf-set-selections
# echo mysql-apt-config mysql-apt-config/select-product select Apply | debconf-set-selections
# curl -O http://repo.mysql.com/mysql-apt-config_0.7.3-1_all.deb && dpkg -i mysql-apt-config_0.7.3-1_all.deb
# apt-get update
# apt-get install -y php7.4-mysql
# echo mysql-community-server mysql-community-server/root-pass password PASSWORD | debconf-set-selections
# echo mysql-community-server mysql-community-server/re-root-pass password PASSWORD | debconf-set-selections
# apt-get install -y --allow-unauthenticated mysql-community-server

#mysql database user set up
# echo "create database app" | mysql -u root -pPASSWORD
# echo "CREATE USER 'app'@'%' IDENTIFIED BY 'app'"  | mysql -u root -pPASSWORD
# echo "GRANT ALL ON *.* to 'app'@'%'" | mysql -u root -pPASSWORD
# echo "CREATE USER 'app'@'localhost' IDENTIFIED BY 'app'"  | mysql -u root -pPASSWORD
# echo "GRANT ALL ON *.* to 'app'@'localhost'" | mysql -u root -pPASSWORD



#link site file in vagrant to defualt directory
ln -fs /vagrant /var/www/app

#virtual hosts
rm /etc/apache2/sites-enabled/*
cp /vagrant/vagrant/virtualhost.conf /etc/apache2/sites-enabled/virtualhost.conf


#clean clears out the local repository of retrieved package files.
apt-get clean

#composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#.env
cp /vagrant/vagrant/.env-vagrant /vagrant/.env

cd /vagrant && composer install

systemctl enable redis-server

service apache2 restart
redis-server

# If you want to connect to the database via an external database application i.e dbeaver
# Update the PasswordAuthentication parameter in the /etc/ssh/sshd_config file
# PasswordAuthentication yes
# service ssh restart
#php artisan migrate --seed
