[title]: - "Frequently Asked Questions"
[TOC]

## Getting Started
   
**Who is eligible to become a user of the OSG Connect service?**

Any researcher affiliated with a research project associated with a United states institution (college, university, national laboratory, or non-profit organizations) is an OSG Connect user. Researchers affiliated outside of the U.S. who are collaborating on such a U.S.-based project may be sponsored by someone responsible for the project. Researchers outside of the U.S. are asked to first [contact us](mailto:support@osg-htc.org) directly to discuss membership.

**How do I become an user of OSG Connect?**

Please follow the steps outlined in the [Sign Up process](http://osgconnect.net/signup). 

## Software
   
**What software packages are available?**

In general, the OSPool and OSG Connect can support nearly any software that fit the distributed high throughput computing model. Users are encouraged to download and install their own software, or to use containers, and our RCFs are happy to help users decide and implement these solutions! 
 
Users may use or create Docker and Singularity containers, which is most useful for open-source software with complex dependencies.  See [this guide](https://support.opensciencegrid.org/support/solutions/articles/12000024676-docker-and-singularity-containers) for more information. 

**How do I access a specific software application?**

We have implemented modules within OSG Connect to manage the software that is available to users. Modules allow for easy access to a number of software and version options. Our [Accessing Software using Distributed Environment Modules](https://support.opensciencegrid.org/support/solutions/articles/12000048518) page provides more details on how to use modules in OSG Connect.
 
**Are there any restrictions on installing commercial softwares?**

We can only *directly* support software that is freely distributable. At present, we do not have or support most commercial software due to licensing issues. (One exception is running [MATLAB standalone executables](https://support.opensciencegrid.org/support/solutions/articles/5000660751-basics-of-compiled-matlab-applications-hello-world-example) which have been compiled with the MATLAB Compiler Runtime).  Software that is licensed to individual users (and not to be shared between users) can be staged within the user's /home directory with HTCondor transferring to jobs, but should not be staged in OSG's public data staging locations (see https://support.opensciencegrid.org/support/solutions/articles/12000002985-data-management-and-policies). Please get in touch with any questions about licensed software.

   
## Running Jobs
   
**What type of computation is a good match or NOT a good match for OSG Connect?**

OSG Connect is a high throughput computing system. You can get the most of out OSG Connect resources by breaking up a 
single large computational task into many smaller tasks for the fastest overall turnaround. This approach can be 
invaluable in accelerating your computational work and thus your research. Please see our ["Is OSG for You?"](https://support.opensciencegrid.org/support/solutions/articles/5000632058) page for more details on how to determine if your work matches up well with OSG Connect's model.

**What job scheduler is used on OSG Connect?**

The OSG Connect login nodes provide software called HTCondor to schedule and run jobs, operating as HTCondor [access points](https://osg-htc.org/services/access-point.html).
 
**How do I submit a computing job?**

Jobs are submitted via the HTCondor scheduler. Please see our [QuickStart](http://support.opensciencegrid.org/support/solutions/articles/5000633410) guide and [New User Training](https://support.opensciencegrid.org/support/solutions/articles/12000084444) materials for more details on submitting and managing jobs, as well as other examples in our [documentation](https://support.opensciencegrid.org/support/home).

**How many jobs can I have in the queue?**

The number of jobs that are submitted to the queue by any one user should not exceed 10,000 (see [Policies](https://support.opensciencegrid.org/support/solutions/articles/12000074852-policies-for-using-osg-connect-and-the-ospool)). If you have successfullly tested a set of 1000 jobs and would like to submit more than 10,000 jobs with a single submit file (great!), just add the following to the submit file: 

`max_idle = 2000`  

This is the maximum number of jobs that you will have in the "Idle" or "Held" state for the submitted batch of jobs at any given time.  Using a value of 2000 will ensure that your jobs continue to apply a constant pressure on the queue, but will not fill up the queue unnecessarily (which helps the scheduler to perform optimally).  

## Data Storage and Transfer
   
**What is the best way to process a large volume of data?**

Use the OSG connect data origin (part of the [Open Science Data Federation](https://osg-htc.org/services/osdf.html)) to stage large volumes of data. Please refer to the [Data Solutions](https://support.opensciencegrid.org/support/solutions/folders/12000013267) documentation for more details. 
 
**How do I transfer my data to and from OSG Connect?**

You can transfer data using scp or rsync. See [Using scp To Transfer Files To OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000634376) for more details.

**How public is /public?**

The data under your `/public` location is discoverable and readable by anyone in the world. In addition to be available for transfer to jobs via a `stash:///` addres, data in `/public` is made public over http/https (via `https://stash.osgconnect.net/public/`) and mirrored to `/cvmfs/stash.osgstorage.org/osgconnect/public/`, which is mounted on a large number of systems around the world.

**Is there any support for private data?**

>**OSG currently has no storage appropriate for HIPAA data.**

If you do not want your data to be publicly downloadable, and it’s small enough for HTCondor file transfer (i.e. <100MB per file and <500MB total per job), then it should be staged in your `/home` directory and transferred to jobs with HTCondor file transfer (`transfer_input_files`, in the submit file). If your data must remain private and is too large for HTCondor file transfer, then it’s not a good fit for the “open” environment of the Open Science Pool, and another resource will likely be more appropriate. As a reminder, if the data is not being used for active computing work on OSG Connect, it should not be stored on OSG Connect systems. Our data storage locations are not backed up, nor are they intended for long-term storage.

**Can I get a quota increase?**

[Contact us](mailto:support@osg-htc.org) if you think you'll need a quota increase for `/home` or `/public` to accommodate a set of concurrently-running jobs. We can suppport very large amounts of data, the default quotas are just a starting point.

**Will I get notified about hitting quota limits?**

The only place you can currently see your quota status is in the login messages. Jobs that cannot complete output file transfer due to an exceeded quote will be placed on hold by HTCondor, and output lost.
    
## Workflow Management

**How do I run and manage complex workflows?**

For workflows that have multiple steps and/or multiple files to, we advise using a workflow management system. A workflow management system allows you to define different computational steps in your workflow and indicate how inputs and outputs should be transferred between these steps. Once you define a workflow, the workflow management system will then run your workflow, automatically retrying failed jobs and transferrring files between different steps.

**What workflow management systems are recommended on OSG?**

We support and distribute [DAGMan](https://support.opensciencegrid.org/support/solutions/articles/12000079038) (built into HTCondor) and other HTCondor-compatible workflows tools that do NOT require a shared filesystem, including [Pegasus](https://pegasus.isi.edu/) and [Swift](http://swift-lang.org/main/).

## Workshops and Training
   
**Do you offer training sessions and workshop?**

We off monthly New User Training and additional topics with registration details and materials listed [here](https://support.opensciencegrid.org/support/solutions/articles/12000084444). Also check out materials for the annual, week-long [OSG User School](https://support.opensciencegrid.org/support/solutions/articles/12000002319), the application period is announced every spring to registered users of OSG Connect and other OSPool access points.  

**How to cite or acknowledge OSG?**

See instructions listed on the OSG website: https://osg-htc.org/acknowledging
 

 
