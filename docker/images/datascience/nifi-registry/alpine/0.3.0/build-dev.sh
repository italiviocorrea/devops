#!/bin/sh

IMAGE_NAME=`cat release`
echo "Criando a image : ${IMAGE_NAME}" && \
 docker build -t $IMAGE_NAME . && \
 echo "Imagem criada e armazenada com sucesso!"
