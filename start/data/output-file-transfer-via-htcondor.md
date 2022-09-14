[title]: - "Transfer Job Output Files Up To 1GB In Size"

[TOC]

# Overview

When your jobs run, any output that gets generated is specifically written to 
the execute node on which the job ran. In order to get access to your output files, a copy of 
the output must be transferred back to your OSG Connect login node. 

This guide will describe the necessary steps, along with important considerations, for transferring your 
output files back to your `/home` directory on your OSG Connect login node. 

# Important Considerations

As described in the [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985), 
any output <1GB should be staged in your `/home` directory. For output files >1GB, 
please refer to our [Transfer Large Input and Output Files >1GB In Size](https://support.opensciencegrid.org/support/solutions/articles/12000002775) guide.

**If your jobs use any input files >1GB that are transferred from your `/public` directory 
using StacheCash, it is important that these files get deleted from the job's working directory or moved to a 
subdirectory so that HTCondor will not transfer these large files back to your `/home` directory.**

# Use HTCondor To Transfer Output &lt;1GB

By default, HTCondor will transfer any new or modified files in the job's 
top-level directory back to your `/home` directory location from which 
the `condor_submit` command was performed. **This behavior only applies 
to files in the top-level directory of 
where your job executes, meaning HTCondor will ignore any files 
created in subdirectories of the job's top-level directory.** Several 
options exist for modifying this default output file transfer behavior, including 
those described in this guide. To learn more, please contact us 
at [support@osg-htc.org](mailto:support@osg-htc.org).

*What is the top-level directory of a job?*

Before executing a job, HTCondor will create a new directory on the execute 
node just for your job - this is the top-level directory of the job and the 
path is stored in the environment variable `_CONDOR_SCRATCH_DIR`. All of the 
input files transferred via `transfer_input_files` will first be written to 
this directory and it is from this path that a job starts to execute. After 
a job has completed the top-level directory and all of it's contents are 
deleted.

*What if my output file(s) are not written to the top-level directory?*

If your output files are written to a subdirectory, use the steps described 
[below](#group-multiple-output-files-for-convenience) to convert the output 
directory to a "tarball" that is written to the top-level directory. 

Alternatively, you can include steps in the executable bash script of 
your job to move (i.e. `mv`) output files from a subdirectory to 
the top-level directory. For example, if there is an output file that 
needs to be transferred back to the login node named `job_output.txt` 
written to `job_output/`:

	#! /bin/bash
	
	# various commands needed to run your job
	
	# move csv files to scratch dir
	mv job_output/job_output.txt $_CONDOR_SCRATCH_DIR

## Group Multiple Output Files For Convenience

If your jobs will generate multiple output files, we recommend combining all output into a compressed 
tar archive for convenience, particularly when transferring your results to your local computer from 
your login node. To create a compressed tar archive, include commands in your your bash executable script 
to create a new subdirectory, move all of the output to this new subdirectory, and create a tar archive. 
For example:

	#! /bin/bash
	
	# various commands needed to run your job
	
	# create output tar archive
	mkidr my_output
	mv my_job_output.csv my_job_output.svg my_output/
	tar -czf my_job.output.tar.gz my_ouput/

The example above will create a file called `my_job.output.tar.gz` that contains all the output that 
was moved to `my_output`. Be sure to create `my_job.output.tar.gz` in the top-level directory of where 
your job executes and HTCondor will automatically transfer this tar archive back to your `/home` 
directory.

## Select Specific Output Files To Transfer to `/home` Using HTCondor

As described above, HTCondor will, by default, transfer any files that are generated during the 
execution of your job(s) back to your `/home` directory. If your job(s) will produce multiple output 
files but you only need to retain a subset of these output files, we recommend deleting the unrequired 
output files or moving them to a subdirectory as a step in the bash 
executable script of your job -  only the output files that remain in the top-level 
directory will be transferred back to your `/home` directory.

In cases where a bash script is not used as the excutable of your job and you wish to have only specific 
output files transferred back, please contact us at [support@osg-htc.org](mailto:support@osg-htc.org).

# Get Additional Options For Managing Job Output

Several options exist for managing output file transfers back to your `/home` directory and we 
encourage you to get in touch with us at [support@osg-htc.org](mailto:support@osg-htc.org) to 
help identify the best solution for your needs.
