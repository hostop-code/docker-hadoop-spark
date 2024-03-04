#!/bin/bash

# For Service Spark 
hadoop fs -mkdir -p    /apps/spark/spark2-history
hadoop fs -chmod g+w   /apps/spark/spark2-history

# For Service Tez
hadoop fs -mkdir -p    /apps/tez/
hadoop fs -put ${TEZ_HOME}/share/tez.tar.gz /apps/tez

hadoop fs -mkdir -p    /apps/test/


$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR nodemanager
