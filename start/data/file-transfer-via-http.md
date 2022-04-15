[title]: - "Transfer HTTP-available Files up to 1GB In Size"

[TOC] 

# Overview

If some of the data or software your jobs depend on is available via the web, 
you can have such files transferred by HTCondor using the appropriate HTTP address! 

# Important Considerations

While our [Overview of Data Mangement on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) 
describes how you can stage data, files, or even software in OSG Connect locations, 
any web-accessible file can be transferred directly to your jobs **IF**:

- the file is accessible via an HTTP address
- the file is less than 1GB in size (if larger, you'll need to pre-stage them for [stash-based transfer](12000002775)
- the server or website they're on can handle large numbers of your jobs accessing them simultaneously

Importantly, you'll also want to make sure your job executable knows how to handle the file 
(un-tar, etc.) from within the working directory of the job, just like it would for any other input file.

# Transfer Files via HTTP

Use an HTTP URL in 
combination with the `transfer_input_files` statement in your HTCondor submit file. 

For example:

	# submit file example
	
	log = my_job.$(Cluster).$(Process).log
	error = my_job.$(Cluster).$(Process).err
	output = my_job.$(Cluster).$(Process).out
	
	# transfer software tarball from public via http
	transfer_input_files = http://www.website.com/path/file.tar.gz
	
	...other submit file details...

Multiple URLs can 
be specified using a comma-separated list, and a combination of URLs and 
files from `/home` directory can be provided in a comma separated list. For example,

	# transfer software tarball from public via http
	# transfer input data from home via htcondor file transfer
	transfer_input_files = http://www.website.com/path/file1.tar.gz, http://www.website.com/path/file2.tar.gz, my_data.csv

# Get Help

For assistance or questions, please email the OSG Research Facilitation team  at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).

