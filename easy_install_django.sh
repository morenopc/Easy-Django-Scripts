#!/bin/sh

####################################
# Script Name: Easy Install Django #
# Author: Moreno Cunha             #
# Version 1.2                      #
# @Ubuntu 11.04 Natty Narwhal      #
# Django Version 1.2.5 final       #
####################################

mysql_root_pwd=''

# Install django and mysql packages
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
# Creating Django user and Table
mysql -u root -p$mysql_root_pwd < create_user_db.sql
echo '\n'
echo 'Your Django MySQL user is: django'
echo 'Your Django MySQL user password is: dj2ango4'
echo '\n'
echo 'Creating Django Hello World project...'
mkdir ~/django
cd ~/django

# Create and configuring Django Hello World project
django-admin startproject HelloWorld
cd ~/django/HelloWorld
django_version=$(./manage.py --version)
if [ "$django_version" = "1.2.5" ]
then
    # sed s/regexp/replacement/
    sed s/\'ENGINE\':\ \'django.db.backends.\'/\'ENGINE\':\ \'django.db.backends.mysql\'/ <settings.py >_settings.py
    cat _settings.py > settings.py
    sed s/\'NAME\':\ \'\'/\'NAME\':\ \'django\'/ <settings.py >_settings.py
    cat _settings.py > settings.py
    sed s/\'USER\':\ \'\'/\'USER\':\ \'django\'/ <settings.py >_settings.py
    cat _settings.py > settings.py
    sed s/\'PASSWORD\':\ \'\'/\'PASSWORD\':\ \'dj2ango4\'/ <settings.py >_settings.py
    cat _settings.py > settings.py
else
    sed s/DATABASE_ENGINE\ =\ \'\'/DATABASE_ENGINE\ =\ \'mysql\'/ <settings.py >_settings.py
    cat _settings.py > settings.py
    sed s/DATABASE_NAME\ =\ \'\'/DATABASE_NAME\ =\ \'django\'/ <settings.py >_settings.py
    cat _settings.py > settings.py
    sed s/DATABASE_USER\ =\ \'\'/DATABASE_USER\ =\ \'django\'/ <settings.py >_settings.py
    cat _settings.py > settings.py
    sed s/DATABASE_PASSWORD\ =\ \'\'/DATABASE_PASSWORD\ =\ \'dj2ango4\'/ <settings.py >_settings.py
    cat _settings.py > settings.py
fi
rm _settings.py
echo 'Now answer the questions'
python manage.py syncdb
python manage.py runserver
#firefox http://127.0.0.1:8000/
