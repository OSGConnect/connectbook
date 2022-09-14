[title]: - "Run R scripts on OSG"

[TOC]

## Overview
This tutorial describes how to run R scripts on the OSG. We'll first run the program locally as a test.  After that we'll create a submit file, submit it to OSG using OSG Connect, and look at the results when the jobs finish. Finally, we will talk about how to use custom R libraries on OSG Connect.

## Run R scripts on OSG
### Access R on the submit host

First we'll need to create a working directory, you can either run `$ tutorial R` or type the following:

	$ mkdir tutorial-R; cd tutorial-R

R is installed using modules on OSG. To load this modules and access R, enter:

	$ module load r/3.5.1-py2.7
	

Now, we can try to run R:

	$ R
	
	R version 3.5.1 (2018-07-02) -- "Feather Spray"
	Copyright (C) 2018 The R Foundation for Statistical Computing
	Platform: x86_64-pc-linux-gnu (64-bit)

	R is free software and comes with ABSOLUTELY NO WARRANTY.
	You are welcome to redistribute it under certain conditions.
	Type 'license()' or 'licence()' for distribution details.

	  Natural language support but running in an English locale

	R is a collaborative project with many contributors.
	Type 'contributors()' for more information and
	'citation()' on how to cite R or R packages in publications.

	Type 'demo()' for some demos, 'help()' for on-line help, or
	'help.start()' for an HTML browser interface to help.
	Type 'q()' to quit R.

	> 

Great! R works. You can quit out with `q()`. 

	> q()
	Save workspace image? [y/n/c]: n
	$

### Run R code

Now that we can run R, let's create a small script. Create the file `hello_world.R` that contains the following:

	print("Hello World!")

R normally runs as an interactive shell, but it is easy to run in batch mode too.

	$ Rscript --no-save hello_world.R
	[1] "Hello World!"

Notice here that we're using Rscript (equivalent to `R CMD BATCH`) which accepts the script as command line argument. This approach makes `R` much less verbose, and it's easier to parse the output later. If you run it at the command line, you should get similar output as above.

### Build the HTCondor job

To prepare our R job to run on OSG, we need to create a wrapper for our R environment, based on the setup we did in previous sections. Create the file `R-wrapper.sh`:

	#!/bin/bash
	 
    module load r/3.5.1-py2.7
    Rscript --no-save hello_world.R

Change the permissions on the wrapper script so it is executable and then test it for correct output:

	$ chmod +x R-wrapper.sh
	$ ./R-wrapper.sh
	[1] "Hello World!"

Now that we've created a wrapper, let's build a HTCondor submit file around it. We'll call this one `R.submit`:

	universe = vanilla
	log = R.log.$(Cluster).$(Process)
	error = R.err.$(Cluster).$(Process)
	output = R.out.$(Cluster).$(Process)
	 
	executable = R-wrapper.sh
	transfer_input_files = hello_world.R
	
	request_cpus = 1
	request_memory = 1GB
	request_disk = 1GB
	 
	requirements = OSGVO_OS_STRING == "RHEL 7" && Arch == "X86_64" && HAS_MODULES == True
	queue 1


The `R.submit` file may have included a few lines that you are unfamiliar with.  For example, `$(Cluster)` and `$(Process)` are variables that will be replaced with the job's cluster and process id.  This is useful when you have many jobs submitted in the same file.  Any output and errors will be placed in a separate file for each job.

Notice the requirements line? You'll need to put `HAS_MODULES == True` any time you need software that is loaded via modules.

Also, did you see the transfer_input_files line?  This tells HTCondor what files to transfer with the job to the worker node.  You don't have to tell it to transfer the executable, HTCondor is smart enough to know that the job will need that.  But any extra files, such as our R script file, will need to be explicitly listed to be transferred with the job.  You can use transfer_input_files for input data to the job, as shown in [Transferring data with HTCondor](https://github.com/OSGConnect/tutorial-htcondor_transfer).


### Submit and analyze the output

Finally, submit the job to OSG Connect!

	$ condor_submit R.submit
	Submitting job(s)..........
	1 job(s) submitted to cluster 3796250.
	$ condor_q user
	 
	$ condor_q
	-- Schedd: login03.osgconnect.net : <192.170.227.22:9618?... @ 05/13/19 09:51:04
	OWNER      BATCH_NAME     SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
	user	   ID: 3796250   5/13 09:50      _      _      1      1 3796250.0
	...

You can follow the status of your job cluster with the `connect watch` command, which shows `condor_q` output that refreshes each 5 seconds.  Press `control-C` to stop watching.

Since our jobs prints to standard out, we can check the output files. Let's see what one looks like:

	$ cat R.out.3796250.0
	[1] "Hello World!"

## Use custom R libraries on OSG

