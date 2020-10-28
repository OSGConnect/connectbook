[title]: - "Transfer Large Input and Output Files &gt;1GB In Size"

[TOC]

# Overview

StashCache is a data service for OSG which transparently caches data near 
compute sites for faster delivery of large files. StashCache is an alternative 
method for transferring large files needed or produced by your jobs and 
requires the use of a bash script as the executable of your job.

# Important Considerations

As described in the [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) 
any data, files, or even software that is >100MB should be staged in 
your `/public` directory and only input and output files >1GB and <10GB 
should be transferred using StashCache. 

# Use StashCache To Tranfer Large Input Files 

1) Place your large files your `/public` public directory  
which is accessible via your OSG Connect login node at `/public/username` 
for which our 
[Using scp To Transfer Files To OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000634376) 
guide may be helpful.

2) Add the following two lines to your HTCondor submit file to tell 
HTCondor that your jobs must run on executes nodes that 
have access StashCache and to OSG Connect modules.

		+WantsStashCache = true
		requirements = (OSGVO_OS_STRING =?= "RHEL 7") && (HAS_MODULES =?= True)

3) Add three commands to the job executable script to (1) load the StashCache 
module, (2) use the command `stashcp` to transfer the large input file 
from a cache site to the execute node where the job is running, and (3) 
delete the large input file before the job terminates:

		#!/bin/bash
		
		#load module   
		module load stashcache   
		
		#transfer large input file   
		stashcp /osgconnect/public/username/path/<file_name> ./   
		
		#remaining commands to be executed in job   
		
		...   
		
		#delete large input from public   
		rm <file_name>   

Any large input files transferred from `/public` should be deleted before 
the job terminates, otherwise HTCondor will mistake these files for output 
and will transfer them back to your home directory.

**Note how the `/public` directory is mapped to the `/osgconnect/public` namespace 
under StashCache. For example, if the data file is located at 
`/public/username/samples/sample01.dat`, then the `stashcp` command to 
transfer this file into your current working directory on the compute host would be:**

	stashcp /osgconnect/public/username/samples/sample01.dat  ./

# Use StashCache To Tranfer Large Output Files 

To transfer job output to StashCache after your analysis:

1) Ensure that your job's submit script indicates the necessary requirements to 
make `stashcp` available by including the following lines:

		+WantsStashCache = true
		requirements = OSGVO_OS_STRING == "RHEL 7" && Arch == "X86_64" && HAS_MODULES == True

2) Use `stashcp` to transfer the data files back to StashCache. You will 
need to prepend your stash location with `stash://` as follows:

		module load stashcache
		stashcp <file_name> stash:///osgconnect/public/username/path/<file_name>

For example, if you wish to transfer `output.dat` to the directory 
`/public/username/output/` then the `stashcp` command would be:

	stashcp output.dat stash:///osgconnect/public/username/output/output.dat

**Notice that the output file name `output.dat` must be included at the end of the 
`/public` path where the file will be transferred.**

More usage options are described in the stashcp help message:

	$ stashcp -h
	Usage: stashcp [options] source destination

	Options:
	  -h, --help            show this help message and exit
	  -d, --debug           debug
	  -r                    recursively copy
	  --closest             Return the closest cache and exit
	  -c CACHE, --cache=CACHE
							Cache to use
	  -j CACHES_JSON, --caches-json=CACHES_JSON
							The JSON file containing the list of caches
	  --methods=METHODS     Comma separated list of methods to try, in order.
							Default: cvmfs,xrootd,http
	  -t TOKEN, --token=TOKEN
							Token file to use for reading and/or writing

# Get Help

For assistance or questions, please email the OSG User Support team 
at [support@osgconnect.net](mailto:support@osgconnect.net) or visit 
the [help desk and community forums](http://support.opensciencegrid.org).
