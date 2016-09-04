#!/bin/bash

rm /etc/ssh/*key* 2> /dev/null
rm /root/.ssh/id_rsa 2> /dev/null
 
ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key; \
ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key; \
ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key; \
ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key; \
ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa; \
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

rm /tmp/*.pid 2> /dev/null

wait-for-it.sh zookeeper:2181 -t 40

rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "      ZooKeeper not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

wait-for-it.sh hadoop:8020 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "      HDFS not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

hdfs dfsadmin -safemode leave

supervisorctl start sshd

wait-for-it.sh localhost:22 -t 60
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "      SSH not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start master
supervisorctl start regionserver

wait-for-it.sh localhost:60010 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e " HBase Master not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

wait-for-it.sh localhost:60030 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n-----------------------------------------"
    echo -e "HBase Region Server not ready! Exiting..."
    echo -e "-----------------------------------------"
    exit $rc
fi

supervisorctl start rest

wait-for-it.sh localhost:8080 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "   HBase Rest not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start thrift

wait-for-it.sh localhost:9090 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  HBase Thrift not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi


ip=`awk 'END{print $1}' /etc/hosts`

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following HBase Web UIs:"
echo -e ""
echo -e "HBase Master           http://$ip:60010"
echo -e "HBase Region Server    http://$ip:60030\n"
echo -e "Mantainer: Matteo Capitanio <matteo.capitanio.gmail.com>"
echo -e "--------------------------------------------------------------------------------\n\n"



