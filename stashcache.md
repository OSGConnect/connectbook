[title]: - "Transferring data with StashCache"

What is StashCache?
-------------------

StashCache is a data service for OSG which transparently caches data near compute sites for faster delivery to active grid jobs.  The standard practice of using HTCondor file transfer or http to move data files to grid sites can be inefficient for certain workflows.  StashCache uses a distributed network filesystem (based on XRootD proxy caching) which provides an alternative method for transferring input files to compute sites.  It is implemented through a handful of strategically-distributed sites which provide caching of the input data files.

When to use StashCache
-----------------------

StashCache typically outperforms other methods in the following cases:

* Jobs require large data files (> 500 MB)
* The same data files are used repeatedly for many separate jobs

How to use StashCache
---------------------

StashCache is available at all OSG sites where OASIS is mounted. To use it for transferring files to active jobs:

1)  Copy the data files required for the job(s) into your Stash directory which is mounted on the OSG Connect login node here:

	/stash/user/<userid>/

Alternatively, users can [use Globus](<https://support.opensciencegrid.org/solution/articles/5000632397-data-transfer-with-globus>) to transfer data files to Stash.

2)  Include the following line in the job's submit script to indicate that StashCache is required:

	+WantsStashCache = true

3)  Use the 'stashcp' command-line tool in the job wrapper script to transfer necessary data files to the compute host.  

First load the stashcp module:

	module load stashcp 

Then transfer your data:
	
	stashcp -s <source> user/<userid>/<stash_data_file_path> -l <target_location>

The <source\> must be given as a relative path to the data file location within the stash directory.  For example, if the data file is located at /stash/user/<userid\>/samples/sample01.dat, then the stashcp command to transfer this file into your current working directory on the compute host would be:

	stashcp -s user/<userid>/samples/sample01.dat -l .
___

More usage options are described in the stashcp help message:

	$ stashcp -h
	stashcp [-d] [-r] [-h] -s <source> [-l <location to be copied to>]

	-d: show debugging information
	-r: recursively copy
	-h: show this help text

	--closest: return closest cache location

	Exit status 4 indicates that at least one file did not successfully copy over.
	Exit status 1 indicates that the WantsStashCache classad was not present in job environment.


