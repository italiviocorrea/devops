#!/bin/sh

IMAGE_NAME=`cat release`
REGISTRY="repo.ms.gov.br"
echo "Criando a image : ${IMAGE_NAME}" && \ 
 docker build -t $IMAGE_NAME . && \
 echo "Criando tag : ${REGISTRY}/${IMAGE_NAME}"  && \
 docker tag $IMAGE_NAME $REGISTRY/$IMAGE_NAME && \
 echo "Empurrando a imagem para o repositório : ${REGISTRY}/${IMAGE_NAME}"  && \
 docker push $REGISTRY/$IMAGE_NAME && \
 echo "Imagem criada e armazenada com sucesso!"
