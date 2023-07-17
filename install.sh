#!/bin/bash

source variables.env

cd $SOURCE_WORKS

echo "Quando será o nome do projeto? " 
read PROJECT

if [ -d $PROJECT ]; then
	echo "Este diretório já existe, escolha outro nome..."
	echo "Reinicie o script"
	exit 0
fi

git clone -b v8.6.11 https://github.com/laravel/laravel.git $PROJECT

cd $PROJECT

sleep 2

echo "Renomeando arquivo .env"

cp .env.example .env

echo "Alterando variavel do banco de dados para mysql"
sleep 2
sed -i "s|DB_HOST=127.0.0.1|DB_HOST=mysql|g" .env
sed -i "s|DB_DATABASE=laravel|DB_DATABASE=$PROJECT|g" .env  
sed -i "s|DB_PASSWORD=|DB_PASSWORD=root|g" .env 

sleep 2
echo "Copiando pasta do NGINX"
cp -R $NGINX .


sleep 2
echo "Copiando o DockerFile"
cp -R $DOCKERFILE .
sleep 2


echo "Copiando o composer"
cp -R $COMPOSER .
sleep 2

echo "Renomeando arquivos do NGINX conforme $PROJECT"


sleep 5
sed -i "s|laravel:9000|$PROJECT:9000|g" docker/nginx/laravel.conf


echo "Renomeando arquivos do compose conforme $PROJECT"
sleep 2
sed -i "s|laravel|$PROJECT|g" docker-compose.yml

echo "Finalziado, rode docker-compose up -d para inicialziar o servidor."


