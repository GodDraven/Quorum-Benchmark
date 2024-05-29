#!/bin/bash
#nodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

# echo "start-all.sh"
# rm -rf addPeer.txt
# ./gather.sh $1 
# sleep 3

# i=0
# for host in `cat $HOSTS`; do
#   if [[ $i -lt $1 ]]; then
#     ssh -oStrictHostKeyChecking=no  $host $QUO_HOME/start-mining.sh $i
#     echo done node $host
#   fi
#   let i=$i+1
# done

# i=0
# for host in `cat $HOSTS`; do
#   if [[ $i -lt $1 ]]; then
#     ssh -oStrictHostKeyChecking=no  $host $QUO_HOME/start-addPeer.sh $i
#     echo done node $host
#   fi
#   let i=$i+1
# done

# test in local docker container
i=0
httpPort=22000
wePort=32000
port=30300

for ((; i<$1; i++)); do
  echo "start node $i"
  let nodeHttpPort=$httpPort+$i
  let nodeWePort=$wePort+$i
  let nodePort=$port+$i

  cd ${QUO_DATA}/Node-$i

  # echo "nodeHttpPort=$nodeHttpPort"
  # echo "nodeWePort=$nodeWePort"
  # echo "nodePort=$nodePort"

  export ADDRESS=$(grep -o '"address": *"[^"]*"' ./data/keystore/accountKeystore | grep -o '"[^"]*"$' | sed 's/"//g')
  export PRIVATE_CONFIG=ignore
  nohup  ${QUORUM} --datadir data \
    --networkid 1337 --nodiscover --verbosity 5 \
    --syncmode full \
    --istanbul.blockperiod 5 --mine --miner.threads 1 --miner.gasprice 0 --emitcheckpoints \
    --http --http.addr 127.0.0.1 --http.port $nodeHttpPort --http.corsdomain "*" --http.vhosts "*" \
    --ws --ws.addr 127.0.0.1 --ws.port $nodeWePort --ws.origins "*" \
    --http.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --ws.api admin,eth,debug,miner,net,txpool,personal,web3,istanbul \
    --unlock ${ADDRESS} --allow-insecure-unlock --password ./data/keystore/accountPassword \
    --port ${nodePort} \
    > $QUO_DATA/Node-$i/data/log 2>&1 &
done