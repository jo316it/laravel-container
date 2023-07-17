#!/bin/bash

# Functions test 
function check_docker_compose() {
  # Verify if Docker is installed.

  if ! docker --version > /dev/null 2>&1; then
    echo "O Docker não está instalado."
    return 1
  fi

  # Verify if Docker Compose is installed.
  if ! docker-compose --version > /dev/null 2>&1; then
    echo "O Docker Compose não está instalado."
    return 1
  fi

  echo "O Docker e o Docker Compose estão instalados."

}


echo "Befor to begin we gonna see if Docker and Docker Compose are installed"


if check_docker_compose; then
  echo "Docker and Docker Compose okk."
  sleep 2
else
  echo "The Docker and Docker Compose doesn't intalled. Install first and comming up"
  exit 1
fi

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





