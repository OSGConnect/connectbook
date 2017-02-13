[title]: - "OSG Managed Services"

## How the Service Works

OSG offers a *managed service option* to connect a campus HPC/HTC cluster to the Open Science Grid. The OSG team will host and operate an HTCondor compute element which routes user jobs to your cluster, configured for science communities that you choose to support. 

![fig bosco](https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/screenshot_2983.png)


## Requirements

Here are the basic system requirements:

* Cluster operating system must be RHEL 6.x, 7.x or CentOS 6.x, 7.x or Scientific Linux 6.x, 7.x 
* A standard Unix account on your system's login server. The OSG service will use this account and submit to your batch queue in a manner you define.
* SSH access to this account via public SSH keys.
* A supported batch system (Slurm, HTCondor, PBS, LSF, SGE)

## Setup Process

Setup and installation process consists of the following steps:
  
* Consultation call to collect system details.  We'll need the following information:
   <ul>
   <li>Cluster name</li>
   <li>Address for cluster</li>
   <li>Technical contact information for cluster</li>
   <li>Technical information on cluster (batch system, OS, location of scratch space, number of slots available for OSG)</li>
   </ul>
* Create Unix login account for the OSG service
* Install public SSH keys for the service
* We configure the OSG service with your system details
* We validate operation with a set of test jobs
* We configure central OSG services to schedule jobs for science communities you support
* (Optional): we can assist you in installing and setting up the Squid and OASIS software on your cluster 

## Which Science Communities and Institutions am I supporting?

The OSG provides monitoring to view which communities are accessing your site, their fields of science, home institution. Below is an example of the monitoring views that will be available for your cluster. 

![fig gracc](https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/screenshot_2979.png)


## Optional: Providing Access to Application Software Using OASIS

Many OSG communities use software modules provided by their collaborations or by
the OSG User Support team. You do not need to install any application software
on your cluster. OSG uses a FUSE-based distributed software repository system
called OASIS. To support these communities, the following additional components
are needed: 
       
* A (cluster-wide) Squid service with a minimum 50GB of cache space.
* Local scratch area on compute nodes: typical recommendations are 10 GB per job
* On each compute node, installation of the OASIS software package and associated FUSE kernel modules
* Local scratch space of at least 10 GB (preferably 22GB) on compute nodes for caching OASIS data.

<br/>
### Install the OSG Packaged Frontier Squid Service

OSG has a yum repository with rpms of the OSG Frontier Squid service.  The rpms
include configuration files that allow Squid to access certified OSG software 
repositories.  Instructions on setting up Frontier Squid are available 
[here](https://twiki.grid.iu.edu/bin/view/Documentation/Release3/InstallFrontierSquid).

<br/>
### Install the OSG OASIS Software on Your Cluster Compute Servers

OSG also provides rpms for the OASIS software in it's yum repositories.
Instructions on installing and making OASIS based software available on your
compute nodes are available
[here](https://twiki.grid.iu.edu/bin/view/Documentation/Release3/InstallCvmfs).

<br/>

## Getting Started

Drop us a note at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) if this is of interest to you. We will contact you to setup a consultation.  
