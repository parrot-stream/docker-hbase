#!/bin/bash

rm /tmp/*.pid 2> /dev/null

exec start-hbase.sh
