[title]: - "Scale Up your Workflow on OSG Connect"
[TOC]

## Background

Much of OGS's computing power comes from the ability to run a large number 
of jobs simulateously. Many HTC-friendly workflows involve running the same 
job multiple times with no or minor changes between them. Here, we will 
talk about how to submit multiple jobs at once using the `queue` command as 
well as some important considerations and tips for scaling up your HTCondor jobs. 
For a hands-on example of these concepts, checkout the [OSG Connect Quickstart]
(https://support.opensciencegrid.org/support/solutions/articles/5000633410-osg-connect-quickstart). 

## Things to Consider

In order to avoid confusion, let's review some HTCondor terminiology:
 - When you queue a single submit script using the `condor_submit` command, this is 
called a **cluster** and can consist of one more individual jobs.
 - Each individual job within a cluster is called a **process**. Therefore, each 
*cluster* can be made up of one or more *processes*. Each process lands on its 

own job slot and is handled individually from the other processes in the cluster.

### Handling Output

HTCondor has built in features that make submitting multiple jobs with the same 
submit script possible and easy. However, this means that you will need to ensure 
that the output created by each individual process will be uniquely identified so 
it is not overwritten by the output from other processes.

In order to uniquely identify each job output, you can use cluster and process IDs
in the submit script. For example, to route each job log into it's own file, the 
following line would ensure that each job's log file would end up with a unique file 
name:

	log = job.$(Cluster).$(Process).log

For a working example on how to use this in a submit file, and additional applications,
please see [Job 3 of the OSG Connect Quickstart guide]
(https://support.opensciencegrid.org/support/solutions/articles/5000633410-osg-connect-quickstart#job-3-submitting-jobs-concurrently)

### Submitting Multiple Jobs with a Single Script

The easiest way to submit multiple jobs from a single submit script is to follow 
queue line in the submit script with a number. For example, if we edit the `queue`
line to read:

	queue 100
	
HTCondor will then submit 100 **processes** within 1 **cluster**. Each of these 
*processes* will have the same *cluster* ID. but will each have their own unique 
*process* ID. Checkout the Handling Output section for more information on how 
to use these IDs to uniquely tag output and job logs.

The queue command can also be used to queue a list of values from an input file 
or list. For more details on the different possibilities for the `queue` command, 
visit [UW-Madison CHTC's Documentation](http://chtc.cs.wisc.edu/multiple-jobs.shtml)


### Disk Usage

Each OSG Connect user is granted 100 GB of storage in their `/home` directory and 
500 GB of storage in their `/public` directories. This may seem like a lot, but 
when running many jobs this can fill quickly. As the number of jobs submitted 
simultaneously increases, so will storage usage on the connect login nodes. For 
example, if a single job creates 1 GB of output, running 1000 such jobs will 
generate approximately 1 TB of output. 

To prevent errors or workflow interruption, carefully consider disk usage for your jobs.
By default, HTCondor will transfer back any new files created inside the jobs working 
directory. Adding clean up steps to remove intermediate and/or unnecessary files after 
your analysis is complete will help reduce the amount of space used and help prevent 
running into that quota limit.

### Debugging Jobs

Testing your jobs and workflows is always strongly recommended, but it is of even 
more importance when submitting a large number of jobs. Start out with running a 
single job. When it completes with no errors, then try a small number - about 10. 
Use this to ensure that the jobs complete successfully, produce the desired 
output, and do not conflict with each other. Once you are confident that the jobs 
will complete as desired, submit your large workflow.


### Workflow Management

To help manage complicated workflows, consider a workflow manager such as [Pegasus]
(https://support.opensciencegrid.org/support/solutions/articles/5000639789-pegasus) or
[DAGman](https://research.cs.wisc.edu/htcondor/dagman/dagman.html), HTCondor's built 
in meta-scheduler.
