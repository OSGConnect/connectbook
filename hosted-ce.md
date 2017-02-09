[title]: - "OSG Hosted CE"

[TOC] 

By using a hosted CE, you can quickly allow OSG to run jobs on your cluster.
The minimal set of requirements to run jobs from OSG are:

* A normal account for OSG jobs to run.
* SSH access to this account via public ssh keys.
* A local scratch area on compute nodes for jobs to use.
* A supported batch system (SGE, PBS, HTCondor, Slurm)

To fully support OSG jobs a few more things are needed: 
       
* A squid service with about 50GB of cache space.
* RPMS installed for a service that provides networked access to OSG software.

Setup and installation process consists of the following steps:
  
* After a phone or email discussion, provide us with an account with access to your cluster 
* We will setup and configure OSG components on our system to use that account to submit jobs to your cluster
* We'll assist you in installing and setting up squid and networked access to OSG software for OSG jobs  (if you are fully supporting OSG jobs)
* There will probably be some further conversations to fine tune settings but they should be minimal.

Drop us a note at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) if this is of interest to you.

[atlas]: http://connect.usatlas.org

