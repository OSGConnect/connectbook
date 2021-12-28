[title]: - "Run Python Scripts on the OS Pool"

[TOC]

# Overview

This guide shows how to run jobs that use Python in the Open Science Pool.

Before getting started, you should know which Python packages you need to run your job.  

# Python on OSG Connect

OSG Connect provides a pre-built copy of the following versions of Python: 

{:.gtable}
  | Python version  | Name of Python installation file |
  | --- | --- |
  | Python 3.7 | python37.tar.gz |
  | Python 3.8 | python38.tar.gz |
  | Python 3.9 | python39.tar.gz |

If you need a specific version of Python not shown 
above, [contact us][get-help] to 
see if we can build it for you; if 
we can't, we can send you instructions for how to build your own copy of Python 
or use a Singularity container for running your jobs. 

# Install Python Packages

It's likely that your jobs will need additional Python *packages* 
(aka *libraries* or *modules*) that are not
present in the base Python installations provided by OSG staff. This portion of the
guide describes how to install packages to a specific location in your home directory
using `pip`. 

1. **Get a Copy of Python**

	OSG Connect's pre-built copies of Python are located at the path `/public/osg/python`. 
	You can see available versions by running:
	
		$ ls -l /public/osg/python
	
	To get started, choose your desired version and copy it to your current directory:
	
		$ cp /public/osg/python/python##.tar.gz ./

1. **Set Up Python**

	Unzip the copied Python installation and set the `PATH` variable to indicate 
	where to find the `python` and `pip` commands. 
	
		$ tar -xzf python37.tar.gz
		$ export PATH=$PWD/python/bin:$PATH

	To test that the installation worked, run the following command: 
	
		$ which python3
	
	The output line should start with your home directory. 

1. **Create Packages Directory**
	
	Create a directory to hold your installed Python packages. 
	
		$ mkdir python-packages
		
	Note that you can call this directory whatever you want; we recommend a 
	descriptive name that will help you recognize the contents later. If you 
	choose a different name than `python-packages`, make sure to replace the 
	directory name as appropriate in the following commands and examples. 

1. **Install Packages**

	Install the packages you need with the `pip` command. 
	
		$ python3 -m pip install --target=$PWD/python-packages package1 package2 etc.

	> The last values should be the names of your packages. So if I wanted to install 
	> `numpy` and `pandas` to my `python-packages` folder, I should run:  
	> 
	> 	$ python3 -m pip install --target=$PWD/python-packages numpy pandas
	
	You can confirm that your packages were installed by listing the contents of 
	the package directory -- you should see your main packages and their dependencies: 
	
		$ ls python-packages

1. **Prepare Packages Directory for Jobs**

	Finally, when sending the packages along with jobs, it is helpful to "squash" 
	the directory into a single, compressed "tar.gz" file, which can be done with 
	the `tar` command: 
	
		$ tar -czf python-packages.tar.gz python-packages

# Submit Python Jobs

## Create an Script to Set Up and Run Python

In order to run Python in a job, you will need to create a script (the job's "executable") 
that unzips the OSG-provided copy of Python and your own Python packages, then 
executes your Python script. 

A sample script appears below. After the first line, the lines starting
with hash marks are comments . You should replace \"myscript.py\" with
the name of the script you would like to run, and modify the Python
version numbers to be the same as what you used above to install your
packages.

	#!/bin/bash

	# run_py.sh

	# untar your Python installation. Make sure you are using the right version!
	tar -xzf python##.tar.gz
	# (optional) if you have a set of packages (created previously), untar them also
	tar -xzf python-packages.tar.gz

	# set the location of your Python installation and packages
	export PATH=$PWD/python/bin:$PATH
	export PYTHONPATH=$PWD/python-packages
	export HOME=$PWD

	# run your script
	python3 myscript.py

If you have additional commands you would like to be run within the job,
you can add them to this base script. 

## Create an HTCondor Submit File

In order to submit `run_py.sh` (created in the previous step) and our Python script 
and packages as part of a job, we 
need to create an HTCondor submit file. This file should include the following:

* `run_py.sh` specified as the executable
* use `transfer_input_files` to bring along the Python tar.gz file, our packages (if 
using) and the Python script (`myscript.py` in this example)

All together, the submit file will look something like this: 

	universe 	= vanilla     
	executable 	= run_py.sh

	# transfer Python script, packages, and base Python installation
	# remove the packages tar.gz file if not using
	transfer_input_files = python##.tar.gz, python-packages.tar.gz, myscript.py

	log         = job.log
	output      = job.out
	error       = job.error

	request_cpus 	= 1 
	request_memory 	= 2GB
	request_disk 	= 2GB

	queue 1

Submit the job as usual using `condor_submit`. 

# Other Considerations

This guide mainly focuses on the nuts and bolts of running Python, but it's important 
to remember that additional files needed for your jobs (input data, setting files, etc.) 
need to be transferred with the job as well. See our [Introduction to Data Management 
on OSG][data-intro] for details on the different ways to deliver inputs to your jobs. 

When you've prepared a real job submission, make sure to run a test job and then check 
the `log` file for disk and memory usage; if you're using significantly more or less 
than what you requested, make sure you adjust your requests. 

# Getting Help

For assistance or questions, please email the OSG User Support
team  at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).

[module-guide]: 12000048518
[data-intro]: 12000002985
[get-help]: 12000084585
