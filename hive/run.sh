#!/bin/bash

# hadoop fs -mkdir -p    /tmp
# hadoop fs -mkdir -p    /user/hive/warehouse
# hadoop fs -chmod g+w   /tmp
# hadoop fs -chmod g+w   /user/hive/warehouse

# $HIVE_HOME/bin/schematool -dbType postgres -validate

# if [ $? -eq 0 ]; then
#     echo "Metadata found, skipping schema initialization..."
    
# else
#     echo "Metadata data not found, initializing schema..."
#     $HIVE_HOME/bin/schematool -dbType postgres -initSchema --verbose
#     $HIVE_HOME/bin/schematool -dbType postgres -info
# fi
