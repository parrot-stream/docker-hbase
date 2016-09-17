# **hbase**
___

### Description
___

This image runs the official [*Apache HBase*](http://hbase.apache.org) in a **pseudo-distributed** mode on a Centos Linux distribution. The image is based on the [***mcapitanio/centos-java***](https://hub.docker.com/r/mcapitanio/centos-java) and needs a running [**Hadoop**](https://hub.docker.com/r/mcapitanio/hadoop) container to work. You don't need to care about this dependency: if you are going to start HBase using the provided **docker-compose.yml** file, it will be done for you!

The *latest* tag of this image is build with the [latest stable](http://www.apache.org/dyn/closer.cgi/hbase/) release of Apache HBase on Centos 7.

You can pull it with:

    docker pull mcapitanio/hbase


You can also find other images based on different Apache HBase releases, using a different tag in the following form:

    docker pull mcapitanio/hbase:[hbase-release]


For example, if you want Apache HBase release 0.98.21 you can pull the image with:

    docker pull mcapitanio/hbase:0.98.21

Run with Docker Compose:

    docker-compose -p docker up

Setting the project name to *docker* with the **-p** option is useful to share the named data volumes created with with the containers created with other docker-compose.yml configurations (for example the one of the [Hadoop Docker image](https://hub.docker.com/r/mcapitanio/hadoop/)).

Once started you'll be able to read the list of all the HBase Web GUIs urls:

| **HBase Web UIs**      |**URL**                    |
|:-----------------------|:--------------------------|
| *HBase Master*         | http://localhost:60010    |
| *HBase Region Server*  | http://localhost:60030    |

There are 2 named volumes defined:

- **hbase_conf** wich points to HBASE_CONF_DIR
- **hbase_logs** which points to HBASE LOG_DIR

Setting the project name to *docker*, the volumes will be named *docker_hbase_conf* and *docker_hbase_logs*.

### Available tags:

- Apache HBase 1.2.3 ([1.2.3](https://github.com/mcapitanio/docker-hbase/blob/1.2.3/Dockerfile), [latest](https://github.com/mcapitanio/docker-hbase/blob/latest/Dockerfile))
- Apache HBase 1.2.2 ([1.2.2](https://github.com/mcapitanio/docker-hbase/blob/1.2.2/Dockerfile))
