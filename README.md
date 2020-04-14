# Linux From Scratch Builder Environment

This repository is created for building Linux easily.
It has a prepared bash environment to easily managing.  

For building is taking time. Some times you may close your build environment, so I will decide some icons for the required commands at each step.

## Commands required on ,
-	📕 once at system
- 📗 every restart your computer
- 📘 every entering the environment


## Preparing the Host System

### Checking Requirements
📕
Before the entering build environment, firstly you have to check Required packets for build env.
To checking run check-requirement.sh.
```bash
chmod +x check-requirements
sudo ./check-requirements
```
If is some thing is missing, please install on your system. For more information [visit LFS web page](http://www.linuxfromscratch.org/lfs/view/stable/chapter02/hostreqs.html).


### Entering the Environment
📘
Some basic functions which is implemented for speed up the workflow is in building env.
```bash
chmod +x main.sh
sudo ./main.sh
```

### Select Disk For LFS
📕
In environment you can Select disk for LFS with ```disk-location-prepare``` command.  
It is only Required on beginning of the project.
```bash
disk-location-prepare
```
[![asciicast](https://asciinema.org/a/318487.svg)](https://asciinema.org/a/318487)

### Mount LFS Partitions
📗
Partitions and dirs are created by `disk-location-prepare` and mount this created Partitions with `mount-lfs` command.  
It is required on every restart at your build computer.
```bash
mount-lfs
```

### Final Preparations
📕
In this stage, `final-preparations` functions creates lfs user, apply permissions and bash profile for lfs user.
```bash
final-preparations
```

## Constructing a Temporary System
📕
This function will compile just enough tools to start constructing the final LFS system in Chapter 6 and allow a working environment with more user convenience than a minimum environment would.


# Help

## Listing all Functions

To showing all functions run `list-all-functions` command.
