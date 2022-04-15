
Welcome! This website contains the artifact for reproducing our OSDI ‘22 paper “Odinfs: Scaling PM Performance with Opportunistic Delegation”.

Odinfs is a NUMA-aware PM file system based on an opportunistic delegation
framework to achieve datapath scalability. Odinfs’s design features:

* Limiting concurrent PM access to avoid performance meltdown due to on-DIMM cache trashing. 
* Localizing PM access to avoid performance meltdown due to remote PM access. 
* Automatic parallelize large PM access to utilize cumulative PM bandwidth across all NUMA nodes 
* Maximizing concurrent access within the same file with scalable synchronization primitives.



### More
[Repository](https://github.com/rs3lab/Odinfs)

[Artifact evaluation guide](guide.md)






