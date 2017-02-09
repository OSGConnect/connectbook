[title]: - "OSG Hosted CE"

[TOC] 

By using a hosted CE, you can quickly connect your cluster with minimal
requirements to run jobs from OSG:

* A normal account for OSG jobs to run.
* Provide ssh access to this account via public ssh keys.
* Provide a local scratch area on compute nodes for jobs to use.
* Use a support batch system (SGE, PBS, HTCondor, Slurm)

To fully support OSG jobs there are a few more requirements: 
       
* Provide a squid service with about 50GB of disk storage.
* Install rpms for a service that provides networked access to OSG software.

Setup for either option consists of the following sequence:
  
* After a phone or email discussion, you provide us with an account with access to your cluster 
* We will setup and configure OSG components on our system to use that account to submit jobs to your cluster
* We'll assist you in installing and setting up squid and networked access to OSG software for OSG jobs  (if you are fully supporting OSG jobs)
* There will probably be some further conversations to fine tune settings but they should be minimal.

Drop us a note at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) if this is of interest to you.

[atlas]: http://connect.usatlas.org

