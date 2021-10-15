[title]: - "Run Python Scripts on OSG"

# Run Python Scripts on OSG

[TOC]

## Overview

This guide will show you two examples of how to run jobs that use Python in the Open Science Pool.
The first example will demonstrate how to submit a job that uses base Python.
The second example will demonstrate the workflow for jobs that use specific Python packages, including
how to install a custom set of Python packages to your home directory and how to add them to a Python job submission.  

Before getting started, you should know which Python packages you need to run your job.  

## Running Base Python on the Open Science Pool
Several installations of base Python are available via the [Open Science Pool's Software 
Module System][module-guide]. To see what Python versions are available on the Open Science Pool
run `module avail` while connected to our login node. 

### Create a bash script to run Python 
To submit jobs that use a module to run base Python, first create a bash executable - for
this example we'll call it `run_py.sh` - which will include commands to first
load the appropriate Python module and then run our Python script called `myscript.py`.  

For example, `run_py.sh`:

	#!/bin/bash

	# Load Python
	module load python/3.7.0

	# Run the Python script 
	python3 myscript.py


> If you need to use Python 2, load the appropriate module and 
> replace the `python3` above with `python2`.

### Create an HTCondor submit file
In order to submit `run_py.sh` as part of a job, we need to create an HTCondor 
submit file. This should include the following: 

* `run_py.sh` specified as the executable    
* use `transfer_input_files` to bring our Python script `myscript.py`to wherever the job runs   
* include requirements that request OSG nodes with access to base Python modules   

All together, the submit file will look something like this: 

	universe 	= vanilla     
	executable 	= run_py.sh

	transfer_input_files = myscript.py

	log         = job.log
	output      = job.out
	error       = job.error

	# Require nodes that can access the correct OSG modules
	Requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 7")

	request_cpus 	= 1 
	request_memory 	= 2GB
	request_disk 	= 2GB

	queue 1

Once everything is set up, the job can be submitted in the usual way, by running 
the `condor_submit` command with the name of the submit file. 

## Running Python Jobs That Use Additional Packages
It's likely that you'll need additional Python packages (aka libraries) that are not
present in the base Python installations made available via modules. This portion of the
guide describes how to create a Python "virtual environment" that contains your packages
and which can be included as part of your jobs. 

### Install Python packages
While connected to your login node, load the Python module that you want to use to run jobs: 

     $ module load python/3.7.0

Next, create a virtual environment. The first command creates a base environment:

     $ python3 -m venv my_env
     
> You can swap out `my_env` for a more descriptive name like `scipy` or `word-analysis`.

This creates a directory `my_env` in the current working directory
with sub-directories `bin/`, `include/`, and `lib/`.   

Then _activate_ the environment and install packages to it.  

    $ source my_env/bin/activate

Notice how our command line prompt changes to: 

    (my_env)$

The activation process redefines some of the shell variables
such as PYTHON_PATH, LIBRARY_PATH etc. 

After activation, packages can be installed using `pip` 
which is a tool to install Python packages. 

    (my_env)$ pip install numpy
    ......some download message...
    Installing collected packages: numpy
	Installing collected packages: numpy
	Successfully installed numpy-1.16.3

Install each package that you need for your job using the `pip install` command.  Once 
you are done, you can leave the virtual environment: 

    (my_env)$ deactivate

The above command resets the shell environmental variables and returns you to the 
normal shell prompt (with the prefix `my_env` removed).

All of the packages that were just installed should be contained in a sub-directory 
of the `my_env` directory.  To use these packages in a job, the  entire `my_env` directory
will be transfered as a tar.gz file.  So our final step is to compress the 
directory, as follows: 

	$ tar czf my_env.tar.gz my_env


### Create executable script to use installed packages
In addition to loading the appropriate Python module, we will need to add a few
steps to our bash executable to set-up the virtual environment we
just created. That will look something like this: 

	#!/bin/bash
	
	# Load Python
	# (should be the same version used to create the virtual environment)
	module load python/3.7.0

	# Unpack your envvironment (with your packages), and activate it
	tar -xzf my_env.tar.gz
	python3 -m venv my_env
	source my_env/bin/activate

	# Run the Python script 
	python3 myscript.py

	# Deactivate environment 
	deactivate

### Modify the HTCondor submit file to transfer Python packages
The submit file for this job will be similar to the base Python job submit file shown above
with one addition - we need to include `my_env.tar.gz` in the list of files specified by `transfer_input_files`.
As an example: 

	universe 	= vanilla     
	executable 	= run_py.sh

	transfer_input_files = myscript.py, my_env.tar.gz

	log         = job.log
	output      = job.out
	error       = job.error

	# Require nodes that can access the correct OSG modules
	Requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 7")

	request_cpus 	= 1 
	request_memory 	= 2GB
	request_disk 	= 2GB

	queue 1

## Other Considerations
This guide mainly focuses on the nuts and bolts of running Python, but it's important 
to remember that additional files needed for your jobs (input data, setting files, etc.) 
need to be transferred with the job as well. See our [Introduction to Data Management 
on OSG][data-intro] for details on the different ways to deliver inputs to your jobs. 

When you've prepared a real job submission, make sure to run a test job and then check 
the `log` file for disk and memory usage; if you're using significantly more or less 
than what you requested, make sure you adjust your requests. 

## Getting Help

For assistance or questions, please email the OSG User Support
team  at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).

[module-guide]: 12000048518
[data-intro]: 12000002985
