[title]: - "Transfer Large Input and Output Files >1GB In Size"

[TOC]

# Overview

Due to the distributed configuration of the OSG, more often than not, 
your jobs will need to bring along a copy (i.e. transfer a copy) of 
data, code, packages, software, etc. from the login node where the job 
is submitted to the execute node where the job will run. This requirement 
applies to any and all files that are needed to successfully execute and 
complete your job that do not otherwise exist on OSG execute servers.

For input and output files >1GB in size, OSG Connect's StashCache should 
be used for transferring these input and output files to and from OSG 
login and execute servers. StashCache is a transparent and reliable system 
that caches your large files at sites across the country for faster delivery of 
large files. StashCache is an alternative method *specifically* for 
transferring **large** files needed for or produced by your jobs and 
requires additional HTCondor submit file script details and additional 
steps in the executable bash script used for your jobs.

# Important Considerations

As described in OSG Connect's [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985), 
any data, files, or even software that is >100MB should be staged in 
your `/public` directory and **any** input and output files >1GB and <10GB 
should be transferred to and from your `public` directory using StashCache 
during the execution of your jobs.

**Because of the way your files in `/public` get cached across StashCache, 
once a file is added to `/public` any changes or modifications that you 
make to the file will not be propagated.** This means if you add a new version 
of a file to your `/public` directory, it must first be given a unique name 
to distinguish it from previous versions of that file. Adding a date or 
version number to file names is strongly encouraged to manage you files in 
`/public`. Additionally, directories with unique names can also be used to 
organize different versions of files in `/public`.

# Use StashCache To Tranfer Large Input Files From `/public` 

1) Upload your large files to your `/public` directory 
which is accessible via your OSG Connect login node at `/public/username` 
for which our 
[Using scp To Transfer Files To OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000634376) 
guide may be helpful.

2) Add the necessary details to your HTCondor submit file to tell 
HTCondor that your jobs must run on executes nodes that 
have access StashCache and to OSG Connect modules.

		#StashCache submit file example
		
		log = my_job.$(Cluster).$(Process).log
		error = my_job.$(Cluster).$(Process).err
		output = my_job.$(Cluster).$(Process).out

		...other submit file details...

		#ensure jobs have access to StashCache
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
		stashcp /osgconnect/public/username/path/file_name ./   
		
		#remaining commands to be executed in job   
		
		...   
		
		#delete large input from public   
		rm file_name   

	Any large input files transferred from `/public` should be deleted before 
	the job terminates, otherwise HTCondor will mistake these files for output 
	and will transfer them back to your home directory.

**Note how the `/public` directory is mapped to the `/osgconnect/public` namespace 
under StashCache. For example, if the data file is located at 
`/public/username/samples/sample01.dat`, then the `stashcp` command to 
transfer this file into your current working directory on the compute host would be:**

	stashcp /osgconnect/public/username/samples/sample01.dat  ./

# Use StashCache To Tranfer Large Output Files To `/public`

To transfer large output files (>1GB) back to your `/public` directory (which 
is necessary to later access your results):

1) Add the necessary details to your HTCondor submit file to tell 
HTCondor that your jobs must run on executes nodes that 
have access StashCache and to OSG Connect modules.

		#StashCache submit file example
		
		log = my_job.$(Cluster).$(Process).log
		error = my_job.$(Cluster).$(Process).err
		output = my_job.$(Cluster).$(Process).out
		
		...other submit file details...
		
		#ensure jobs have access to StashCache
		+WantsStashCache = true
		requirements = OSGVO_OS_STRING == "RHEL 7" && HAS_MODULES == True

2) Use `stashcp` command to transfer the data files back to `/public`. You will 
need to prepend your `/public` directory path with `stash://osgconnect` as follows:

		#!/bin/bash
	
		#commands to be executed in job   
		
		...   
		
		#load module   
		module load stashcache   
		
		#transfer large output to public
		stashcp file_name stash:///osgconnect/public/username/path/file_name

	For example, if you wish to transfer `output.dat` to the directory 
	`/public/username/output/` then the `stashcp` command would be:

		stashcp output.dat stash:///osgconnect/public/username/output/output.dat

	**Notice that the output file name `output.dat` must be included at the end of the 
	`/public` path where the file will be transferred.**

As described in [Important Considerations](#important-considerations), 
once a file is added to `/public` any changes and modifications made 
to the file will not be propagated due to caching. In the event that your 
jobs need to be resubmitted or restarted, we strongly recommend that your 
large ouptut files be given unique names in `/public`. This can be achieved 
by several methods, but perhpas the most straightforward option is to include 
[epoch](https://en.wikipedia.org/wiki/Unix_time) time in the output file name 
using the following example:

	#!/bin/bash
	
	#commands to be executed in job   
		
	...   
	
	#load module   
	module load stashcache   
	
	#transfer large output to public
	# add epoch time to output file name to make unqiue
	unique=`date +%s`
	stashcp file_name stash:///osgconnect/public/username/path/$unique.file_name
	
If you would instead like a more detailed date and time stamp added to the 
file name, you can modify the `date` command. One alternative to consider is 
`unique=\`date +"%Y-%m-%d.%H-%M-%S"\`` which will set `unique` to 
`year-month-day.hour-minute-seconds`.

# Stachcp Command Manual

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
