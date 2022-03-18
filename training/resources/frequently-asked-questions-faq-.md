[title]: - "Frequently Asked Questions"
[TOC]

## Getting Started
   
**Who is eligible to become the user of OSG Connect?**

Any researcher affiliated with a U.S. institution (college, university, national laboratory or research foundation) is eligible to become an OSG Connect user. Researchers outside of the U.S. with affiliations to U.S. groups may be eligible for membership if they are sponsored by a collaborator within the U.S. Researchers outside of the U.S. are asked to first
[contact us](mailto:support@opensciencegrid.org) directly to discuss membership.

**How do I become an user of OSG Connect?**

Please follow the steps outlined in the [Sign Up process](http://osgconnect.net/signup). 

## Software
   
**What software packages are available?**

In general, we support most software that fit the distributed high throughput computing model. Users are encouraged to download and install their own software. For some software, we support distributed software modules listed [here](https://support.opensciencegrid.org/support/solutions/articles/12000048518). Software can be added to the modules upon request. 
 
Additionally, users may install their software into a Docker container which can run on OSG as a Singularity image.  See [this guide](https://support.opensciencegrid.org/support/solutions/articles/12000024676-docker-and-singularity-containers) for more information. 

**How do I access a specific software application?**

We have implemented modules within OSG Connect to manage the software that is available to users. Modules allow for easy access to a number of software and version options. Our [Accessing Software using Distributed Environment Modules](https://support.opensciencegrid.org/support/solutions/articles/12000048518) page provides more details on how to use modules in OSG Connect.
 
**Are there any restrictions on installing commercial softwares?**

We can only *directly* support software that is freely distributable. At present, we do not have or support most commercial software due to licensing issues. (One exception is running [MATLAB standalone executables](https://support.opensciencegrid.org/support/solutions/articles/5000660751-basics-of-compiled-matlab-applications-hello-world-example) which have been compiled with the MATLAB Compiler Runtime).  Software that is licensed to individual users (and not to be shared between users) can be staged within the user's /home directory with HTCondor transferring to jobs, but should not be staged in OSG's public data staging locations (see https://support.opensciencegrid.org/support/solutions/articles/12000002985-data-management-and-policies). Please get in touch with any questions about licensed software.
   
## Running Jobs
   
**What type of computation is a good match or NOT a good match for OSG Connect?**

OSG Connect is a high throughput computing system. You can get the most of out OSG Connect resources by breaking up a 
single large computational task into many smaller tasks for the fastest overall turnaround. This approach can be 
invaluable in accelerating your computational work and thus your research. Please see our ["Is OSG for You?"](https://support.opensciencegrid.org/support/solutions/articles/5000632058) page for more details on how to determine if your work matches up well with OSG Connect's model.

**What job scheduler is being used on OSG Connect?**

We use use the task scheduling software called HTCondor to schedule and run jobs.
 
**How do I submit a computing job?**

Jobs are submitted via HTCondor scheduler. Please see our [QuickStart](http://support.opensciencegrid.org/support/solutions/articles/5000633410) guide for more details on submitting and managing jobs.

**How many jobs can I have in the queue?**

The number of jobs that are submitted to the queue by any one user should not exceed 10,000. If you have more jobs than that, we ask that you include the following statement in your submit file: 

`max_idle = 2000`  

This is the maximum number of jobs that you will have in the "Idle" or "Held" state for the submitted batch of jobs at any given time.  Using a value of 2000 will ensure that your jobs continue to apply a constant pressure on the queue, but will not fill up the queue unnecessarily (which helps the scheduler to perform optimally).  

**How do I solve a "disk quota exceeded" error?**

If your jobs are returning errors about exceeding disk quota, there may be two different 
problem: 

1. Check that you are requesting enough disk space for your job execution. You can find 
this information in the job log file, near the end: 
		Partitionable Resources :    Usage  Request Allocated 
		   Disk (KB)            :      125     1000     53813 
You'll want to confirm that the number in the "Request" column is larger than the 
number in the "Usage" column. 

1. If you ARE requesting enough disk space, your job may be trying to use disk space 
outside of the main working directory. This most often happens if software expects to use 
the temporary directory `/tmp` for intermediate files. These files should be contained 
in the job's working directory instead; to make this happen, the `TMPDIR` environment 
variable needs to be set to the working directory. In a shell script, this looks like this: 
		export TMPDI=$_CONDOR_SCRATCH_DIR
If you have questions about how to translate this into a different script format, 
let us know. 

## Data Storage and Transfer
   
**What is the best way to process large volume of data?**

Use the Stash data system to stage large volumes of data. Please refer the section [Data Solutions](http://support.opensciencegrid.org/support/solutions/folders/5000262152) for more details. 
 
**How do I transfer my data to and from OSG Connect?**

You can transfer data using scp or rsync. See [Using scp To Transfer Files To OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000634376) for more details.

**How public is /public?**

The data under your `/public` location is discoverable and readable by anyone in the world. Data in `/public` is made public over http/https (via `https://stash.osgconnect.net/public/`) and mirrored to `/cvmfs/stash.osgstorage.org/osgconnect/public/` (for use with `stashcp`) which is mounted on a large number of systems around the world.

**Is there any support for private data?**

>**OSG currently has no storage appropriate for HIPAA data.**

If you do not want your data to be downloadable by anyone, and it’s small enough for HTCondor file transfer (i.e. <100MB per file and <500MB total per job), then it should be staged in your `/home` directory and transferred to jobs with HTCondor file transfer (`transfer_input_files`, in the submit file). If your data must remain private and is too large for HTCondor file transfer, then it’s not a good fit for the “open” environment of the Open Science Pool, and another resource will likely be more appropriate. As a reminder, if the data is not being used for active computing work on OSG Connect, it should not be stored on OSG Connect systems. Lastly, our data storage locations are not backed up nor are they intended for long-term storage.

**Can I get a quota increase?**

[Contact us](mailto:support@opensciencegrid.org) if you think you'll need a quota increase for `/home` or `/public` to accommodate a set of concurrently-running jobs. We can suppport very large amounts of data, the default quotas are just a starting point.

**Will I get notified about hitting quota limits?**

The only place you can currently see your quota status is in the login messages.
    
## Workflow Management

**How do I run and manage complex workflows?**

For workflows that have multiple steps and/or multiple files to, we advise using a workflow management system. A workflow management system allows you to define different computational steps in your workflow and indicate how inputs and outputs should be transferred between these steps. Once you define a workflow, the workflow management system will then run your workflow, automatically retrying failed jobs and transferrring files between different steps.

**What workflow management systems are recommended on OSG?**

We support and distribute DAGMan, Pegasus, and Swift for workflow management.

## Workshops and Training
   
**Do you plan to offer training sessions and workshop?**

We plan to offer workshops for the researchers on multiple locations, including an annual, week-long summer school for OSG users. Please check our [events page](https://support.opensciencegrid.org/support/solutions/5000161177) for further information about workshop dates and locations. 
 
**Who may attend OSG workshops?**

Workshops are typically open to students, post docs, staff and faculty.
 
**What are the topics covered in a typical workshop?**

We typically cover shell scripting, python (or R) programming, version control with git and distributed high throughout computing.  

**How to cite or acknowledge OSG?**

Whenever you make use of OSG resources, services or tools, we would be grateful to have you acknowledge OSG in your presentations and publications. 

For example, you can add the following in your acknowledgements section:
 
> "This research was done using resources provided by the OSG, which is supported by the National Science Foundation and the U.S. Department of Energy's Office of Science." 

We recommend the following references for citations

> 1) Pordes, R. et al. (2007). "The Open Science Grid", J. Phys. Conf. Ser. 78, 012057.doi:10.1088/1742-6596/78/1/012057.

> 2) Sfiligoi, I., Bradley, D. C., Holzman, B., Mhashilkar, P., Padhi, S. and Wurthwein, F. (2009). "The Pilot Way to Grid Resources Using glideinWMS", 2009 WRI World Congress on Computer Science and Information Engineering, Vol. 2, pp. 428–432. doi:10.1109/CSIE.2009.950.
 

 
