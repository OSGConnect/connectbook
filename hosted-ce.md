[title]: - "OSG Managed Services"

**Special instructions** for the PEARC17 conference are here: https://swc-osg-workshop.github.io/OSG-HostedCE-PEARC17/

## Overview

Enabling campus researchers to share computational and data resources
with external collaborators is a powerful multiplier in advancing
science. Sharing spare capacity for even short durations allows an
institutional HPC resource a cost-efficient means of participating
in a larger cyber ecosystem. In this document we will show you how to
integrate your HPC cluster resource to the Open Science Grid to support
collaborative, multi-institutional science. The only requirements are
that your cluster can provide SSH access to a single OSG staff member,
that your cluster job submission and worker nodes have outbound IP
connectivity, the operating system is CentOS/RHEL 6.x, 7.x or similar,
and that a common batch scheduler is used (e.g. SLURM, PBS, HTCondor).

## How the Service Works

OSG offers a *managed service option* to connect a campus HPC/HTC cluster to the Open Science Grid. The OSG team will host and operate an HTCondor compute element which routes user jobs to your cluster, configured for science communities that you choose to support. 

![fig bosco](https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/screenshot_2983.png)


## Requirements

Here are the basic system requirements:

* Cluster operating system must be RHEL 6.x, 7.x or CentOS 6.x, 7.x or Scientific Linux 6.x, 7.x 
* A standard Unix account on your system's login server. The OSG service will use this account and submit to your batch queue in a manner you define.
* SSH access to this account via public SSH keys.
* A supported batch system (Slurm, HTCondor, PBS, LSF, SGE)
* Outbound network connectivity from the compute nodes (can be behind NAT)

## Setup Process

Setup and installation process consists of the following steps:

<ul>
<li>Fill out <a href="http://goo.gl/forms/8OukxsyG6KBSGHuR2">this questionnaire</a>
so that we have basic cluster details.</li> 
<li> Consultation call to discuss how you'll like to contribute to OSG. E.g.
number of OSG jobs that should run, resource limits, etc.</li>
<li> Create Unix login account for the OSG service</li>
<li> Install public SSH keys for the service</li>
<li> We configure the OSG service with your system details</li>
<li> We validate operation with a set of test jobs</li>
<li> We configure central OSG services to schedule jobs for science communities you support</li>
<li> (Optional): we can assist you in installing and setting up the Squid and
     OASIS software on your cluster to support application software repositories</li>
</ul>

## Security

OSG takes multiple precautions to maintain security and prevent unauthorized
usage of resources:

* Access to the OSG system with ssh keys are restricted to the OSG staff maintaining them 
* Users are carefully vetted before they are allowed to submit jobs to OSG 
* Jobs running through OSG can be traced back to the user that submitted them
* Job submission can quickly be disabled if needed
* OSG staff are readily contactable through several means in case of an emergency through [email](mailto:goc@opensciencegrid.org), [the help desk](http://ticket.grid.iu.edu), or phone (317-278-9699)


## Which Science Communities and Institutions am I supporting?

The OSG provides monitoring to view which communities are accessing your site, their fields of science, home institution. Below is an example of the monitoring views that will be available for your cluster. 

![fig gracc](https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/screenshot_2979.png)

<br/>
## **Optional**: Providing Access to Application Software Using OASIS

Many OSG communities use software modules provided by their collaborations or by
the OSG User Support team. You do not need to install any application software
on your cluster. OSG uses a FUSE-based distributed software repository system
called OASIS. To support these communities, the following additional components
are needed: 
       
* A (cluster-wide) Squid service with a minimum 50GB of cache space.
* Local scratch area on compute nodes: typical recommendations are 10 GB per job
* On each compute node, installation of the OASIS software package and associated FUSE kernel modules
* Local scratch space of at least 10 GB (preferably 22GB) on compute nodes for caching OASIS data.

### Install the OSG Packaged Frontier Squid Service

OSG has a yum repository with rpms of the OSG Frontier Squid service.  The rpms
include configuration files that allow Squid to access certified OSG software 
repositories.  Instructions on setting up Frontier Squid are available 
[here](https://twiki.grid.iu.edu/bin/view/Documentation/Release3/InstallFrontierSquid).

### Install the OSG OASIS Software on Your Cluster Compute Servers

OSG also provides rpms for the OASIS software in it's yum repositories.
Instructions on installing and making OASIS based software available on your
compute nodes are available
[here](https://twiki.grid.iu.edu/bin/view/Documentation/Release3/InstallCvmfs).

<br/>
## Getting Started

Drop us a note at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) if this is of interest to you. We will contact you to setup a consultation.  
