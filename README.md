# Benchmark Introduction

The benchmark is based on an open source benchmark [BlockBench](https://github.com/ooibc88/blockbench) for [quorum](https://github.com/Consensys/quorum). It includes a few shell scripts to deploy quorum nodes automatically and launch a set of clients to interact with quorum nodes.

This version is based on an existing private network in a local machine.

## Workloads 
[Macro benchmark workloads](src/macro) is to evaluate the overall performance and [micro benchmark workloads](src/micro) is to evaluate performance of individual layers.

### Macro-benchmark

* YCSB (KVStore).
* SmallBank (OLTP).

### Micro-benchmark

* DoNothing (consensus layer).
* IOHeavy (data model layer, read/write oriented).
* Analytics (data model layer, analytical query oriented).
* CPUHeavy (execution layer).

## Source file structure

+ Smart contract sources are in [benchmark/contracts](benchmark/contracts) directory.
+ Instructions and scripts to run benchmarks for Quorum are in [quorum_pbft](benchmark/quorum_pbft), [quorum_raft](benchmark/quorum_raft) and [quorum_vote](benchmark/quorum_vote) directories respectively.
+ Drivers for benchmark workloads are in [src](src) directory.

## Dependency

### C++ libraries
* [restclient-cpp](https://github.com/mrtazz/restclient-cpp)

  Note: we patched this library to include the "Expect: " header in POST requests, which considerably improves the speed for
  processing RPC request at Parity. 

    + The patch file is include in [benchmark/parity](benchmark/parity) folder.
    + To patch: go to top-level directory of restclient-cpp, then:

        `patch -p4 < $BLOCK_BENCH_HOME/benchmark/parity/patch_restclient`

    + The installation can then proceed as normal. 

* [libcurl](https://curl.haxx.se/libcurl/)

## Usage
* Compile application to generate binary file "driver"
* Deploy a private quorum network in a local machine referring to [Use IBFT | GoQuorum](https://docs.goquorum.consensys.io/tutorials/private-network/create-ibft-network)
* Modify parameters in [env.sh](benchmark/quorum_pbft/env.sh) according to your local configuration
* Run [start-all.sh](benchmark/quorum_pbft/start-all.sh)
* Run [start-clients.sh](benchmark/quorum_pbft/start-clients.sh)

## To do
* Modify shell scripts to deploy the quorum network in AWS. The related scripts are [here](benchmark/quorum_pbft/). You can learn about them by [README.md](benchmark/quorum_raft/README.md)