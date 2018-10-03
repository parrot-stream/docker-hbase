# **hbase**
___

### Description
___

This image runs the [*Cloudera CDH HBase*](https://www.cloudera.com/products/open-source/apache-hadoop/key-cdh-components.html) on a Centos 7 Linux distribution.

You can pull it with:

    docker pull parrotstream/hbase


You can also find other images based on different Apache Hadoop releases, using a different tag in the following form:

    docker pull parrotstream/hbase:[hbase-release]-[cdh-release]


For example, if you want Apache HBase release 1.2.0 you can pull the image with:

    docker pull parrotstream/hbase:1.2.0-cdh5.11.1


Run with Docker Compose:

    docker-compose -p parrot up


### Available tags:

- Apache HBase 1.2.0-cdh5.11.1 ([1.2.0-cdh5.11.1](https://github.com/parrot-stream/docker-hbase/blob/1.2.0-cdh5.11.1/Dockerfile), [latest](https://github.com/parrot-stream/docker-hbase/blob/latest/Dockerfile))
