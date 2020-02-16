FROM maven:3.6.3-jdk-8

RUN apt update && apt upgrade && apt install sudo libxrender1 libxtst6 libxi6 -y

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer 

USER developer
ENV HOME /home/developer

RUN mkdir /home/developer/apps

COPY jappmodeler /home/developer/apps/jappmodeler

CMD /home/developer/apps/jappmodeler/jappmodeler.sh
