
[title]: - "Software Transfer via HTCondor or HTTP"
 

# Software Transfer via HTCondor

## Overview

For some OSG Connect users, it may be necessary or advatageous to install your own software. This guide will 
describe steps and important considerations for transferring your installed software via the HTCondor submit file.  

## Important Considerations

How you transfer your software via HTCondor will depend on the size and location of the executable binary or tar archive 
that needs to be transferred along with your jobs. Only software files <100MB staged in your `/home` directory or files 
>100MB but <1GB staged in your `/public` directory should be transferred via HTCondor using the steps described below. Please see the [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) guide for more information regarding our policies for staging files (data, software, etc.) in OSG Connect.  

Keep in mind that HTCondor will always transfer the script or executable binary that is specified as the `executable` in your submit. As such, it is not necessary to follow the steps below if your software is the designated executable in your submit file.  

The steps and considerations described below also apply to transferring data, and other files, as described in the [Transfering Data With HTCondor](https://support.opensciencegrid.org/support/solutions/articles/5000639787) guide.

## Transferring Software From `/home`

Software executables and tar archives that are <100MB should be staged in your `/home` directory. To transfer software 
from your `/home` directory use the `transfer_input_files` statement in your HTCondor submit file. For example:

	transfer_input_files = path/to/my_software.tar.gz

> When using `transfer_input_files` to transfer files located in `/home`, keep in mind that the path to the file is 
> relative to the location of the submit file. If you have software located in a different `/home` subdirectory,
> we recommend specifying the full path those files, which is also a matter of good practice, for exmaple:
> ```
> transfer_input_files = /home/username/path/to/my_software.tar.gz
> ```
> Where `username` refers to your OSG Connect username.

In addition to any software needed for your jobs, be sure to also include other required input files, for example:

	transfer_input_files = path/to/my_software.tar.gz, path/to/my_input.csv

## Transferring Software from `/public`

Software executables and tar archives that are >100MB should be staged in your `/public` directory. Only software  
located in `/public` that is <1GB should be transferred using `transfer_input_files` in your submit file. If you have software that is &gt;1GB please plan to use [SStashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775). 

Transferring software from `/public` using the `transfer_input_files` statement in your HTCondor submit file will occur via 
an HTTP connection, for example:

	transfer_input_files = http://stash.osgconnect.net/public/username/path/my_software.tar.gz

Where `username` refers to your OGS Connect username. 

Precompiled binaries that are available on the web may also be transferred via HTTP using `transfer_input_files`, 
For example, Blast precompiled binaries are available from the NCBI at https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.0+-x64-linux.tar.gz. We can use HTCondor to transfer this tar archive of precompiled binaries (which is 222MB in size):

	transfer_input_files = https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.0+-x64-linux.tar.gz

	
	

