FROM mcapitanio/centos-java:7-7u80

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

ENV HBASE_VER 1.2.2

ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV no_proxy ${no_proxy}

ENV HBASE_HOME /opt/hbase
ENV HBASE_CONF_DIR $HBASE_HOME/conf

ENV PATH $HBASE_HOME/bin:$PATH

# Install needed packages
RUN yum clean all; yum update -y; yum clean all
RUN yum install -y ant which openssh-clients openssh-server openssl python-setuptools
RUN easy_install supervisor

WORKDIR /opt/docker

# Apache HBase
RUN wget http://mirror.nohup.it/apache/hbase/$HBASE_VER/hbase-$HBASE_VER-bin.tar.gz
RUN tar -xvf hbase-$HBASE_VER-bin.tar.gz -C ..; \
    mv ../hbase-$HBASE_VER ../hbase

COPY hbase/ $HBASE_HOME/
COPY ./etc /etc
RUN chmod +x $HBASE_HOME/conf/hbase-env.sh
RUN chmod +x $HBASE_HOME/bin/*.sh

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

RUN useradd -p $(echo "hbase" | openssl passwd -1 -stdin) hbase; \
    useradd -p $(echo "hdfs" | openssl passwd -1 -stdin) hdfs; \
    groupadd supergroup; \
    usermod -a -G supergroup hdfs; \
    usermod -a -G supergroup hbase; \
    usermod -a -G hdfs hbase;

EXPOSE 60010 60030

VOLUME [ "/opt/hbase/logs", "/opt/hbase/conf" ]

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
