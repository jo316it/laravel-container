#!/bin/bash

# up to variables from env file.
source variables.env

cd $SOURCE_WORKS

echo "What name of project?" 
read PROJECT

if [ -d $PROJECT ]; then
	echo "This directory there "
	echo "Reboot this script to continue..."
	exit 0
fi

git clone $LARAVEL_VERSION $PROJECT

cd $PROJECT

sleep 2

echo "Rename .env of Laravel"

cp .env.example .env

echo "Changing the variable of Database "
sleep 2
sed -i "s|DB_HOST=127.0.0.1|DB_HOST=mysql|g" .env
sed -i "s|DB_DATABASE=laravel|DB_DATABASE=$PROJECT|g" .env  
sed -i "s|DB_PASSWORD=|DB_PASSWORD=root|g" .env 

sleep 2
echo "Copy folder NGINX"
cp -R $NGINX .


sleep 2
echo "Copy DockerFile"
cp -R $DOCKERFILE .
sleep 2


echo "Copy Docker-compose"
cp -R $COMPOSER .
sleep 2

echo "Rename files of NGINX according to $PROJECT"


sleep 5
sed -i "s|laravel:9000|$PROJECT:9000|g" docker/nginx/laravel.conf


echo "Rename files of composer according to $PROJECT"
sleep 2
sed -i "s|laravel|$PROJECT|g" docker-compose.yml

echo "Finished. Run docker-compose on the folder your project"


