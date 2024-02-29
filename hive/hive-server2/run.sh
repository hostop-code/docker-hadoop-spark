#!/bin/bash

hadoop fs -mkdir -p    /tmp
hadoop fs -mkdir -p    /user/hive/warehouse
hadoop fs -chmod g+w   /tmp
hadoop fs -chmod g+w   /user/hive/warehouse

# $HIVE_HOME/bin/hiveserver2 --hiveconf hive.server2.enable.doAs=false 
# $HIVE_HOME/bin/hiveserver2 --hiveconf hive.server2.enable.doAs=false --hiveconf hive.server2.thrift.port=10000 --verbose
$HIVE_HOME/bin/hiveserver2  --hiveconf hive.server2.enable.doAs=false --hiveconf hive.server2.thrift.port=10000 
# --hiveconf hive.server2.enable.doAs=false

