#!/bin/bash

supervisorctl start hbase-master
supervisorctl start hbase-regionserver

/wait-for-it.sh localhost:60010 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e " HBase Master not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

/wait-for-it.sh localhost:60030 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n-----------------------------------------"
    echo -e "HBase Region Server not ready! Exiting..."
    echo -e "-----------------------------------------"
    exit $rc
fi

supervisorctl start hbase-rest
/wait-for-it.sh localhost:8080 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "   HBase Rest not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start hbase-thrift
/wait-for-it.sh localhost:9090 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  HBase Thrift not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following HBase Web UIs:"
echo -e ""
echo -e "HBase Master           http://localhost:60010"
echo -e "HBase Region Server    http://localhost:60030\n"
echo -e "Mantainer: Matteo Capitanio <matteo.capitanio.gmail.com>"
echo -e "--------------------------------------------------------------------------------\n\n"

