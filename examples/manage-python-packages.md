[title]: - "Run Python Scripts on OSG"

# Run Python Scripts on OSG

[TOC]

## Overview

This guide will show you to how run jobs that use Python in the Open Science Grid. Our 
first example will show how to submit a job that runs a script that only uses base Python.  
If your jobs use specific Python packages, the second half of this guide will show you 
how to install these packages to your home directory and add them to a basic Python job 
submission.  

Before we begin, you should know which Python packages you need to run your job.  

## Running Python on the Open Science Grid

You can see the versions of Python available in the [Open Science Grid's Software 
Module System][module-guide], by running `module avail` on the submit node. 

To use a module, you "load" it and then use the `python` command to run a Python script. 
However, we're not actually going to do this on the submit node. Instead, we'll put 
these commands into a script, so they can be executed wherever the job runs: 

	#!/bin/bash

	# Load Python
	module load python/3.7.0

	# Run the Python script 
	python3 myscript.py


> If you need to use Python 2, load the appropriate module and 
> replace the `python3` above with `python2`.

In order to submit this script as part of a job, you'll need to create an HTCondor 
submit file. This should include the following: 

* The `bash` script above will be the job's "executable" - for this example we'll call it `run_py.sh`. 
* The Python script (`myscript.py`, above) will need to be transferred to wherever the job runs, and should be 
listed in "transfer_input_files".
* It's also important to include the requirement(s) that request OSG servers that 
have access to the base Python module used in the wrapper script. 

All together, a submit file will look something like this: 

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

## Adding Python Packages to a Job

It's likely that you'll need additional Python packages that aren't present in 
the default OSG software modules.  This portion of the guide describes how to 
create a Python "virtual environment" that contains your packages and can be 
included as part of your jobs. 

### Install needed Python packages

First, load the Python module that you want to use to run jobs. 

     $ module load python/3.7.0

Now, we will go through the steps to create a virtual environment.  The first 
command creates the base environment. **You can swap out `my_env` for a more descriptive name like `scipy` or `word-analysis`**.

     $ python3 -m venv my_env

This creates a directory `my_env` in the current working directory 
with sub-directories `bin/`, `include/`, and `lib/`.   

We now need to _activate_ the environment and install our packages to it.  

    $ source my_env/bin/activate

Notice how your command line prompt changes to: 

    (my_env)$

The activation process redefines some of the shell variables 
such as PYTHON_PATH, LIBRARY_PATH etc. 

After activation, we are ready to add the packages with `pip` 
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
normal shell prompt (the prefix `my_env` disappears)

    $ 

All of the packages that were just installed should be contained in a sub-directory 
of the `my_env` directory.  To use these packages in a job, we will transfer the 
entire `my_env` directory as a tar.gz file.  So our final step is to compress the 
directory, as follows: 

	$ tar czf my_env.tar.gz my_env


### Executable script and submit file

When our job actually runs, we will want to include the same steps as the previous 
shell script (load the Python module, run Python), but will need to add a few 
steps to set-up the virtual environment we just created. That will look 
something like this: 

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

The submit file for this job will be similar to above, but you need to make sure 
to add the `tar.gz` file with your environment to the list of "transfer_input_files: 

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