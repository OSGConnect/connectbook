[title]: - "OSG Hosted CE"

[TOC] 

By using a hosted CE, you can quickly connect your cluster with minimal
requirements to run jobs from OSG:

        1. A normal account for OSG jobs to run.
        2. Provide ssh access to this account via public ssh keys.
        3. Provide a local scratch area on compute nodes for jobs to use.
        4. Use a support batch system (SGE, PBS, HTCondor, Slurm)

To fully support OSG jobs there are a few more requirements: 
       
        1. Provide a squid service with about 50GB of disk storage.
        2. Install rpms for a service that provides networked access to OSG software.

Setup for either option consists of the following sequence:
  
        1. After a phone or email discussion, you provide us with an account with access to your cluster 
        2. We will setup and configure OSG components on our system to use that account to submit jobs to your cluster
If you are supporting all OSG jobs:
        3. We'll assist you in installing and setting up squid and networked access to OSG software for OSG jobs 

Drop us a note at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) if this is of interest to you.

[atlas]: http://connect.usatlas.org

