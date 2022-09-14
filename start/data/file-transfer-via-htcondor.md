[title]: - "Transfer Input Files Up To 100MB In Size"

[TOC] 

# Overview

Due to the distributed configuration of the OSG, more often than not, 
your jobs will need to bring along a copy (i.e. transfer a copy) of 
data, code, packages, software, etc. from the login node where the job 
is submitted to the execute node where the job will run. This requirement 
applies to any and all files that are needed to successfully execute and 
complete your job that do not otherwise exist on OSG execute servers.

**This guide will describe steps and important considerations for transferring 
input files that are <100MB in size via the HTCondor submit file.**   

# Important Considerations

As described in the [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) 
any data, files, or even software that is <100MB should be staged in 
your `/home` directory on your login node. Files in your 
`/home` directory can be transferred to jobs via your HTCondor submit file.

# Transfer Files From `/home` Using HTCondor

To transfer files from your `/home` directory use the `transfer_input_files` 
statement in your HTCondor submit file. For example:

	# submit file example
	
	log = my_job.$(Cluster).$(Process).log
	error = my_job.$(Cluster).$(Process).err
	output = my_job.$(Cluster).$(Process).out
	
	# transfer small file from /home 
	transfer_input_files = my_data.csv
	
	...other submit file details...

Multiple files can be specified using a comma-separated list, for example:

	# transfer multiple files from /home
	transfer_input_files = my_data.csv, my_software.tar.gz, my_script.py

When using `transfer_input_files` to transfer files located in `/home`, 
keep in mind that the path to the file is relative to the location of 
the submit file. If you have files located in a different `/home` subdirectory, 
we recommend specifying the full path to those files, which is also a matter 
of good practice, for example:

	transfer_input_files = /home/username/path/to/my_software.tar.gz

Where `username` refers to your username on our OSG Connect login node.

# Get Help

For assistance or questions, please email the OSG Research Facilitation team
at [support@osg-htc.org](mailto:support@osg-htc.org) or visit the 
[help desk and community forums](http://support.opensciencegrid.org).
