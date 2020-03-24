
[title]: - "Software Transfer via HTCondor or HTTP"
 

# Software Transfer via HTCondor or HTTP

## Overview

For some OSG Connect users, it may be necessary or advatageous to install your own software. This guide will 
describe steps and important considerations for transferring your installed software via the HTCondor submit file.  

## Important Considerations

How you transfer your software via HTCondor will depend on the size and location of the executable binary or tar archive 
that needs to be transferred along with your jobs. Only software files <100MB staged in your `/home` directory or files 
>100MB but <1GB staged in your `/public` directory should be transferred via HTCondor using the steps described below. Please see the [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) guide for more information regarding our policies for staging files (data, software, etc.) in OSG Connect.  

Keep in mind that HTCondor will always transfer the script or executable binary that is specified as the `executable` in your submit. As such, it is not necessary to follow the steps below if your software is the designated executable in your submit file.  

The steps and considerations described belowe also apply to transferring data, and other files, as described in the [Transfering Data With HTCondor](https://support.opensciencegrid.org/support/solutions/articles/5000639787) guide.

## Transferring Software From `/home`

Software executables and tar archives that are <100MB should be staged in your `/home` directory. To transfer software 
from your `/home` directory use the `transfer_input_files` statement in your HTCondor submit file. For example:

	transfer_input_files = path/to/my_software.tar.gz

> When using `transfer_input_file` to transfer files located in `/home`, keep in mind that the path to the file is 
> relative to the location of the submit file. If you have software located in a different `/home` subdirectory,
> we recommend specifying the full path those files, which is also a matter of good practice, for exmaple:
>
> ```
> transfer_input_files = /home/username/path/to/my_software.tar.gz
> ```

In addition to any software needed for your jobs, be sure to also include other required input files, for example:

	transfer_input_files = path/to/my_software.tar.gz, path/to/my_input.csv

## Distributing Applications Using Stash and HTTP

This example is very similar to the one in [Access Stash remotely from your job using HTTP](http://support.opensciencegrid.org/support/solutions/articles/5000639798-access-stash-remotely-using-http) page.  You will be preparing the 
input files for the job, including an executable, and transferring them via HTTP. When you are transferring an executable 
instead of data you have to pay attention because Web servers or commands like wget frequently change the file permissions 
and this can cause the job to fail. To make sure that your program is executable either set manually the permission on the 
transferred file (chmod +x filename) or transfer a tar bundle and uncompress it.

Prepare the file bundle in your public html space (`/public/<username>`):

	$ ls -al /public/<username>
	...
	$ tar cvzf words.tar.gz distribution random_words
	distribution
	random_words
	$ mv words.tar.gz /public/<username>/
	$ chmod +r /public/<username>/words.tar.gz

`words.sh` is the auxiliary script to run the job:

	#!/bin/bash
	# HTCondor will transfer the file for us. Uncomment the following if you prefer to transfer form the script
	# wget --no-check-certificate http://stash.osgconnect.net/+username/words.tar.gz
	tar xzf words.tar.gz
	cat random_words | ./distribution

Here is the submit file. Note that HTCondor allows to specify an URL as input file and it will download it for you. Substitute your user name for username in the `transfer_input_files` line:

	########################
	# Submit description file for short test program using http transfer
	########################
	Universe       = vanilla
	Executable     = words.sh
	# Uncomment the following line to use the remote executable
	#transfer_executable = False
	Error   = log/words.err.$(Cluster)-$(Process)
	Output  = log/words.out.$(Cluster)-$(Process)
	Log     = log/words.log.$(Cluster)
	should_transfer_files = YES
	transfer_input_files = http://stash.osgconnect.net/+username/words.tar.gz
	when_to_transfer_output = ON_EXIT
	Queue 5

Submit the job:

	$ condor_submit words.submit
	Submitting job(s).....
	5 job(s) submitted to cluster 14038.

Once the jobs are completed, you can look at the output in the logs directory and verify that the job ran correctly:

	$ cat log/words.out.14038-2
	Ashkenazim |45 (0.44%) +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	BIOS       |45 (0.44%) +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Anaheim    |44 (0.43%) +++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Aymara     |44 (0.43%) +++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Arthurian  |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Anaxagoras |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Bactria    |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Alexis     |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Ariel      |43 (0.42%) ++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Aubrey     |42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
	Baryshnikov|42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
	Bahia      |42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
	Angstrom   |42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
	Asoka      |42 (0.41%) +++++++++++++++++++++++++++++++++++++++++++++++++++++
	Alcatraz   |41 (0.40%) ++++++++++++++++++++++++++++++++++++++++++++++++++++


