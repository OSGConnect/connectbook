[title]: - "Preparing To Scale Up Job Submission"

[TOC]

# Overview

Much of OGS's computing power comes from the ability to run a large number 
of jobs simulateously. Breaking up your work into small, independently executable 
jobs and optimizing the resource requests of those jobs, by 
only requesting the amount of memory, disk, and cpus truely needed, 
will ensure that you get the most out of OSG resources.
This is an important practice that will reduce the amount of time your 
jobs remain idle before running and which will maximize your throughput, 
all helping to get your work completed sooner.

A key aspect to high-throughput computing is to 
break up your computational work into independently 
executable tasks whenever possible. Breaking up your work not only 
increases the parallelization of your work, but also often reduces the 
memory, disk, and cpus needs for each individual task. If you have questions 
or are unsure if and how your work can be broken up, please contact us at 
<support@osgconnect.net>.

This guide will described best pactices and general tips for optimizing 
your job resource requests **before** scaling up to submitting your full set of jobs. 
Additional information is also available from the following 2020 OSG Virtual 
Pilot School lecture video:<a href="https://youtu.be/oMAvxsFJaw4">
	<img alt="2020 VSP dHTC with HTCondor" src="https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/2020-vsp-intro-dHTC-HTcondor-thumbnail.png" width="360" height="204"></a>

[Introduction to High Throughput Computing with HTCondor](https://youtu.be/oMAvxsFJaw4)

# Always Start With Test Jobs

Submitting test jobs is an important first step for optimizing 
the resource requests of your jobs. We always recommend submitting a few 
test jobs first before scaling up whether this is your first time 
using OSG or you're an experienced user starting a new workflow. 
Test jobs will also help identify specific `requirements` for your jobs and 
identify bugs in scripts and workflows.

Some general tips for test jobs:

- Select smaller data sets or subsets of data for your first test jobs. Using 
smaller data will keep the resource needs of your jobs low which will help get 
test jobs to start, and complete, sooner.

- If possible, submit test jobs that will reproduce results you've gotten 
using another system, this makes for a good "sanity check" as you'll be able 
to compare the results of the test to those previously obtained.

- After initial tests complete successfully, scale up to larger or full-size 
data sets; if your data spans a range of sizes, submit tests using the smallest 
and largest data sizes to examine the range of resources that these jobs may need.

- Give your test jobs, and associated HTCondor `log`, `error`, `output`, 
and `submit` files meaningful names so you know which results refer to which tests.

# Optimize Job Resource Requests

In the HTCondor submit file, you must explicitly request the number of 
cpus (i.e. cores) and the amount of disk and memory that the job needs 
to complete successfully. When you submit a job for the 
first time you may not know just how much to request and that's OK. 
Below are some suggestions for making resource requests for initial test 
jobs. **As always, reviewing the HTCondor `log` file from past jobs is 
a great way to learn about the resource needs of your jobs.**

- Save the HTCondor `log` files from your jobs. HTCondor will report 
the memory, disk, and cpu usage of your jobs to this file.

- Start by requesting a single cpu. With single cpu jobs you will see 
your jobs start sooner. Ultimately you will be able to achieve 
greater throughtput with single cpus jobs compared to jobs that request 
and use multiple cpus. 
	- **Keep in mind, requesting more cpus for a job 
does not automatically mean that your jobs will use more cpus.**

	- There is limited support for multicore work in OSG. To 
learn more, see our guide on 
[Multicore Jobs](https://support.opensciencegrid.org/support/solutions/articles/5000653862)

- Before submitting a job always look at the size of your input 
files. At a minimum you need to request enough disk to support all 
of the input files your job will need, but don't forget about 
job output. Your submit file should also request enough disk to 
support the results that are produced by the job.
	- If many of your input and output files are compressed 
(i.e. zipped or tarballs) you will need to factor that into your 
estimates for disk usage as these files will be uncompressed during 
job execution.

	- For your initial tests it is OK to request more disk than 
your job may need so that the test completes successfully. **The key 
is to adjust disk requests for subsequent jobs based on the results 
of these test jobs.**

- Estimating memory usage can sometimes be tricky. If you've performed the 
same or similar work on another computer, consider using the amount of 
memory (i.e. RAM) from that computer as a starting point. For instance, 
most laptop computers these days will have 8 or 16 GB of memory.
	- For your initial tests it is OK to request more memory than 
your job may need so that the test completes successfully. **The key 
is to adjust memory requests for subsequent jobs based on the results 
of these test jobs.**

	- If you find that memory usage will vary greatly across a 
batch of jobs, we can assist you with creating dynamic memory requests 
in your submit files.

# Submit Multiple Jobs Using A Single Submit File

Once you have a single test job that compeltes successfully, the next 
step is to submit a small batch of test jobs (e.g. 5 or 10 jobs) 
[**using a single submit file**](https://support.opensciencegrid.org/support/solutions/articles/12000073165). Use this small-scale multi-job submission test to ensure that all jobs 
complete successfully, produce the desired output, and do not 
conflict with each other when submitted together. Once 
you are confident that the jobs will complete as desired, then scale up to submitting 
the entire set of jobs.

## Avoid Exceeding Disk Quotas

Each OSG Connect user is granted 100 GB of storage in their `/home` directory and 
500 GB of storage in their `/public` directory. This may seem like a lot, but 
when running 100's or 1000's of jobs even small output can add up quickly. If 
these quotas are exceeded, jobs will fail or go on hold when attempting returning output.

To prevent errors or workflow interruption, be sure to estimate the 
input and output needed for all of your concurrently running 
jobs. By default, after your job terminates HTCondor will transfer back 
any new or modified files from the top-level directory where the job ran, 
back to your `/home` directory. Efficiently manage output by including steps 
to remove intermediate and/or unnecessary files as part of your job. 

# Workflow Management

To help manage complicated workflows, consider a workflow manager such 
as [Pegasus](https://support.opensciencegrid.org/support/solutions/articles/5000639789-pegasus) 
or HTCondor [DAGman](https://research.cs.wisc.edu/htcondor/dagman/dagman.html).

# Get Help

For assistance or questions, please email the OSG User Support team  at [support@osgconnect.net](mailto:support@osgconnect.net) or visit the [help desk and community forums](http://support.opensciencegrid.org).
