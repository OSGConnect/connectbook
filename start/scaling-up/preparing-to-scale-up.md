[title]: - "Determining the Amount of Resources to Request in a Submit File"

# Learning Objectives
This guide discuses the following: 
- Best practices for testing jobs and scaling up your analysis. 
- How to determine the amount of resources (CPU, memory, disk space) to request in a submit file.

[TOC]

# Overview

Much of HTCondor's power comes from the ability to run a large number 
of jobs simultaneously. To optimize your work with a high-throughput computing (HTC)
approach, you will need to test and optimize the resource requests of those jobs to 
only request the amount of memory, disk, and cpus truly needed.
This is an important practice that will maximize your throughput by optimizing the 
number of potential 'slots' in the OSPool that your jobs can match to, reducing the overall 
turnaround time for completing a whole batch.

If you have questions 
or are unsure if and how your work can be broken up, please contact us at 
[support@opensciencegrid.org](mailto:support@opensciencegrid.org)

This guide will describe best practices and general tips for testing 
your job resource requests **before** scaling up to submit your full set of jobs. 
Additional information is also available from the following "Introduction to High Throughput Computing with HTCondor" 2020 OSG Virtual 
Pilot School lecture video:

<a href="https://youtu.be/oMAvxsFJaw4">
    <img alt="2020 VSP dHTC with HTCondor" src="https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/2020-vsp-intro-dHTC-HTcondor-thumbnail.png" width="360" height="204"></a>

# Always Start With Test Jobs

Submitting test jobs is an important first step for optimizing 
the resource requests of your jobs. We always recommend submitting a few (3-10)
test jobs first before scaling up, whether this is your first time 
using OSG or you're an experienced user starting a new workflow. If you plan to submit
thousands of jobs, you may even want to run an intermediate test of 100-1,000 jobs to catch any 
failures or holds that mean your jobs have additional `requirements` they need to specify 
(and which OSG staff can help you to identify, based upon your tests).

Some general tips for test jobs:

- Select smaller data sets or subsets of data for your first test jobs. Using 
smaller data will keep the resource needs of your jobs low which will help get 
test jobs to start and complete sooner, when you're just making sure that your submit file 
and other logistical aspects of jobs submission are as you want them.

- If possible, submit test jobs that will reproduce results you've gotten 
using another system. This approach can be used as a good "sanity check" as you'll be able 
to compare the results of the test to those previously obtained.

- After initial tests complete successfully, scale up to larger or full-size 
data sets; if your jobs span a range of input file sizes, submit tests using the smallest 
and largest inputs to examine the range of resources that these jobs may need.

- Give your test jobs and associated HTCondor `log`, `error`, `output`, 
and `submit` files meaningful names so you know which results refer to which tests.

# Requesting CPUs, Memory, and Disk Space in the HTCondor Submit File 

In the HTCondor submit file, you must explicitly request the number of 
CPUs (i.e. cores), and the amount of disk and memory that the job needs 
to complete successfully, and you may need to identify a [JobDurationCategory](12000083468). 
When you submit a job for the 
first time, you may not know just how much to request and that's OK. 
Below are some suggestions for making resource requests for initial test 
jobs. 

