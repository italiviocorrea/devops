FROM yugabytedb/yugabyte:2.2.0.0-b80

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"


RUN yum update -y && \
    yum -y install ntp && \
    yum autoremove -y && \
    yum -y install tzdata && \
    yum clean all && \
    ln -sf /usr/share/zoneinfo/America/Campo_Grande /etc/localtime && \
    echo "export LANG=pt_BR.UTF-8" > /etc/profile.d/locale.sh && \
    echo "America/Campo_Grande" >  /etc/timezone && \
    sed -i 's/en_US/pt_BR/g' /etc/yum.conf && \
    yum -y reinstall glibc-common 

ENV LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8


RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# Configuring and enabling NTPD
COPY ntpd.conf /etc/ntpd.conf

