<<<<<<< HEAD
#!/bin/bash

RELEASE_NAME=`cat release`

echo "Criando a imagem $RELEASE_NAME"
docker build -t $RELEASE_NAME .

echo "Empurrando a imagem $RELEASE_NAME para o repositorio"
docker push $RELEASE_NAME
=======
#!/bin/sh

IMAGE_NAME=`cat release`
echo "Criando a image : ${IMAGE_NAME}" && \ 
 docker build -t $IMAGE_NAME . && \
 echo "Empurrando a imagem para o repositório : ${IMAGE_NAME}"  && \
 docker push $IMAGE_NAME && \
 echo "Imagem criada e armazenada com sucesso!"
>>>>>>> Ajuste no projeto jappmodeler, adição imagens nginx e openproject.
