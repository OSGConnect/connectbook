[title]: - "OSG Managed Services"

[TOC] 


## How the Service Works

OSG offers a *managed service option* to connect a campus HPC/HTC cluster to the Open Science Grid. The OSG team will host and operate an HTCondor compute element which routes user jobs to your cluster, configured for science communities that you choose to support. 


## Requirements

Here are the basic system requirements:

* Cluster operating system must be CentOS 6.x, 7.x or Scientific Linux 6.x, 7.x 
* A standard Unix account on your system's login server. The OSG service will use this account and submit to your batch queue in a manner you define.
* SSH access to this account via public SSH keys.
* A local scratch area on compute nodes: typical recommendations are 20 GB per job
* A supported batch system (Slurm, HTCondor, PBS, LSF, SGE)

Many OSG communities use software modules provided by their collaborations or by the OSG User Support team. You do not need to install any application software on your cluster. OSG uses a FUSE-based distributed software repository system called OASIS. To support these communities, the following additional components are needed: 
       
* A (cluster-wide) Squid service with a minimum 50GB of cache space.
* On each compute node, installation of the OASIS software package and associated FUSE kernel modules
* Local scratch space of 5 GB.

## Setup Process

Setup and installation process consists of the following steps:
  
* After a phone or email discussion, provide us with an account with access to your cluster 
* We will setup and configure OSG components on our system to use that account to submit jobs to your cluster
* We'll assist you in installing and setting up squid and networked access to OSG software for OSG jobs  (if you are fully supporting OSG jobs)
* There will probably be some further conversations to fine tune settings but they should be minimal.## Requirements


## Which Science Communities and Institutions am I supporting?

The OSG provides monitoring to view which communities are accessing your site, their fields of science, home institu

## Getting Started

Drop us a note at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) if this is of interest to you. We will contact you to setup a consultation.  

[atlas]: http://connect.usatlas.org

