# Artifact Evaluation Submission for Odinfs [OSDI '22] 

This repository contains the artifact for reproducing our OSDI '22 paper "Odinfs: Scaling PM Performance with Opportunistic Delegation". 

# Table of Contents
* [Overview](#overview)
* [Setup](#setup)
* [Running experiments](#running-experiments)
* [Validation of the main claims](#validation-of-the-main-claims)
* [Known Issues](#known-issues)
* [Authors](#authors)

# Overview 

### Structure:

```
root
|---- fs                 (source code of the evaluated file systems)
    |---- odinfs         (odinfs kernel module) 
    |---- parradm        (odinfs user-level utility)
    |---- nova         
    |---- pmfs 
    |---- winefs
|---- linux              (5.13.13 Linux kernel)
|---- eval               (evaluation)
    |---- ampl           (I/O amplification) 
    |---- benchmark      (Filebench and Fxmark) 
    |---- numa           (NUMA impact)
    |---- scripts        (the main evaluation scripts) 
    |---- fig            (figures) 
    |---- data           (raw data)
|---- tools            
    |---- intel-pmwatch  (used to measure the I/O amplification)
    |---- pcm            (used to measure the NUMA impact)
|---- dep.sh             (scripts to install dependency)    
```

### Environment: 

Our artifact should run on any Linux distribution. The current scripts are developed for **Ubuntu 20.04.4 LTS**. Porting to other Linux distributions would require some scripts modifications , especially ```dep.sh```, which installs dependencies with package management tools. 

# Setup 

**Note**: For the below steps, our scripts will complain if it fails to compile or install the target. Check the end part of the scripts' output to ensure that the install is successful. Also, some scripts would prompt to ask the sudo permission at the beginning. 

### 1. Install the dependencies:
```
$ ./dep.sh 
```

### 2. Install the 5.13.13 Linux kernel (50GB space and 20 minutes)
```
$ cd linux
$ cp config-odinfs .config
$ make oldconfig        (update the config with the provided .config file)
```

Say N to KASAN if the config program prompts to ask about it. 

```
KASAN: runtime memory debugger (KASAN) [N/y/?] (NEW) N
```


Next, please use your favorite way to compile and install the kernel. The below step is just for reference. The installation requires 50GB space and takes around 20 minutes on our machines. 

For Ubuntu:
```
$ make -j8 deb-pkg       (generate the kernel installment package)
$ sudo dpkg -i *.deb    (install the package) 
```

Otherwise, the classical ways will work as well:

```
$ make -j8              
$ make -j8 modules 
$ sudo make install
$ sudo make modules_install
```
Reboot the machine to the installed 5.13.13 kernel. 

### 3. Install and insmod file systems 

```
$ cd fs
$ ./compile.sh
```
The script will compile, install, and insert the following kernel modules:

* Odinfs 
* PMFS 
* NOVA 
* Winefs

### 4. Compile and install benchmarks 

**4.1 Fxmark**

```
$ cd eval/benchmark/fxmark
$ ./compile.sh
```

**4.2 Filebench**

```
$ cd eval/benchmark/fxmark
$ ./compile.sh
```

### 5. Compile and install tools 

**5.1 Intel-pmwatch**

```
$ cd tools/intel-pmwatch
$ ./compile.sh
```

**5.2 PCM**

For Ubuntu:
```
$ cd tools/pcm
$ sudo dpkg -i pcm_amd64.deb
```

Otherwise, please check `tools/pcm/README.md`

# Running Experiments:

Main scripts are under ```eval/scripts/```

```
eval/scripts
|---- fio.sh                    (FIO-related experiments; fig1, fig2, fig6, fig7)
|---- fxmark.sh                 (Fxmark-related experiments; fig11)
|---- filebench.sh              (Filebench-related experiments; fig12)
|---- fio-odinfs-vd.sh          (Odinfs with varying number of delegation threads; fig1, fig9)   
|---- fio-odinfs-vn.sh          (Odinfs with varying number of NUMA nodes; fig10) 
|---- ampl.sh                   (I/O amplifcation rate of each file system; fig2, fig8)
|---- numa.sh                   (PM NUMA impact; fig3)
|---- run-all.sh                (running all the above scripts)
|---- run-test.sh               (quick run of fio, fxmark, and filbench with the evaluated file systems)
|---- odinfs.sh                 (rerun all the experiments related to odinfs)
|---- parse.sh                  (parse and output the results to directory: eval/data)
```


**Exeuction time**

The table below shows the execution time of each script on a two-socket, 56 core machine. Machines with more sockets take longer. 

    
|      Scripts     | Execution Time in Minutes |
|:----------------:|:-------------------------:|
|      fio.sh      |                       270 |
|     fxmark.sh    |                       138 |
|   filebench.sh   |                       164 |
| fio-odinfs-vd.sh |                       179 |
| fio-odinfs-vn.sh |                        45 |
|      ampl.sh     |                       200 |
|      numa.sh     |                         6 |
|    run-all.sh    |                      1002 |
|    run-test.sh   |                        65 |
|     odinfs.sh    |                        92 |
|     parse.sh     |                        <1 |
                                               

**Note**: 
* We recommend running ```run-test.sh``` first to ensure that everything seems correct 
* And then perform a full run with ```run-all.sh``` to get all the data. 
* Feel free to customize ```run-all.sh``` to skip some experiments. 



**1. Hardware setup**: 
* Please disable hyperthreading in the BIOS to avoid issues due to CPU pinning before running experiments. 
* Please enable the directory coherence protocol for PM to check the PM NUMA impact. This should be the default setup. 
* Configure each PM device to ```fsdax``` mode. For example, on a two socket machine:
```
sudo ndctl create-namespace -f -e namespace0.0 --mode=fsdax
sudo ndctl create-namespace -f -e namespace0.0 --mode=fsdax
```

On a four socket machine:
```
sudo ndctl create-namespace -f -e namespace0.0 --mode=fsdax
sudo ndctl create-namespace -f -e namespace1.0 --mode=fsdax
sudo ndctl create-namespace -f -e namespace2.0 --mode=fsdax
sudo ndctl create-namespace -f -e namespace3.0 --mode=fsdax
```

**Warning: all the data on the PM file will be lost**


**2. Testing runs**

```
$ cd eval/scripts
$ ./run-test.sh
```

**3. Full runs**

```
$ cd eval/scripts
$ ./run-all.sh
```

**4. Generate figures**

```
$ cd eval/scripts
$ ./parse.sh
$ cd eval/fig
$ ./fig.sh
```

Please check all the ```*.eps``` files numbered according to the figures in the paper.  We don't include legends in these figures since we have not figured out how to do it nicely with gnuplot :stuck_out_tongue_winking_eye:. The legends are the same as the corresponding figures in the paper. :stuck_out_tongue_closed_eyes:

# Validation of the main claims:

Please refer to [here](main-claim.md)

# Known issues 

1. The kernel might complain about CPU soft lockup during some experiments. This can be safely ignored. 

2. Intel pmwatch does not work on [the newer version of PM](https://community.intel.com/t5/Intel-Optane-Persistent-Memory/How-to-use-quot-ipmwatch-quot-with-PMEM200-and-3rd-Gen-Xeon/td-p/1367959). Our I/O amplification scripts is based on pmwatch. If it does not work, there is no point to run ```ampl.sh```

3. For I/O intensive applications, the performance of PM file systems heavily depends on the ways to perform memcpy. If the experiments show Odinfs achieves poor write performance, please do the followings:
* Enable non-temporal stores:  

  Change line 70 of ```fs/odinfs/pmfs_config.h``` to ```#define PMFS_NT_STORE 1 ```

* Recompile and reinsert odifns:
``` 
$ cd fs
$ ./compile.sh
```

* Rerun all the odinfs-related experiments:
```
$ cd eval/scripts
$ ./odinfs.sh
```

* Regenerate the figure: 
```
$ cd eval/scripts
$ ./parse.sh
$ cd eval/fig
$ ./fig.sh
```
# Authors

Diyu Zhou (EPFL)

Yuchen Qian (EPFL) 

Vishal Gupta (EPFL) 

Zhifei Yang (EPFL) 

Changwoo Min (Virginia Tech) 

Sanidhya Kashyap (EPFL) 



