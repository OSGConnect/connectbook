[title]: - "Transfer Large Input and Output Files"

[TOC]

# Overview

For input files >100MB and output files >1GB in size, the default HTCondor file transfer mechanisms
run the risk of over-taxing the login nodes and their network capacity. And this is exactly why the 
**[OSG Data Federation](https://opensciencegrid.org/about/osdf/)** exists for researchers with larger 
per-job data!

Users on an
OSG Connect login node can handle such files via the OSG Connect **data caching origin** 
(mounted and visible as the `/public` location) and use OSG's 'StashCache' tools to 
scalably transfer them between the running jobs and the origin. 
The StashCache tools ensure faster delivery to and from execute nodes by taking adantage of 
OSG's regional data caches, while preserving login node performance.

# Important Considerations and Best Practices

1. As described in OSG Connect's [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985), 
the `/public` location **must** be used for:

	- Any **input data or software larger than 100MB** for 
	transfer to jobs using StashCache tools
	- Any per-job **output >1GB and <10GB**
	should ONLY be transferred back to the origin using a StashCache `stashcp` command within the job executable. 

2. **User must never submit jobs from the `/public` location,** and should continue to 
ONLY submit jobs from within their `/home` directory. All `log`, `error`, `output` 
files and any other files smaller than the above values should ONLY ever
exist within the user's /home directory, unless otherwise directed by an OSG staff member. 

	Thus, **files within the `/public` location should only be referenced within 
	the submit file by using the StashCache tools described further below**, and should 
	never be listed for direct HTCondor transfer via `transfer_input_files`, 
	`transfer_output_files`, or `transfer_output_remaps`.
	
	The `/public` location is a mount of the OSG Connect origin filesystem. It is mounted to the 
	OSG Connect login nodes only so that users can appropriately stage large job inputs or retrieve outputs via 
	the login nodes.

3. Because of impacts to the filesystem of the data origin, **files in the data origin (`/public`) should 
be organized in one or very few files per job.** The filesystem is likely to encounter performance issues 
if/when files accumulated there are highly numerous and/or small.

4. **The `/public` location is otherwise unnecessary for smaller files** (which can and should be served 
via the user's /home directory and regular HTCondor file transfer). Smaller files should only be handled 
via `/public` with explicit instruction from an OSG staff member.


# Use a StashCache URL to Transfer Large Input Files to Jobs 

Jobs submitted from the OSG Connect login nodes will transfer data from the origin via StashCache  
when files are indicated with an appropriate `stash:///` URL in the `transfer_input_files` line 
of the submit file:

1. Upload your larger input and/or software files to your `/public` directory 
which is accessible via your OSG Connect login node at `/public/username` 
for which our 
[Using scp To Transfer Files To OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000634376) 
guide may be helpful.

	**Because of the way your files in `/public` are cached across the Open Science Pool, 
	any changes or modifications that you make after placing a file in `/public`
	will not be propagated.** This means that if you add a new version 
	of a file to your `/public` directory, it must first be given a unique name (or directory path)
	to distinguish it from previous versions of that file. Adding a date or 
	version number to directories or file names is strongly encouraged to manage your files in 
	`/public`.

2. Add the necessary details to your HTCondor submit file to tell 
HTCondor which files to transfer, and that your jobs must run on executes nodes that 
have access StashCache.

		# Submit file example of StashCache input/software transfer
		
		log = my_job.$(Cluster).$(Process).log
		error = my_job.$(Cluster).$(Process).err
		output = my_job.$(Cluster).$(Process).out
		
		#Transfer input files
		transfer_input_files = stash:///osgconnect/public/<username>/<dir>/<filename>, <other files>
		
		...other submit file details...

	
	**Note how the `/public` mount (visible on the login node) corresponds to the `/osgconnect/public` namespace 
	across the OSG's StashCache system.** For example, if the data file is located at 
	`/public/<username>/samples/sample01.dat`, then the `stash:///` URL to 
	transfer this file to the job's working directory on the execute point would be:

		stash:///osgconnect/public/<username>/samples/sample01.dat

# Use `stashcp` to Transfer Larger Job Outputs to the Data Origin

For output, users should use the **`stashcp`** command within their job executable, 
which will transfer the user's specified file to the specific location in the data origin. 

[Remember that you should NEVER list a `/public` location
within the submit file (e.g. in 'transfer_output_remaps`) or submit jobs from within `/public`](https://support.opensciencegrid.org/support/solutions/articles/12000002985).

1. Add the necessary details to your HTCondor submit file to tell 
HTCondor that your jobs must run on executes nodes that 
have access to the `stashcp` module (among other OSG-supported modules).

		# StashCache submit file example
		
		log = my_job.$(Cluster).$(Process).log
		error = my_job.$(Cluster).$(Process).err
		output = my_job.$(Cluster).$(Process).out
		
		requirements = (OSGVO_OS_STRING =?= "RHEL 7") && (HAS_MODULES =?= true)
		
		...other submit file details...

2. Add a `stashcp` command at the end of your executable to transfer the data files back to `/public`. You will 
need to prepend your `/public` directory path with `stash:///osgconnect` as follows:

		#!/bin/bash
	
		# other commands to be executed in job: 
		
		# transfer large output to public
		stashcp <filename> stash:///osgconnect/public/username/path/<filename>

	For example, if you wish to transfer `output.dat` to the directory 
	`/public/<username>/output/` then the `stash` command would be:

		stashcp output.dat stash:///osgconnect/public/<username>/output/output.dat

	**Notice that the output file name `output.dat` must be included at the end of the 
	`/public` path where the file will be transferred, which also allows you to rename the file.**

<!--
As described in [Important Considerations](#important-considerations), 
once a file is added to `/public` any changes and modifications made 
to the file will not be propagated due to caching. In the event that your 
jobs need to be resubmitted or restarted, we strongly recommend that your 
larger ouptut files be given unique names in `/public`. If your jobs aren't already 
structured to provide unique output filenames, one option is to include 
[epoch](https://en.wikipedia.org/wiki/Unix_time) time in the output file name 
using the following example:

	#!/bin/bash
	
	# commands to be executed in job     
	
	# transfer large output to public
	# add epoch time to output file name to make unqiue
	unique=`date +%s`
	stashcp file_name stash:///osgconnect/public/username/path/$unique.file_name
	
If you would instead like a more detailed date and time stamp added to the 
file name, you can modify the `date` command. One alternative to consider is 
``unique=`date +"%Y-%m-%d.%H-%M-%S"` `` which will set `unique` to 
`year-month-day.hour-minute-seconds`.
--->

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
at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) or visit 
the [help desk and community forums](http://support.opensciencegrid.org).
