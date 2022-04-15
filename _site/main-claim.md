# Main claims of Odinfs

### 1. Excessive concurrent access to PM (Sec 2.1)

**Claims**: Excessive concurrent access to PM will lead to performance collapse and a large I/O amplification since this renders the on-DIMM caching and prefetching inefficient.

**Expected results**: 
* In Figure 2 (a), after 56 threads, PM read performance collapses, and the I/O amplification rate increases.
 
* In Figure 2 (b), after 8 threads, PM write performance collapses, and the I/O amplification rate increases. 


### 2. PM NUMA Impact (Sec 2.2)

**Claims**: With directory coherence protocols, remote access to PM will incur a significant performance overhead due to updating coherence information directly in the raw storage media. Placing PM in the same NUMA node as the access threads can avoid the performance collapse. 


**Expected results**: 
* In Figure 3 (a), PM-remote has lower throughput than All-local and PM-local. PM-remote also incurs PM IO write while others don't. 
   
* In Figure 3 (b), PM-remote has lower throughput than All-local and PM-local. The PM IO write in the PM-remote setup is larger than 
the throughput.   

### 3. Throughput and latency of the evaluated file systems (Sec 5.2)

**Claims**: Odinfs scales PM performance with respect to core counts since Odinfs's design: 
* Avoids excessive concurrent access to PM

* Avoids the PM NUMA impact

* Efficiently leverages the aggregated PM bandwidth across all NUMA nodes. 

**Expected results**: 
* In Figure 6 (a), Odinfs starts to outperform other PM file systems after 56 threads. 

* In Figure 6 (b), Odinfs starts to outperform ext4, pmfs, nova, and winefs after 16 threads. Odinfs should start to outperform ext4-raid0 after 56 threads. 

* In Figure 6 (c), Odinfs consistently outperforms ext4, pmfs, nova, and winefs, achieving similar performance as ext4-raid0 with high thread counts.

* In Figure 6 (d), Odinfs consistently outperforms all other file systems. 

* In Figures 7 (a) and 7 (b), Odinfs consistently has a low latency. Other file systems' latency significantly increases after 56 threads. 

* In Figures 7 (c) and 7 (d), Odinfs consistently has a low latency. Other file systems' latency significantly increases after 16 threads. 

### 4. Datapath scalability of the evaluated file systems (Sec 5.5)

**Claims**: Odinfs scales datapath operations since it
* Scales PM performance

* Maximizes concurrent access within the same file (Sec 3.6)

* Minimizes synchronization overheads (Figure4, Sec 4)


**Expected results**: 
* In Figure 11, Odinfs scales all benchmarks. 

* In Figure 11, other evaluated file systems only scales DRBL. 


### 5. Macrobenchmarks with the evaluated PM file systems (Sec 5.6)

**Claims**: 

* For write-intensive workloads: Filebench, Odinfs consistently outperforms all other evaluated file systems. 

* For read-intensive workloads: Webserver and Videoserver, Odinfs performs similarly to ext4-raid0 and outperforms all other evaluated file systems. 

* For metadata-intensive workloads: Varmail, Odinfs peforms similarly to NOVA and Winefs and outperforms other file systems. 

**Expected results**: 
* Please verify the above claims in Figure 12. 


### 6. I/O amplification rate (Sec 5.3)

**Claims**: 
* Odinfs does not incur I/O amplification while other systems do. 

**Expected results**: 
* In Figure 8 (a), the I/O amplification rate of other PM file systems increases after 56 threads. 

* In Figure 8 (b), the I/O amplification rate of other PM file systems increases after 16 threads.

* In Figures 8 (a) and 8 (b), Odinfs consistently acheives an I/O amplification rate near to 1. 

### 7. Odinfs scales with the number of PM NUMA nodes (Sec 5.4)

**Claims**: 
* Odinfs's performance scales with the number of PM NUMA nodes. 

**Expected results**: 
* Please verify the above claims in Figure 10 


### Notes

* Machines need to be configured with directory coherences to show the PM NUMA impacts. This should be the default setup for Intel machines. 

* We performed Odinfs's results on an 8 socket, 224 core machines. For machines with fewer sockets or cores, the concurrent access and PM NUMA impact are not as severe. In particular, machines with less than 56 cores cannot trigger the read performance collapse. The aggregated PM bandwidth is also smaller. Hence, the results with Odinfs may not be as good as we present in the paper, but we believe the overall trends should be similar. 





