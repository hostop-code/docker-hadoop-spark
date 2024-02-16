#!/bin/bash

# For Service Spark 
hadoop fs -mkdir -p    /user/spark/spark2-history
hadoop fs -chmod g+w   /user/spark/spark2-history

hadoop fs -mkdir -p    /user/test/tets2


$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR nodemanager
