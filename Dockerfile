FROM mcapitanio/hadoop

ENV HBASE_VER 1.2.3

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV no_proxy ${no_proxy}

ENV HBASE_HOME /opt/hbase
ENV HBASE_CONF_DIR $HBASE_HOME/conf

ENV PATH $HBASE_HOME/bin:$PATH

# Install needed packages
RUN yum update -y; yum clean all

WORKDIR /opt/docker

# Apache HBase
RUN wget http://archive.apache.org/dist/hbase/$HBASE_VER/hbase-$HBASE_VER-bin.tar.gz
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
    usermod -a -G supergroup hbase

EXPOSE 8080 8085 9090 9095 60000 60010 60020 60030

VOLUME [ "/opt/hbase/logs", "/opt/hbase/conf" ]

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
