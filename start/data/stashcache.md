[title]: - "Transferring Data with StashCache"
[TOC]

## What is StashCache?

StashCache is a data service for OSG which transparently caches data near compute sites for faster delivery to active grid jobs.  The standard practice of using HTCondor file transfer or http to move data files to grid sites can be inefficient for certain workflows.  StashCache uses a distributed network filesystem (based on XRootD proxy caching) which provides an alternative method for transferring input files to compute sites.  It is implemented through a handful of strategically-distributed sites which provide caching of the input data files.

## When to use StashCache

StashCache typically outperforms other methods in the following cases:

* Jobs require large data files (> 500 MB)
* The same data files are used repeatedly for many separate jobs

## How to use StashCache

StashCache is available at all OSG sites where OASIS is mounted and can be used for both job input and output.

### Transfer job input from StashCache

To use it for transferring files to active jobs:

1)  Copy the data files required for the job(s) into your `/public` Stash directory which is mounted on the OSG Connect login node here:

	/public/<userid>/

2)  Include the following lines in the job's submit script to indicate that StashCache is required and the necessary modules are available:

	+WantsStashCache = true
	requirements = OSGVO_OS_STRING == "RHEL 7" && Arch == "X86_64" && HAS_MODULES == True

3)  Use the 'stashcp' command-line tool in the job wrapper script to transfer necessary data files to the compute host.  

First load the stashcp module:

	module load stashcache

Then transfer your data:
	
	stashcp /osgconnect/<userid>/<stash_data_file_path> <target_location>

Note how the `/public` directory is mapped to the `/osgconnect` namespace under StashCache. For example, if the data file is located at `/public/<userid\>/samples/sample01.dat`, then the `stashcp` command to transfer this file into your current working directory on the compute host would be:

	stashcp /osgconnect/<userid>/samples/sample01.dat  .

### Transfer job output to StashCache

To transfer job output to StashCache after your analysis:

1) Ensure that your job's submit script indicates the necessary requirements to make `stashcp` available by including the following lines:
	+WantsStashCache = true
	requirements = OSGVO_OS_STRING == "RHEL 7" && Arch == "X86_64" && HAS_MODULES == True

2) Use `stashcp` to transfer the data files back to StashCache. You will need to prepend your stash location with `stash://` as follows:

	module load stashcache
	stashcp <file_name> stash:///osgconnect/<userid>/<stash_data_file_path>

For example, if you wish to transfer `output.dat` to the directory `/public/<userid\>/output/`. then the `stashcp` command would be:

	stashcp output.dat stash:///osgconnect/<userid\>/output/output.txt

___

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

## Getting Help
For assistance or questions, please email the OSG User Support team  at [support@osgconnect.net](mailto:support@osgconnect.net) or visit the [help desk and community forums](http://support.opensciencegrid.org).

