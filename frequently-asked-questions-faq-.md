[title]: - "Frequent Asked Questions"

##Getting Started

**Who is eligible to become the user of OSG Connect?**

Any researcher with an affiliation with an U.S. institution (college, university, national laboratory or research foundation) is eligible to become an OSG Connect user.  Researchers outside US with affiliations to US groups may be eligible for membership.  However, these potential users should contact us directly to discuss membership.

**How do I become an user of OSG Connect?**

Please follow the steps outlined in the [Sign Up process](http://osgconnect.net/signup). 

##Software
**What software packages are available?**

The available software are listed [here](http://support.opensciencegrid.org/solution/categories/5000160799/folders/5000260921/articles/5000634397-software-modules-catalog). 
 
**How do I load a specific software application?**

For example, there are three different versions of Gromacs available (4.6.5, 5.0.0, and 5.0.5).  To load Gromacs 5.0.5:


    $ source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/bash
    $ module load gromacs/5.0.5


See the section ["Accessing Software using Distributed Environment Modules"](http://support.opensciencegrid.org/solution/categories/5000160799/folders/5000260921/articles/5000634394-accessing-software-using-distributed-environment-modules) for details.
 
**Are there any restrictions on installing commercial softwares?**

We only maintain software that is freely distributable. At present, we do not have or support most commercial software due to licensing . 
 
**Can I request for system wide installation of  the open source software useful for my research?**

Yes. Please contact <support@opensciencegrid.org>.

##Running Jobs
**What type of computation is a good match or NOT a good match on OSG Connect?**

It is important for the user to carefully check the computational requirements of his or her workflow. Please refer the section on ["Is high throughput computing for you?"](http://support.opensciencegrid.org/solution/categories/5000131843/folders/5000209523/articles/5000632058-is-high-throughput-computing-for-you-) for full detail.

**What job scheduler is being used on OSG Connect?**

HTCondor.
 
**How do I submit a computing job?**

Jobs are submitted via HTCondor scheduler. Please refer the "QuickStart" or User Guide for the detail.
 
**What type of computation is a good match or NOT a good match on OSG Connect?**

Please refer the section on "Best practices - Computation" for more details.

##Data Storage and Transfer
**What is the best way to process large volume of data?**

Use the "stash"  storage to  process large data. Please refer the section "Data Solutions" for more details. 
 
**How do I transfer data from stash to Midway and vice versa?**

You can transfer data using  - scp, rsync and globus. See the section on "Data Solutions" for more details.
Scientific Workflow Management (SWM)

**What is the use of scientific workflow management?**

Scientific workflow management systems help to deal with computations or data manipulations.

**What workflow management systems are recommended on OSG?**

We support and distribute DAGMan, Pegasus and Swift for workflow management.

##Workshops and Training
*Do you plan to offer training sessions and workshop?*

We plan to offer workshops for the researchers on multiple locations. Please check our events page for further information about the workshop dates and venue. 
 
**Who may attend the workshop?**

Workshops are typically open to students, post docs, staff and faculty.
 
**What are the topics covered in a typical workshops?**

We typically cover shell scripting, python (or R) programming, version control with git  and distributed high throughout computing.  

**How to cite or acknowledge OSG?**

Whenever you make use of Open Science Grid resources, services or tools, we would be grateful to have you acknowledge OSG in your presentations and publications. 
 For example, you can add in your acknowledgement section:
This research was done using resources provided by the Open Science Grid. 
We recommend the following references for citations

    1) Pordes, R. et al. (2007). "The Open Science Grid", J. Phys. Conf. Ser. 78, 012057.doi:10.1088/1742-6596/78/1/012057.
    2) Sfiligoi, I., Bradley, D. C., Holzman, B., Mhashilkar, P., Padhi, S. and Wurthwein, F. (2009). "The Pilot Way to Grid Resources Using glideinWMS", 2009 WRI World Congress on Computer Science and Information Engineering, Vol. 2, pp. 428–432. doi:10.1109/CSIE.2009.950.
 

 
