#!/bin/bash

#rm /etc/ssh/*key* 2> /dev/null
#rm /root/.ssh/id_rsa 2> /dev/null
 
#ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key; \
#ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key; \
#ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key; \
#ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key; \
#ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa; \
#cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

#rm /tmp/*.pid 2> /dev/null

#wait-for-it.sh zookeeper:2181 -t 40
#rc=$?
#if [ $rc -ne 0 ]; then
#    echo -e "\n---------------------------------------"
#    echo -e "      ZooKeeper not ready! Exiting..."
#    echo -e "---------------------------------------"
#    exit $rc
#fi

#wait-for-it.sh hadoop:8020 -t 120
#rc=$?
#if [ $rc -ne 0 ]; then
#    echo -e "\n---------------------------------------"
#    echo -e "      HDFS not ready! Exiting..."
#    echo -e "---------------------------------------"
#    exit $rc
#fi

#hdfs dfsadmin -safemode leave

#supervisorctl start sshd

#wait-for-it.sh localhost:22 -t 60
#rc=$?
#if [ $rc -ne 0 ]; then
#    echo -e "\n---------------------------------------"
#    echo -e "      SSH not ready! Exiting..."
#    echo -e "---------------------------------------"
#    exit $rc
#fi

/opt/docker/start-hbase.sh


