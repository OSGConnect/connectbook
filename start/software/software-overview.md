[title]: - "How to use software in OSG Connect"

[TOC]

# Overview of software options in OSG Connect

There are several options available for managing the software needs of your work within OSG Connect. 
In general, OSG Connect can support most popular, open source software that fits the distributed high throughput model. At present, we do not have or support most commercial software due to licensing issues. 

Here we review options for using preinstalled software packages, via modules, support for software installed by users, and support for software via containers.

## Access Software In Distributed Modules 

Currently, OSG Connect provides over 200 preinstalled software and libraries via distributed environment 
modules. More details about which what software is available via modules and how to use modules in OSG 
Connect can be found [here](https://support.opensciencegrid.org/support/solutions/articles/12000048518). 

Modules provide a streamlined option for working with different software versions as well as managing 
library dependencies for software, but note that not all servers within OSG Connect will be able to access 
software modules and your submit files will need to include additional `requirements` to direct your jobs
to appropriate servers.

## Install Your Own Software

For some users it may be necessary or advantageuos to install their own software. This will be the case when
your software is not preinstalled and available as a module and/or when your work would benefit from 
additional throughput that cannot be acheived with modules alone. More information about how to install your own software can be found at [Compiling Application for OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000652099). Be sure to review our [Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) guide to determine the appropriate 
method for transferring your software with your jobs.

In general, we support most popular software that fits the distributed high thoroughput model and can add software upon request.
 
**How do I load a specific software application?**

Generally, you'll need to give the version of after the module name when loading the module.
For example, there are three different versions of Gromacs available (4.6.5, 5.0.0, and 5.0.5).  To load Gromacs 5.0.5, you would run:

    $ . /cvmfs/oasis.opensciencegrid.org/osg/sw/module-init.sh
    $ module load gromacs/5.0.5


See the section on [Accessing Software using Distributed Environment Modules](http://support.opensciencegrid.org/solution/categories/5000160799/folders/5000260921/articles/5000634394-accessing-software-using-distributed-environment-modules) for details.
 
**Are there any restrictions on installing commercial softwares?**

We only provide software that is freely distributable. At present, we do not have or support most commercial software due to licensing issues. 
 
**Can I request for system wide installation of  the open source software useful for my research?**

