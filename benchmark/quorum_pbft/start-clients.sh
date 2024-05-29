#!/bin/bash
# args=THREADS, index of clients, number of nodes, txrate
# 5 5 5 100
echo IN START_CLIENTS $1 $2 $3 $4

cd `dirname ${BASH_SOURCE-$0}`
. env.sh

#..
# export CPATH=/usr/dinhtta/local/include
# export LIBRARY_PATH=/usr/dinhtta/local/lib:$LIBRARY_PATH
# export LD_LIBRARY_PATH=/usr/dinhtta/local/lib:$LD_LIBRARY_PATH
#..

export CPATH=/usr/local/include
export LIBRARY_PATH=/usr/local/lib:$LIBRARY_PATH
# rocksdb lib
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

LOG_DIR=$LOG_DIR/exp_$3"_"servers_$1"_"threads_$4"_"rates
mkdir -p $LOG_DIR
i=0
# for host in `cat $HOSTS`; do
#   let n=i/2
#   let i=i+1
#   if [[ $n -eq $2 ]]; then
#     cd $EXE_HOME
#     #both ycsbc and smallbank use the same driver
#     nohup ./driver -db ethereum -threads $1 -P workloads/workloadb.spec -endpoint $host:8000 -txrate $4 > $LOG_DIR/client_$host"_"$1 2>&1 &
#   fi
# done

httpPort=22000
for ((j=0; j<$3; j++)); do
  let nodeHttpPort=$httpPort+$j
  cd $EXE_HOME
  nohup ./driver -db ethereum -threads $1 -endpoint 127.0.0.1:$nodeHttpPort -txrate $4 > $LOG_DIR/client_node$j"_"$1 2>&1 &
  echo "call 127.0.0.1:$nodeHttpPort"
done