- For **requesting CPU cores** start by requesting a single cpu. With single-cpu jobs, you will see 
your jobs start sooner. Ultimately you will be able to achieve 
greater throughput with single cpus jobs compared to jobs that request 
and use multiple cpus. 

    - **Keep in mind, requesting more CPU cores for a job 
    does not mean that your jobs will use more cpus.** Rather, you want to make sure 
    that your CPU request matches the number of cores (i.e. 'threads' or 'processes') 
    that you expect your software to use. (Most softwares only use 1 CPU core, by default.)

    - There is limited support for multicore work in OSG. To learn more, 
    see our guide on 
    [Multicore Jobs](https://support.opensciencegrid.org/support/solutions/articles/5000653862)
    
    - Depending on how long you expect your test jobs to take on a single core, you may need to identify a
    non-default [JobDurationCategory](12000083468), or consider implementing self-checkpointing (email us!).

- To inform initial **disk requests** always look at the size of your input 
files. At a minimum, you need to request enough disk to support all 
of the input files, executable, and the output you expect, but don't forget that the standard 'error' and 'output'
files you specify will capture 'terminal' output that may add up, too.
      
    - If many of your input and output files are compressed 
(i.e. zipped or tarballs) you will need to factor that into your 
estimates for disk usage as these files will take up additional space once uncompressed 
in the job.
      
    - For your initial tests it is OK to request more disk than 
your job may need so that the test completes successfully. **The key 
is to adjust disk requests for subsequent jobs based on the results 
of these test jobs.**
 
- Estimating **memory requests** can sometimes be tricky. If you've performed the 
same or similar work on another computer, consider using the amount of 
memory (i.e. RAM) from that computer as a starting point. For instance, 
most laptop computers these days will have 8 or 16 GB of memory, which is okay to start 
with if you know a single job will succeed on your laptop.

    - For your initial tests it is OK to request more memory than 
your job may need so that the test completes successfully. **The key 
is to adjust memory requests for subsequent jobs based on the results 
of these test jobs.**

    - If you find that memory usage will vary greatly across a 
batch of jobs, we can assist you with creating dynamic memory requests 
in your submit files.

# Optimize Job Resource Requests For Subsequent Jobs

**As always, reviewing the HTCondor `log` file from past jobs is 
a great way to learn about the resource needs of your jobs.** Optimizing the resources requested for each job may help your job run faster and achieve more throughput. 

Save the HTCondor `log` files from your jobs. HTCondor will report 
the memory, disk, and cpu usage of your jobs at the end of this file. The amount of each resource requested in the submit file is listed under the "Request" column and information about the amount of each resource actually utilized to complete the job is provided in the "Usage" column. 

For example:

```
        Partitionable Resources :    Usage  Request Allocated
           Cpus                 :                 1         1
           Disk (KB)            :       12  1000000  26703078
           Memory (MB)          :        0     1000      1000
```


-  One quick option to query your `log` files is to use the Unix tool `grep`. For example:
    ```
    [user@login]$ grep "Disk (KB)" my-job.log
    ```
    The above will return all lines in `my-job.log` that report the disk 
    usage, request, and allocation of all jobs reported in that log file.

    Alternatively, `condor_history` can be used to query details from 
    recently completed job submissions. HTCondor's history is continuously updating with information from new jobs, so `condor_history` is best performed shortly after the jobs of interest enter/leave the queue. 

# Submit Multiple Jobs Using A Single Submit File

Once you have a single test job that completes successfully, the next 
step is to submit a small batch of test jobs (e.g. 5 or 10 jobs) 
[**using a single submit file**](https://support.opensciencegrid.org/support/solutions/articles/12000073165). Use this small-scale 
multi-job submission test to ensure that all jobs complete successfully, produce the 
desired output, and do not conflict with each other when submitted together. Once 
you are confident that the jobs will complete as desired, then scale up to submitting 
the entire set of jobs.

# Monitoring Job Status and Obtaining Run Information

Gathering information about how, what, and where a job ran can be important for both troubleshooting and optimizing a workflow. The following commands are a great way to learn more about your jobs: 

| Command      | Description |
| ----------- | ----------- |
| `condor_q`      | Shows the queue information for your jobs. Includes information such as batch name and total jobs. |
| `condor_q <JobID> -l` | Prints all information related to a job including attributes and run information about a job in the queue. Output includes `JobDurationCategory`, `ServerTime`, `SubmitFile`, etc. Also works with `condor_history`. |
| `condor_q <JobID> -af <AttributeName1> <AttributeName2>` | Prints information about an attribute or list of attributes for a single job using the autoformat `-af` flag. The list of possible attributes can be found using `condor_q <JobID> -l`. Also works with `condor_history`.  |
| `condor_q -constraint '<Attribute> == "<value>"' `  | The `-constraint` flag allows users to find all jobs with a certain value for a given parameter. This flag supports searching by more than one parameter and different operators (e.g. `=!=`). Also works with `condor_history`.  |
| `condor_q -better-analyze <JobID> -pool <PoolName>` | Shows a list of the number of slots matching a job's requirements. For more information, see [Troubleshooting Job Errors](https://support.opensciencegrid.org/support/solutions/articles/5000639785-troubleshooting-job-errors). |


Additional `condor_q` flags involved in optimizing and troubleshooting jobs include:

| Flag      | Description |
| ----------- | ----------- |
| -nobatch | Combined with `condor_q`, this flag will list jobs individually and not by batch. |
| -hold | Show only jobs in the "on hold" state and the reason for that. An action from the user is expected to solve the problem. |
| -run | Show your running jobs and related info, like how much time they have been running, where they are running, etc. |
| -dag |  Organize `condor_q` output by DAG. |

More information about the commands and flags above can be found in the [HTCondor manual](https://htcondor.readthedocs.io/en/latest/). 

## Avoid Exceeding Disk Quotas in /home and /public

Each OSG Connect user is granted 50 GB of storage in their `/home` directory and 

500 GB of storage in their `/public` directory. This may seem like a lot, but 
when running 100's or 1,000's of jobs, even small output can add up quickly. If 
these quotas are exceeded, jobs will fail or go on hold when attempting returning output.

To prevent errors or workflow interruption, be sure to estimate the 
input and output needed for all of your concurrently running 
jobs. By default, after your job terminates HTCondor will transfer back 
any new or modified files from the top-level directory where the job ran, 
back to your `/home` directory. Efficiently manage output by including steps 
to remove intermediate and/or unnecessary files as part of your job. 

# Workflow Management

To help manage complicated workflows, consider a workflow manager such 
as HTCondor's built-in [DAGman](https://research.cs.wisc.edu/htcondor/dagman/dagman.html)
or the HTCondor-compatible [Pegasus](https://support.opensciencegrid.org/support/solutions/articles/5000639789-pegasus) 
workflow tool.

# Get Help

For assistance or questions, please email the OSG Research Facilitation team  at [support@opensciencegrid.org](mailto:support@opensciencegrid.org).
