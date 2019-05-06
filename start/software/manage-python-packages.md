[title]: - "Run Python Scripts on OSG"

# Run Python Scripts on OSG

[TOC]

## Overview

If your jobs need specific Python packages, this guide will show you how to 
install these packages to your home directory and use them to run jobs.  

Before we begin, you should know which Python packages you need to run your job.  

## Install and prepare needed Python packages

Load Python.  

     $ module load python/3.7.0

Now, we will go through the steps to create a virtual environment.  The first 
command creates the base environment. You 
can swap out `my_env` for a more descriptive name like `scipy` or `word-analysis`.

     $ python3 -m venv testenv

This creates a directory `my_env` in the current working directory 
with sub-directories `bin/`, `include/`, and `lib/`.   

> If you need to use Python 2, load the appropriate module and 
> replace the `python3` above with `python2`.

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


## Executable script for using the virtual environment

When our job actually runs, we will want to load the same module as when 
we created the virtual environment.  We will want to un-tar the environment 
folder we just created, activate it (in the same way we did to install 
the packages) and then run the job's python script.  That will look something like this: 

	#!/bin/bash

	# Load Python (should be the same version used to create the virtual environment)
	module load python/3.7.0

	# Extract the environment directory
	tar -xzf my_env.tar.gz

	# Create the virtual environment on the remote hosts (redefines the env variables)
	virtualenv-2.7 nltk_env

	# Activate virtual environment
	source my_env/bin/activate

	# Run the Python script 
	python3 myscript.py

	# Deactivate virtual environment 
	deactivate

## Submit file for Python jobs.

The submit file for Python jobs needs to include the wrapper script 
described above as the job's `executable` and needs to transfer: 
* The job's environment tar.gz file
* A python script
* Other input files (if needed)

It's also important to include the requirement(s) that request OSG servers that 
have access to the base Python module used in the wrapper script. 

All together, a submit file will look something like this: 

	Universe = vanilla     
	Executable = run_py.sh

	transfer_input_files = my_env.tar.gz, script.py, input.data

	log           = job.log
	output        = job.out
	error         = job.error

	# Set the requirement that the OASIS modules are available on the remote worker machine
	Requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 7") && (OpSys == "LINUX")

	request_cpus = 1 
	request_memory = 2GB
	request_disk = 2GB

	queue 1


## Submitting a job

Once everything is set up, the job can be submitted in the usual way, by running 
the `condor_submit` command with the name of the submit file. 

## Getting Help

For assistance or questions, please email the OSG User Support
 team  at [support@osgconnet.net](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).
