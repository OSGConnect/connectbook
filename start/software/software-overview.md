[title]: - "Using Software In OSG Connect"

[TOC]

# Overview of Software Options In OSG Connect

There are several options available for managing the software needs of your work within OSG Connect. 
In general, OSG Connect can support most popular, open source software that fit the distributed 
high throughput computing model. At present, we do not have or support most commercial software 
due to licensing issues. 

Here we review options for using preinstalled software packages via modules, software available as 
precompiled binaries, software installed by users, and software available via containers.

## Access Software In Distributed Modules 

Currently, OSG Connect provides over 200 preinstalled software, libraries, and compiliers via 
distributed environment modules. Modules provide a streamlined option for working with different 
software versions as well as managing library dependencies for software. To run jobs that use modules, 
your HTCondor submit files must include additional `requirements` to direct your jobs
to appropriate compute nodes within OSG.

More details about using modules in OSG Connect can be found 
[here](https://support.opensciencegrid.org/support/solutions/articles/12000048518). 

## Use Precompiled Binaries and Prebuilt Executables

Some software may be available as a precompiled binary or prebuilt executable which provides a quick 
and easy way to run a program without the need for installation from source code. Binaries and executables 
are software files that are ready to run as is, however binaries should always be tested beforehand. 
There also are several important considerations for using precompiled binaries in OSG Connect: 1.) only binary 
files compiled against a Linux operating are suitable for use in OSG 2.) some softwares have system and 
hardware dependencies that must be met in order to run properly and 3.) the available binaries may not have been 
compiled with the feaures or configuration needed for your work.

## Install Your Own Software

For some users it may be necessary or advantageuos to install their own software. This will be the case when
your software is not available as a module or compatible precompiled binary, and/or when your work would benefit from 
additional throughput that cannot be acheived with modules alone. More information about how to install 
your own software from source code can be found at 
[Compiling Application for OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000652099). 
Be sure to review our 
[Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) 
guide to determine the appropriate method for transferring software with your jobs.

## Use Docker and Singularity Containers

Container systems allow users full control over their computing and software environment. OSG Connect is 
compatible with both Singularity and Docker containers - the latter will be converted to 
a Singularity image and added to the OSG Connect container image repository. Users can choose from a set of 
pre-defined containers already availble within OSG Connect or can use published or custom made 
containers. More details on how to use containers in OSG Connect can be found in our 
[Docker and Singularity Containers](https://support.opensciencegrid.org/support/solutions/articles/12000024676) guide. 

## Request Software For System-wide Installation via Modules

If your work would benefit from system-wide installation of open source software (made available via modules), 
please contact us at [support@opensciencegrid.org](mailto:support@opensciencegrid.org).
