
[title]: - "Output File Transfer via HTCondor"

# Output File Transfer via HTCondor

## Overview

When your OSG Connect jobs run, any output that gets generated is specifically written to 
the execute node on which the job ran. In order to get access to your output files, a copy of 
the output must be transferred back to your OSG Connect login node. 

This guide will describe steps and important considerations specifically for transferring your 
output files back to your `/home` directory on your OSG login node. 

## Important Considerations

As described in the [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985), 
any output <1GB should be staged in your `/home` directory. For output files >1GB, 
please refer to our [Transferring Data with StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775) guide.

By default, HTCondor will transfer any files that are generated during the execution of your job(s) 
back to your `/home` directory, specifically to the directory from which the `condor_submit` 
command was performed when submitting your job(s). However, this behavior only applies to files 
in the top-level directory of where your job executes, meaning HTCondor will ignore any files 
located in subdirectories (because HTCondor ignores subdirectories when determining what needs 
to be transferred after the job completes). Several options exist for modifying this default output 
file transfer behavior - to learn more please contact us at [support@osgconnect.net](mailto:support@osgconnect.net).

**If your jobs use any input files >1GB that are transferred from your `/public` directory 
using StacheCash, it is important that these files get deleted or moved to a 
subdirectory so that HTCondor will not transfer these large files back to your `/home` directory.**

### Managing Multiple Output Files

If your jobs will generate multiple output files, we recommend combining all output into a compressed 
tar archive for convenience, particularly when transferring your results to your local computer from 
your login node. To create a compressed tar archive, inlcude steps in your bash executable script 
to first create a directory and move all of the output to this new directory, then create a tar archive. 
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
directory of your login node.


## Select Specific Output Files To Transfer to `/home` Using HTCondor

As described above, HTCondor will, by default, transfer any files that are generated during the 
execution of your job(s) back to your `/home` directory. If your job(s) will produce multiple output 
files but you only need to retain a subset of these output files, we recommend deleting the unrequired 
output files or moving the unrequired output files to a subdirectory as a step you your jobs bash 
executable script -  only the output files that remain in the top-level directory will be transferred 
bask to your `/home` directory.

In cases where a bash script is not used as the excutable of your job, you can use `transfer_output_files` 
in you HTCondor submit file to specify individual output files that should be transferred back to your 
`/home` directory. For example, if you only wish to retain `my_job.output.csv` from a set of multiple 
output files, use the following in your HTCondor submit file:

	transfer_output_files = my_job.output.csv

A note of caution when using the above: only this file will be transferred back to your `/home` directory 
and if there is a typo in the file name your job will go on hold and all progress will be lost. Be sure 
to properly test the above submit file statement with your workflow before using for a large batch of jobs.

## Get Additional Options For Managing Job Output

Several options exist for managing output file transfers back to your `/home` directory and we 
encourage you to get in touch with us at [support@osgconnect.net](mailto:support@osgconnect.net) to 
help identify the best solution for your needs.
