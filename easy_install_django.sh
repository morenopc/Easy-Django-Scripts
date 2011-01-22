#!/bin/sh

####################################
# Script Name: Easy Install Django #
# Author: Moreno Cunha             #
# Version 1.0                      #
# @Ubuntu 10.04 LTS Lucid Lynx     #
####################################

mysql_root_pwd=''

sudo apt-get -y install python-django
sudo apt-get -y install mysql-server python-mysqldb
echo '\n'
echo 'To continue the instalation we need create a mySQL django new user'
echo 'Please enter mySQL root password or "q" to quit:'
read mysql_root_pwd
if [ "$mysql_root_pwd" = "q" ] || [ "$mysql_root_pwd" = "Q" ]
then
    echo 'exit'
    exit
fi
echo '\n'
echo 'Your Django MySQL user is: django'
echo 'Your Django MySQL user password is: dj2ango4'
echo '\n'
mysql -u root -p$mysql_root_pwd < create_user_db.sql
echo 'Creating Django Hello World project...'
mkdir ~/django
cd ~/django
django-admin startproject HelloWorld
cd ~/django/HelloWorld
sed s/DATABASE_ENGINE\ =\ \'\'/DATABASE_ENGINE\ =\ \'mysql\'/ <settings.py >_settings.py
cat _settings.py > settings.py
sed s/DATABASE_NAME\ =\ \'\'/DATABASE_NAME\ =\ \'django\'/ <settings.py >_settings.py
cat _settings.py > settings.py
sed s/DATABASE_USER\ =\ \'\'/DATABASE_USER\ =\ \'django\'/ <settings.py >_settings.py
cat _settings.py > settings.py
sed s/DATABASE_PASSWORD\ =\ \'\'/DATABASE_PASSWORD\ =\ \'dj2ango4\'/ <settings.py >_settings.py
cat _settings.py > settings.py
rm _settings.py
echo 'Now answer the questions'
python manage.py syncdb
python manage.py runserver
#firefox http://127.0.0.1:8000/
