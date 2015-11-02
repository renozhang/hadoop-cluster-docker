#!/bin/bash

if [ $# -ne 2 ] 
then
    echo "Please use the node number of the cluster as the argument!"
    exit 1
fi

# N is the node number of the total cluster
N=$1

# M is the node number of the hdfs cluster
M=$2


# change the slaves file
echo "# hadoop cluster slave host" > $HADOOP_CONF_DIR/slaves
i=1
while [ $i -le $M ]
do
    echo "slave$i.kiwenlau.com" >> $HADOOP_CONF_DIR/slaves
    ((i++))
done 

$HADOOP_INSTALL/sbin/stop-dfs.sh


# change the slaves file
echo "# hadoop cluster slave host" > $HADOOP_CONF_DIR/slaves
while [ $i -le $N ]
do
    echo "slave$i.kiwenlau.com" >> $HADOOP_CONF_DIR/slaves
    ((i++))
done 

echo -e "\n"
$HADOOP_INSTALL/sbin/stop-yarn.sh
