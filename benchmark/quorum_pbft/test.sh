#!/bin/bash

i=0
httpPort=22000

QUO_DATA=/odyssey/IBFT-Network

for ((; i<$1; i++)); do
  echo "start node $i"
  let nodeHttpPort=$httpPort+$i
  echo "${QUO_DATA}/Node-$i"
  echo "http port: $nodeHttpPort"

  cd ${QUO_DATA}/Node-$i
    let j=$i+1
    echo "172.1.1.$j"
done