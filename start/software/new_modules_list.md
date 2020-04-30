
[title]: - "Accessing Software using Distributed Environment Modules"

[TOC]

# Accessing Software using Distributed Environment Modules 

## Introduction

This page covers the use of distributed environment modules on RHEL7 compute nodes in the OSG computing environment. Environment modules provide users with an easy way to access different versions of software, libraries, and compilers. 

Currently, OSG Connect login nodes and a majority of OSG compute nodes use the RHEL7 operating system. However, given the distributed nature of the OSG, there are at times a number of RHEL6 and RHEL8 compute nodes also available to users. For users that require, or who can also use, RHEL6 compute nodes for their applications, please [contact us](mailto:support@opensciencegrid.org) to learn more about modules specifically available to RHEL6 compute nodes.

## List Available Modules on OSG Connect

First sign in to your OSG Connect login node. Then use `module avail` to see all available software applications and libraries:

	$ module avail
	
	------------ /cvmfs/connect.opensciencegrid.org/modules/modulefiles/linux-rhel7-x86_64/Core ------------
	autoconf/2.69                       libiconv/1.15                     py-idna/2.5-py3.7            (D)
	automake/1.16.1                     libjpeg-turbo/1.5.3               py-ipaddress/1.0.18-py2.7
	binutils/2.31.1-py2.7               libjpeg-turbo/1.5.90      (D)     py-kiwisolver/1.0.1-py2.7
	binutils/2.31.1-py3.7      (D)      libpciaccess/0.13.5               py-kiwisolver/1.0.1-py3.7    (D)
	bison/3.0.5-py2.7                   libpng/1.6.34                     py-lit/0.5.0-py2.7
	bison/3.0.5                (D)      libpthread-stubs/0.4              py-mako/1.0.4-py2.7
	boost/1.68.0-py2.7                  libsigsegv/2.11                   py-markupsafe/1.0-py2.7
	boost/1.68.0-py3.7         (D)      libsm/1.2.2                       py-matplotlib/2.2.3-py2.7
	bowtie2/2.3.4.1-py2.7               libtiff/4.0.9                     py-matplotlib/3.0.0-py3.7    (D)
	bullet3/2.87                        libtool/2.4.6                     py-nose/1.3.7-py2.7
	bwa/0.7.17                          libx11/1.6.5                      py-numexpr/2.6.5-py2.7
	bzip2/1.0.6                         libxau/1.0.8                      py-numexpr/2.6.5-py3.7       (D)
	cairo/1.14.12-py2.7                 libxcb/1.13                       py-numpy/1.15.2-py2.7
	cctools/7.0.8-py2.7                 libxdamage/1.1.4                  py-numpy/1.15.2-py3.7        (D)
	cfitsio/3.450                       libxdmcp/1.1.2                    py-pandas/0.23.4-py2.7
	charmpp/6.8.2                       libxext/1.3.3                     py-pandas/0.23.4-py3.7       (D) 
	
	... more modules ...
	
	Where:
	D:  Default Module
	
	Use "module spider" to find all possible modules.
	Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".

Please know, there are more than 200 modules available to OSG Connect users. The above is **not** a complete list of all available modules as the list is quite long and subject to change as new sofware and libraries get added. 

## How To Use Environment Modules

In order to use the software or libraries provided in a module, you will need to 'load' that particular module. To load a particular module, use `module load [modulename]`. 

For example:

	$ module load python/2.7.14-k

To see currently loaded modules, use `module list`.

For example:

	$ module list
	Currently Loaded Modules:
  	1) python/2.7.14-k

To unload a package and remove a module from your environment, use `module unload [modulename]`.

For example:

	$ module unload python/2.7.14-k

Finally, `module help` will give you more detailed information.

## Use Environment Modules in Jobs

### Add module commands to executable script

To use environment modules within a job, use the same `module load` command
described above inside your job's main "executable" to load your software 
and then run it.  For example: 

	#!/bin/bash
	
	module load python/2.7.14-k
	python myscript.py


### Set appropriate submit file requirements

Not all resources available through OSG Connect support distributed environment modules.  In order to ensure that your 
jobs will have access to OSG Connect modules, you will need to add the following to your HTCondor submit file:

	Requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 7") && (OpSys == "LINUX")
	
or append the above requirements if you already have other requirements specified:

	Requirements = [Other requirements ] && (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 7") && (OpSys == "LINUX")
