[title]: - "Transfer Larger Input and Output Files"

[TOC]

*As of June 2022, users are no longer recommended to transfer large output files using `stashcp` and instead should use HTCondor's `transfer_output_remaps` feature. More information on this transition can be found below. Please direct any questions about this change to support@osg-htc.org*

# Overview

For input files >100MB and output files >1GB in size, the default HTCondor file transfer mechanisms
run the risk of over-taxing the login nodes and their network capacity. And this is exactly why the 
**[OSG Data Federation](https://opensciencegrid.org/about/osdf/)** exists for researchers with larger 
per-job data!

Users on an
OSG Connect login node can handle such files via the OSG Connect **data caching origin** 
(mounted and visible as the `/public` location) and use OSG's caching tools to 
scalably transfer them between the running jobs and the origin. 
The OSG caching tools ensure faster delivery to and from execute nodes by taking adantage of 
regional data caches in the OSG Data Federation, while preserving login node performance.

# Important Considerations and Best Practices

1. As described in OSG Connect's [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985), 
the `/public` location **must** be used for:

	- Any **input data or software larger than 100MB** for 
	transfer to jobs using OSG caching tools
	- Any per-job **output >1GB and <10GB**, which 
	should ONLY be transferred back to the origin by setting `transfer_output_remaps` in the job's submit file. 

2. **User must never submit jobs from the `/public` location,** and should continue to 
ONLY submit jobs from within their `/home` directory. All `log`, `error`, `output` 
files and any other files smaller than the above values should ONLY ever
exist within the user's /home directory, unless otherwise directed by an OSG staff member. 

	Thus, **files within the `/public` location should only be referenced within 
	the submit file by using the methods described further below**.
	
	The `/public` location is a mount of the OSG Connect origin filesystem. It is mounted to the 
	OSG Connect login nodes only so that users can appropriately stage large job inputs or retrieve outputs via 
	the login nodes.

3. Because of impacts to the filesystem of the data origin, **files in the data origin (`/public`) should 
be organized in one or very few files per job.** The filesystem is likely to encounter performance issues 
if/when files accumulated there are highly numerous and/or small.

4. **The `/public` location is otherwise unnecessary for smaller files** (which can and should be served 
via the user's /home directory and regular HTCondor file transfer). Smaller files should only be handled 
via `/public` with explicit instruction from an OSG staff member.

5. **Files placed within a user's `/public` directory are publicly accessible**, 
discoverable and readable by anyone, via the web. Data is made public via `stash` 
transfer (and, thus, via http addresses), and mirrored to a shared data repository 
which is available on a large number of systems around the world.


# Use a 'stash' URL to Transfer Large Input Files to Jobs 

Jobs submitted from the OSG Connect login nodes will transfer data from the origin  
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
have access to the Open Science Data Federation.

		# Submit file example of large input/software transfer
		
		log = my_job.$(Cluster).$(Process).log
		error = my_job.$(Cluster).$(Process).err
		output = my_job.$(Cluster).$(Process).out
		
		#Transfer input files
		transfer_input_files = stash:///osgconnect/public/<username>/<dir>/<filename>, <other files>
		
		...other submit file details...

	
	**Note how the `/public` mount (visible on the login node) corresponds to the `/osgconnect/public` namespace 
	across the Open Science Federation.** For example, if the data file is located at 
	`/public/<username>/samples/sample01.dat`, then the `stash:///` URL to 
	transfer this file to the job's working directory on the execute point would be:

		stash:///osgconnect/public/<username>/samples/sample01.dat

# Use `transfer_output_remaps` to Transfer Larger Job Outputs to the Data Origin

For output, users should use the **`transfer_output_remaps`** option within their job's submit file, 
which will transfer the user's specified file to the specific location in the data origin. 

By using `transfer_output_remaps`, it is possible to specify what path to save a file to and what name to save it under. Using this approach, it is possible to save files back to specific locations in `/public` (as well as your `/home` directory, if desired).

The syntax for `transfer_output_remaps` is: 

```
transfer_output_remaps = "Output.txt = path/to/save/file/under/output.txt; Output.txt = path/to/save/file/under/RenamedOutput.txt"
```

When saving large output files back to `/public`, the path provided will look like: 

```
transfer_output_remaps = "Output.txt = stash:///osgconnect/public/<username>/Output.txt"
```	
	
1. Using `transfer_output_remaps`, tell HTCondor which output files need to be transferred back to your `/public` directory and what name you want these files to be saved under. 

		# submit file example for large output
		
		log = my_job.$(Cluster).$(Process).log
		error = my_job.$(Cluster).$(Process).err
		output = my_job.$(Cluster).$(Process).out
		
		requirements = (OSGVO_OS_STRING =?= "RHEL 7")
		
		transfer_output_remaps = "Output.txt = stash:///osgconnect/public/<username>/Output.txt"
		
		...other submit file details...

2. If you have several output files being sent to `/public`, you may wish to define a new submit file variable to avoid having to re-write the `stash:///` path repeatedly. For example, 

		# submit file example for large output
		
		log = my_job.$(Cluster).$(Process).log
		error = my_job.$(Cluster).$(Process).err
		output = my_job.$(Cluster).$(Process).out
		
		requirements = (OSGVO_OS_STRING =?= "RHEL 7")
		
		STASH_LOCATION = stash:///osgconnect/public/<username>
		transfer_output_remaps = "file1.txt = $(STASH_LOCATION)/file1.txt; file2.txt = $(STASH_LOCATION)/file2.txt; file3.txt = $(STASH_LOCATION)/file3.txt"
		
		...other submit file details...


<!--
As described in [Important Considerations](#important-considerations), 
once a file is added to `/public` any changes and modifications made 
to the file will not be propagated due to caching. In the event that your 
jobs need to be resubmitted or restarted, we strongly recommend that your 
larger output files be given unique names in `/public`. If your jobs aren't already 
structured to provide unique output filenames, several options are to include 
[epoch](https://en.wikipedia.org/wiki/Unix_time) time, cluster and process ID, or other unique variables. For example, renaming a file to contain cluster and process ID information could look like: 

	transfer_output_remaps = "file.txt = $(STASH_LOCATION)/$(ClusterId)_$(ProcId)_file.txt"
	
Cluster ID and Process ID are HTCondor pre-defined variables. Additional pre-defined variables can be found in the (HTCondor manual)[https://readthedocs.org/projects/htcondor/downloads/pdf/latest/].

--->

# Phase out of Stashcp command

Historically, output files could be transferred from a job to a `/public` location using the `stashcp` command within the job's executable, however, this mechanism is no longer encouraged for OSPool users. Instead, jobs should use `transfer_output_remaps` (an HTCondor feature) to transfer output files to `/public`. By using `transfer_output_remaps`, HTCondor will manage the output data transfer for your jobs. Data transferred via HTCondor is more likely to be transferred successfully and errors with transfer are more likely to be reported to the user. 

# Get Help

For assistance or questions, please email the OSG Research Facilitation team 
at [support@osg-htc.org](mailto:support@osg-htc.org) or visit 
the [help desk and community forums](http://support.opensciencegrid.org).