Often we may need to add R external libraries that are not part of standard R installation. As a user, we could add the libraries in our home (or stash) directory and make the libraries available on remote machines for job executions.

### Build external packages for R under userspace

It is helpful to create a dedicated directory to install the package into. This will facilitate zipping the library so it can be transported with the job. Say, you decided to built the library in the path  `/home/username/R_libs/lubridate_R.3.5`. If it does not already exist, make the necessary directory by typing the following in your shell prompt:

    $ mkdir -p ~/R_libs/lubridate_R.3.5

After defining the path, we set the `R_LIBS` environment variable so R knows to use our custom library directory:
	
	$ export R_LIBS=~/R_libs/lubridate_R.3.5
	
Now we can run R and check that our library location is being used (here the `>` is the R-prompt):

    $ module load r/3.5.1-py2.7
	$ R
	...
	> .libPaths()
	[1] "/home/user/R_libs/lubridate_R.3.5"                                                                                                                      
	[2] "/cvmfs/connect.opensciencegrid.org/modules/packages/linux-rhel7-x86_64/gcc-6.4.0spack/r-3.5.1-eoot7bzcbxp3pwf4dxlqrssdk7clylwd/rlib/R/library"
	
Excellent. We can see the location listed as library path `[1]`. We can also check for available libraries within R.

    > library()

Press `q` to close that display.

If you want to install the package “XYZ”, within R do
 
    > install.packages("XYZ", repos = "http://cloud.r-project.org/", dependencies = TRUE)

To install `lubridate`, enter this command:

	> install.packages("lubridate", repos="http://cloud.r-project.org/", dependencies=TRUE)

### Install multiple packages at once

If you have multiple packages to be added, it may be better to list each of the `install.packages()` commands within a separate R script and source the file to R.  For example, if we needed to install `ggplot2`, `dplyr`, and `tidyr`, we can list them to be installed in a script called `setup_packages.R` which would contain the following: 

    install.packages("ggplot2", repos="http://cloud.r-project.org/", dependencies=TRUE)
    install.packages("dplyr", repos="http://cloud.r-project.org/", dependencies = TRUE)
    install.packages("tidyr", repos="http://cloud.r-project.org/", dependencies = TRUE)

Run the setup file within R. 

    > source(`setup_packages.R`) 

### Prepare a tarball of the add-on packages 

Proceeding with the `lubridate` package, the next step is create a tarball of the package so we can send the tarball along with the job. 

Exit from the R prompt by typing:

    > quit()

or:

    >q()

In either case, be sure to say `n` when prompted to `Save workspace image? [y/n/c]:`.

To tar the package directory, type the following at the shell prompt:

    $ cd /home/user/R_libs
    $ tar -cvzf lubridate_R.3.5.tar.gz lubridate_R.3.5

Now copy the tarball to the job directory where the R program, job wrapper script and condor job description file are. 

### Use the packages in your OSG job

Now, let's change the `hello_world` job to use the new package. First, modify the R script `hello_world.R` by adding the following lines:

	library(lubridate)
	print(today())
	
This will add a print out of the local date to the output of the job. 

### Define the libPaths() in the wrapper script

R library locations are set upon launch and can be modified using the `R_LIBS` environmental variable. To set this correctly, we need to modify the wrapper script. Change the file `R-wrapper.sh` so it matches the following:

	#!/bin/bash

	module load r/3.5.1-py2.7
	
	# Uncompress the tarball
	tar -xzf lubridate_R.3.5.tar.gz
	
	# Set the library location
	export R_LIBS="$PWD/lubridate_R.3.5"
	
	# run the R program
	Rscript --no-save hello_world.R

Next, we need to modify the submit script so that the package tarball is transferred correctly with the job. Change the submit script `R.submit` so that `transfer_input_files` and `arguments` are set correctly. Here's what the completed file should look like:

	universe = vanilla
	log = R.log.$(Cluster).$(Process)
	error = R.err.$(Cluster).$(Process)
	output = R.out.$(Cluster).$(Process)

	executable = R-wrapper.sh
	transfer_input_files = lubridate_R.3.5.tar.gz, hello_world.R
	
	request_cpus = 1
	request_memory = 1GB
	request_disk = 1GB

	requirements = OSGVO_OS_STRING == "RHEL 7" && Arch == "X86_64" && HAS_MODULES == True
	queue 1

### Job submission and output
Now we are ready to submit the job:

    $ condor_submit R.submit

and check the job status:

    $ condor_q username

Once the job finished running, check the output files as before. They should now look like this:

	$ cat R.out.3796676.0
	[1] "2019-05-13"
	[1] "Hello World!"

## Getting Help
For assistance or questions, please email the OSG Research Facilitation team  at <mailto:support@osg-htc.org> or visit the [help desk and community forums](http://support.opensciencegrid.org).
