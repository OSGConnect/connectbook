Using Software on the Open Science Pool 
====================================



# Overview of Software Options

There are several options available for managing the software needs of your work within the Open Science Pool (OSPool). 
In general, the OSPool can support most popular, open source software that fit the distributed 
high throughput computing model. At present, we do not have or support most commercial software 
due to licensing issues. 

Here we review options, and provide links to additonal information, for using software 
installed by users, software available as precompiled binaries or via containers, and 
preinstalled software via modules.

## Install Your Own Software

For most cases, it will be advantageous for you to install the software needed for your jobs. 
This not only gives you the greatest control over your computing environment, but will also
make your jobs more distributable, allowing you to run jobs at more locations.

Installing your own software can be performed interactively on your assigned login server. More 
information about how to install your own software from source code can be found at 
[Compiling Software for the OSPool](https://support.opensciencegrid.org/support/solutions/articles/5000652099). 
When installing software on an OSG Connect login node, your software will be specifically compiled against 
the Red Hat Enterprise Linux (RHEL) 7 OS used on these nodes. In most cases, subsequent 
jobs that use this software will also need to run on a RHEL 7 OS, which can be specified by the 
`requirements` attribute of your HTCondor submit files - an example is provided in the software 
compilation guide linked above. Be sure to also review our 
[Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) 
guide to determine the appropriate method for transferring software with your jobs.

## Use Precompiled Binaries and Prebuilt Executables

Some software may be available as a precompiled binary or prebuilt executable 
which provides a quick and easy way to run a program without the need for installation 
from source code. Binaries and executables are software files that are ready to 
run as is, however binaries should always be tested beforehand. There are several 
important considerations for using precompiled binaries on the OSPool: 
1.) only binary files compiled against a Linux operating system are suitable 
for use on the OSPool, 2.) some softwares have system and hardware dependencies that must 
be met in order to run properly, and 3.) the available binaries may not have been 
compiled with the feaures or configuration needed for your work.

## Use Docker and Singularity Containers

Container systems provide users with customizable and reproducable computing and software 
environments. The Open Science Pool is compatible with both Singularity and Docker containers - the 
latter will be converted to a Singularity image and added to the OSG container image 
repository. Users can choose from a set of pre-defined containers already available within OSG, 
or can use published or custom made containers. More details on how to use containers on the OSPool can be found in our 
[Docker and Singularity Containers](https://support.opensciencegrid.org/support/solutions/articles/12000024676) guide. 

## Access Software In Distributed Modules 

Currently, the OSPool provides over 200 preinstalled software, libraries, and 
compiliers via distributed environment modules. Modules provide a streamlined option 
for working with different software versions as well as managing library dependencies for 
software. To run jobs that use modules, your HTCondor submit files must include additional 
`requirements` to direct your jobs to appropriate compute nodes within OSG.

More details about using modules can be found 
[here](https://support.opensciencegrid.org/support/solutions/articles/12000048518). 

## Ask for Helpk

If you are not sure which of the above options might be best for your software, we're happy to help! Just contact us at 
[support@opensciencegrid.org](mailto:support@opensciencegrid.org).

**Watch this video from the 2021 OSG Virtual School** for more information about using software on OSG:

[<img src="https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/Software_Video_Thumbnail.png" width="500">](https://www.youtube.com/embed/xUeIQbVXOMQ)

