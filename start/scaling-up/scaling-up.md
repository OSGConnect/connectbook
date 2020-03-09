[title]: - "Scaling Up!"
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
*cluster* can be made up of one or more *processees*. Each proceess lands on its 
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

### Disk Usage



### Debugging Jobs

Testing your jobs and workflows is always strongly recommended, but it is of even 
more importance when submitting a large number of jobs. Start out with running a 
single job. When it completes with no errors, then try a small number - about 10. 
Use this to ensure that the jobs complete successfully, produce the desired 
output, and do not conflict with each other. Once you are confident that the jobs 
will complete as desired, submit your large workflow.

## Scale up your HTCondor Jobs

### Available Tools

When scaling up ...

-- Briefly touch on DAGMAN and/or pegasus here (including links to docs) --
