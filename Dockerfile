FROM mcapitanio/centos-java

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

# Enable proxy settings in the container, assuming that the Host is a Linux VirtualBox
# with cntlm running on port 3128 on the default ip 10.0.2.2 (you have to change if different)
ENV http_proxy ""
ENV https_proxy ""

ENV HBASE_VER 1.2.2
ENV HBASE_HOME /opt/hbase
ENV HBASE_CONF_DIR $HBASE_HOME/conf

ENV PATH $HBASE_HOME/bin:$PATH

# Install needed packages
RUN yum clean all; yum update -y; yum clean all
RUN yum install -y which openssh-clients

WORKDIR /opt/docker

# Apache HBase
RUN wget http://mirror.nohup.it/apache/hbase/$HBASE_VER/hbase-$HBASE_VER-bin.tar.gz
RUN tar -xvf hbase-$HBASE_VER-bin.tar.gz -C ..; \
    mv ../hbase-$HBASE_VER ../hbase

COPY hbase/conf $HBASE_HOME/conf

VOLUME [ "/opt/hbase/logs", "/opt/hbase/conf" ]

COPY docker-entrypoint.sh $HBASE_HOME/bin
RUN chmod +x $HBASE_HOME/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
