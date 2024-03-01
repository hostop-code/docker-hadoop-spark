#!/bin/bash

# hadoop fs -mkdir -p    /tmp
# hadoop fs -mkdir -p    /user/hive/warehouse
# hadoop fs -chmod g+w   /tmp
# hadoop fs -chmod g+w   /user/hive/warehouse

$HIVE_HOME/bin/hiveserver2  hiveserver2 --hiveconf hive.root.logger=DEBUG,console

