FROM ubuntu:16.04

ENV HBASE_VER 1.2.0+cdh5.11.1

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

ENV IMPALA_VER 2.8.0+cdh5.11.1
ENV HADOOP_VER 2.6.0+cdh5.11.1

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64/

USER root

WORKDIR /opt/docker

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y wget apt-transport-https python-setuptools openjdk-8-jdk apt-utils sudo
RUN easy_install supervisor
RUN wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb
RUN dpkg -i cdh5-repository_1.0_all.deb
RUN apt-get update -y
RUN apt-get install -y --allow-unauthenticated hbase-master=$HBASE_VER* hbase-regionserver=$HBASE_VER* hbase-rest=$HBASE_VER* hbase-thrift=$HBASE_VER*

RUN groupadd supergroup; \    
    usermod -a -G supergroup hbase

ADD etc/supervisord.conf /etc/
ADD etc/hbase/conf/hbase-site.xml /etc/hbase/conf/

# Various helper scripts
ADD bin/start-hbase.sh ./
ADD bin/supervisord-bootstrap.sh ./
ADD bin/wait-for-it.sh ./
RUN chmod +x ./*.sh

EXPOSE 8080 8085 9090 9095 60000 60010 60020 60030

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
