#!/bin/bash

RELEASE_NAME=`cat release`

echo "Criando a imagem $RELEASE_NAME"
docker build -t $RELEASE_NAME .

echo "Empurrando a imagem $RELEASE_NAME para o repositorio"
docker push $RELEASE_NAME
