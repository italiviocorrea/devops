#!/bin/sh

IMAGE_NAME=`cat release`
cho "Criando a image : ${IMAGE_NAME}" && \ 
 docker build -t $IMAGE_NAME . && \
 echo "Criando tag : ${IMAGE_NAME}"  && \
 docker push $IMAGE_NAME && \
 echo "Imagem criada e armazenada com sucesso!"
