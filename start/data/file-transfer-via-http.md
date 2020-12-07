[title]: - "Transfer Input Files >100MB In Size"

[TOC] 

# Overview

Due to the distributed configuration of the OSG, more often than not, your 
jobs will need to bring along a copy (i.e. transfer a copy) of data, code, 
packages, software, etc. to the execute node where the job will run. This 
requirement applies to any and all files that are needed to successfully 
execute and complete your job that otherwise do not exist on OSG execute servers.

**This guide will describe steps and important considerations for transferring 
your files that are >100MB but <1GB using the HTTP file transfer mechanism via 
the HTCondor submit file.**   

# Important Considerations

As described in the [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) 
any data, files, or even software that is >100MB should be staged in your 
`/public` directory on your login node. Files in your `/public` directory 
that are <1GB can be transferred with your jobs via HTTP using your HTCondor submit file.

**If you have files that are >1GB please see our 
[Transfer Large Input and Output Files >1GB In Size](https://support.opensciencegrid.org/support/solutions/articles/12000002775) guide.**

# Transfer Files From `/public` Using HTTP

To transfer files staged in your `/public` directory, use an HTTP URL in 
combination with the `transfer_input_files` statement in your HTCondor submit. 
For example:

	transfer_input_files = http://stash.osgconnect.net/public/username/path/my_software.tar.gz

Where `username` refers to your OSG Connect username. Multiple URLs can 
be specified using a comma-separated list, and a combination of URLs and 
files from `/home` directory can be provided in a comma separated list. For example,

	transfer_input_files = http://stash.osgconnect.net/public/username/path/my_software.tar.gz, /home/username/my_data.csv

# Transfer Files Directly From The Web Using HTTP

Files that are available on the web, and are <1GB in size, can also be 
transferred with your jobs via HTTP using `transfer_input_files`. Examples 
of files that are available on the web that may be needed for your jobs 
include precompiled binaries (i.e. software), data in public repositories, 
etc. Like the example above, use a URL in comnbination with the 
`transfer_input_files` statement in your HTCondor submit file. For 
example, to have a copy of the Blast precompiled binaries transferred 
with your jobs you can use: 

	transfer_input_files = https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.0+-x64-linux.tar.gz

# Get Help

For assistance or questions, please email the OSG User Support team  at [support@osgconnect.net](mailto:support@osgconnect.net) or visit the [help desk and community forums](http://support.opensciencegrid.org).

