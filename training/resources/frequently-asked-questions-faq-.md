[title]: - "Frequently Asked Questions"

## Getting Started
   
**Who is eligible to become the user of OSG Connect?**

Any researcher affiliated with a U.S. institution (college, university, national laboratory or research foundation) is eligible to become an OSG Connect user. Researchers outside of the U.S. with affiliations to U.S. groups may be eligible for membership if they are sponsored by a collaborator within the U.S. Researchers outside of the U.S. are asked to first
[contact us](mailto:support@osgconnect.net) directly to discuss membership.

**How do I become an user of OSG Connect?**

Please follow the steps outlined in the [Sign Up process](http://osgconnect.net/signup). 

## Software
   
**What software packages are available?**

The available software are listed [here](https://support.opensciencegrid.org/support/solutions/articles/12000048518). In general, we support most software that fits the distributed high thoroughput computing model. Additionally, we can add software upon request.
 
**How do I access a specific software application?**

We have implemented modules within OSG Connect to manage the software that is available to users. Modules allow for easy access to a number of software and version options. Our [Accessing Software using Distributed Environment Modules](https://support.opensciencegrid.org/support/solutions/articles/12000048518-accessing-software-using-distributed-environment-modules) page provides more details on how to use modules in OSG Connect.
 
**Are there any restrictions on installing commercial softwares?**

We only provide software that is freely distributable. At present, we do not have or support most commercial software due to licensing issues. 
 
**Can I request for system wide installation of the open source software useful for my research?**

Yes. Please contact <support@osgconnect.net>.  
   
## Running Jobs
   
**What type of computation is a good match or NOT a good match for OSG Connect?**

It is to carefully check the computational requirements of your workflow. Please see our ["Is the Open Science Grid for You?"](http://support.opensciencegrid.org/solution/categories/5000131843/folders/5000209523/articles/5000632058-is-high-throughput-computing-for-you-) page for more details on how to determine if your work matches up well with OSG Connect's model.

**What job scheduler is being used on OSG Connect?**

We use HTCondor to schedule and run jobs.
 
**How do I submit a computing job?**

Jobs are submitted via HTCondor scheduler. Please see our [QuickStart](http://support.opensciencegrid.org/support/solutions/articles/5000633410-osg-connect-quickstart) guide for more details on submitting and managing jobs.

**How many jobs can I have in the queue?**

The number of jobs that are submitted to the queue by any one user should not exceed 10,000. If you have more jobs than that, we ask that you include the following statement in your submit file: 
`maxidle 2000`  
   
## Data Storage and Transfer
   
**What is the best way to process large volume of data?**

Use the Stash data system to stage large volumes of data. Please refer the section [Data Solutions](http://support.opensciencegrid.org/support/solutions/folders/5000262152) for more details. 
 
**How do I transfer data from Stash to my system and vice versa?**

You can transfer data using scp or rsync. See the section on [Transferring Data to OSG Connect](http://support.opensciencegrid.org/support/solutions/folders/5000260918) for more details.

**How public is /public?**

The data under your `/public` location is discoverable and readable by anyone in the world. Data in `/public` is made public over http/https (via `https://stash.osgconnect.net/public/`) and mirrored to `/cvmfs/stash.osgstorage.org/osgconnect/public/` (for use with `stashcp`) which is mounted on a large number of systems around the world.

**Is there any support for private data?**

If you do not want your data to be downloadable by anyone, and it’s small enough for HTCondor file transfer (i.e. <100MB per file and <500MB total per job), then it should be staged in your `/home` directory and transferred to jobs with HTCondor file transfer (`transfer_input_files`, in the submit file). If your data must remain private and is too large for HTCondor file transfer, then it’s not a good fit for the “open” environment of the Open Science Grid, and another resource will likely be more appropriate. As a reminder, if the data is not being used for active computing work on OSG Connect, it should not be stored on OSG Connect systems. Lastly, our data storage locations are not backed up nor are they intended for long-term storage.

**Can I get a quota increase?**

[Contact us](mailto:support@osgconnect.net) if you think you'll need a quota increase for `/home` or `/public` to accommodate a set of concurrently-running jobs. We can suppport very large amounts of data, the default quotas are just a starting point.

**Will I get notified about hitting quota limits?**

The only place you can currently see your quota status is in the login messages.
    
## Workflow Management

**How do I run and manage complex workflows?**

For workflows that have multiple steps and/or multiple files to transfer, we advise using a workflow management system. A workflow management system allows you to define different computational steps in your workflow and indicate how inputs and outputs should be transferred between these steps. Once you define a workflow, the workflow management system will then run your workflow, automatically retrying failed jobs and transferrring files between different steps.

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

Whenever you make use of Open Science Grid resources, services or tools, we would be grateful to have you acknowledge OSG in your presentations and publications. 

For example, you can add the following in your acknowledgements section:
 
> "This research was done using resources provided by the Open Science Grid, which is supported by the National Science Foundation and the U.S. Department of Energy's Office of Science." 

We recommend the following references for citations

> 1) Pordes, R. et al. (2007). "The Open Science Grid", J. Phys. Conf. Ser. 78, 012057.doi:10.1088/1742-6596/78/1/012057.

> 2) Sfiligoi, I., Bradley, D. C., Holzman, B., Mhashilkar, P., Padhi, S. and Wurthwein, F. (2009). "The Pilot Way to Grid Resources Using glideinWMS", 2009 WRI World Congress on Computer Science and Information Engineering, Vol. 2, pp. 428–432. doi:10.1109/CSIE.2009.950.
 

 
