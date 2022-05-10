[title]: - "Run Python Scripts on the OSPool"

[TOC]

# Overview

This guide will show you two examples of how to run jobs that use Python in the Open Science Pool.
The first example will demonstrate how to submit a job that uses base Python.
The second example will demonstrate the workflow for jobs that use specific Python packages, including
how to install a custom set of Python packages to your home directory and how to add them to a Python job submission.  

Before getting started, you should know which Python packages you need to run your job.  

# Running Base Python on the Open Science Pool

## Create a bash script to run Python 
To submit jobs that use a module to run base Python, first create a bash executable - for
this example we'll call it `run_py.sh` - which will run our Python script called `myscript.py`.  

For example, `run_py.sh`:

	#!/bin/bash

	# Run the Python script 
	python3 myscript.py

> If you need to use Python 2, 
> replace the `python3` above with `python2`.

## Create an HTCondor submit file

In order to submit `run_py.sh` as part of a job, we need to create an HTCondor 
submit file. This should include the following: 

* `run_py.sh` specified as the executable    
* use `transfer_input_files` to bring our Python script `myscript.py`to wherever the job runs   
* include a standard OSG Connect Singularity image that has Python installed. 

All together, the submit file will look something like this: 

	universe 	= vanilla  
	
	+SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el8:latest"
	   
	executable 	= run_py.sh

	transfer_input_files = myscript.py

	log         = job.log
	output      = job.out
	error       = job.error

	request_cpus 	= 1 
	request_memory 	= 2GB
	request_disk 	= 2GB

	queue 1

Once everything is set up, the job can be submitted in the usual way, by running 
the `condor_submit` command with the name of the submit file. 

# Running Python Jobs That Use Additional Packages

It's likely that you'll need additional Python packages that are not
present in the base Python installations. This portion of the
guide describes how to install your packages to a custom directory and 
then include them as part of your jobs. 

## Install Python packages

While connected to your login node, start the base Singularity container that has a 
copy of Python inside: 

     $ singularity shell /cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el8:latest

Next, create a directory for your files and set the `PYTHONPATH`

     Singularity> mkdir my_env
     Singularity> export PYTHONPATH=$PWD/my_env
     
> You can swap out `my_env` for a more descriptive name like `scipy` or `word-analysis`.

Now we can use `pip` to install Python packages. 

    Singularity> pip3 install --target=$PWD/my_env numpy
    ......some download message...
    Installing collected packages: numpy
	Installing collected packages: numpy
	Successfully installed numpy-1.16.3

Install each package that you need for your job using the `pip install` command.  

> If you would like to test the package installation, you can run the `python3` command 
> and then try importing the packages you just installed. To exit the Python console, 
> type "quit()"

Once you are done, you can leave the virtual environment: 

    Singularity> exit

All of the packages that were just installed should be contained in a sub-directory 
of the `my_env` directory.  To use these packages in a job, the  entire `my_env` directory
will be transfered as a tar.gz file.  So our final step is to compress the 
directory, as follows: 

	$ tar -czf my_env.tar.gz my_env

## Create executable script to use installed packages
In addition to loading the appropriate Python module, we will need to add a few
steps to our bash executable to set-up the virtual environment we
just created. That will look something like this: 

	#!/bin/bash

	# Unpack your envvironment (with your packages), and activate it
	tar -xzf my_env.tar.gz
	export PYTHONPATH=$PWD/my_env

	# Run the Python script 
	python3 myscript.py


## Modify the HTCondor submit file to transfer Python packages
The submit file for this job will be similar to the base Python job submit file shown above
with one addition - we need to include `my_env.tar.gz` in the list of files specified by `transfer_input_files`.
As an example: 

	universe 	= vanilla
	
	+SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el8:latest"
	
	executable 	= run_py.sh

	transfer_input_files = myscript.py, my_env.tar.gz

	log         = job.log
	output      = job.out
	error       = job.error

	request_cpus 	= 1 
	request_memory 	= 2GB
	request_disk 	= 2GB

	queue 1

# Other Considerations

This guide mainly focuses on the nuts and bolts of running Python, but it's important 
to remember that additional files needed for your jobs (input data, setting files, etc.) 
need to be transferred with the job as well. See our [Introduction to Data Management 
on OSG][data-intro] for details on the different ways to deliver inputs to your jobs. 

When you've prepared a real job submission, make sure to run a test job and then check 
the `log` file for disk and memory usage; if you're using significantly more or less 
than what you requested, make sure you adjust your requests. 

# Getting Help

For assistance or questions, please email the OSG Research Facilitation
team  at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).

[module-guide]: 12000048518
[data-intro]: 12000002985
