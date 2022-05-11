Running OSG jobs on XSEDE
=========================

## Overview
            
The [OSG](http://www.osg-htc.org/) promotes science by:

 * enabling a framework of distributed computing and storage resources

 * making available a set of services and methods that enable better access
   to ever increasing computing resources for researchers and communities

 * providing resource sharing principles and software that enable distributed
   High Throughput Computing (dHTC) for users and communities at all scales.
         
The OSG facilitates access to dHTC for scientific research
in the US. The resources accessible through the OSG are
contributed by the community, organized by the OSG, and
governed by the [OSG
Consortium](http://www.osg-htc.org); an overview is available at 
[An Introduction to OSG](http://osg-docdb.opensciencegrid.org/0008/000839/004/OSG%20Intro%2
0v23.pdf). In 2017, OSG is comprised
of about 126 institutions with ~120 active sites that collectively
support usage of ~4,000,000 core hours per day. Up-to-date usage metrics
are available at the [OSG Usage Display](https://display.opensciencegrid.org/).

Cores that are not being used at any point in time by
the owning communities are made available for shared use by other
researchers; this usage mode is called opportunistic access. OSG
supports XSEDE users by providing a Virtual Cluster that forms an
abstraction layer to access the opportunistic cores in the distributed
OSG infrastructure. This interface allows XSEDE users to view the OSG as
a single cluster to manage their jobs, provide the inputs and retrieve
the outputs. XSEDE users access the OSG via the OSG-XSEDE login host
that appears as a resource in the XSEDE infrastructure.

## Computation that is a good match for OSG

High throughput workflows with simple system and
data dependencies are a good fit for OSG. The
[Condor manual](http://research.cs.wisc.edu/condor/manual/current/) has an overview of [high throughput computing](http://research.cs.wisc.edu/condor/manual/current/1_Overview.html).

Jobs submitted into the OSG Virtual Cluster will be executed on machines
at several remote physical clusters. These machines may differ in terms
of computing environment from the submit node. Therefore it is important
that the jobs are as self-contained as possible by generic binaries
and data that can be either carried with the job, or staged on demand.
Please consider the following guidelines:


 * Software should preferably be **single threaded**, using
   **less than 2 GB memory** and each invocation should
   **run for 1-12 hours**. Please contact the support listed
   below for more information about these capabilities. System level check
   pointing, such as the HTCondor standard universe, is not available.
   Application level check pointing, for example applications writing out
   state and restart files, can be made to work on the system.
 
 * Compute sites in the OSG can be configured to use pre-emption, which 
   means jobs can be automatically killed if higher priority jobs enter
   the system. Pre-empted jobs will restart on another site, but it is
   important that the jobs can handle multiple restarts.
 
 * Binaries should preferably be statically linked. However, dynamically
   linked binaries with standard library dependencies, built for a 64-bit
   Red Hat Enterprise Linux (RHEL) 6 machines will also work. Also,
   interpreted languages such as Python or Perl will work as long as there
   are no special module requirements.
 
 * Input and output data for each job should be &lt; 10 GB to allow them
   to be pulled in by the jobs, processed and pushed back to the submit
   node. Note that the OSG Virtual Cluster does not currently have a global
   shared file system, so jobs with such dependencies will not work.
 
 * Software dependencies can be difficult to accommodate unless the software
   can be staged with the job.


The following are examples of computations that are **not** good
matches for OSG:

 * Tightly coupled computations, for example MPI based communication, will
  not work well on OSG due to the distributed nature of the infrastructure.
                
 * Computations requiring a shared file system will not work, as there is
   no shared filesystem between the different clusters on OSG.

 * Computations requiring complex software deployments are not a good fit.
   There is limited support for distributing software to the compute
   clusters, but for complex software, or licensed software, deployment
   can be a major task.


## System Configuration

The OSG Virtual Cluster is a Condor pool overlay on top of OSG
resources. The pool is dynamically sized based on the demand, the
number of jobs in the queue, and supply, resource availability at the
OSG resources. It is expected that the average number of resources,
on average, available to XSEDE users will be in the order of 1,000
cores.

One important difference between the OSG Virtual Cluster and most of
the other XSEDE resources is that the OSG Virtual Cluster does not have
a shared file system. This means that your jobs will have to bring
executables and input data. Condor can transfer the files for you,
but you will have to identify and list the files in your Condor job
description file.

Local storage space at the submission site is controlled by
quota. Your home directory has a quota of 10 GBs and your work directory
`/local-scratch/$USER` has a quota of 1 TB. There are no
global quotas on the remote compute nodes, but expect that about 10 GBs
are available as scratch space for each job.


## System Access

The preferred method to access the system is via the XSEDE Single
Sign On (SSO) Hub. Please see the [sso documentation](https://portal.xsede.org/single-sign-on-hub)
for details.

A secondary access methor is to use SSH public key authentication.
Secure shell users should feel free to append their public RSA key
to their `~/.ssh/authorized_keys` file to enable access
from their own computer. Please login once via the SSO Hub to install your
key. Please make sure that the permissions on the .ssh directory and
the authorized_keys file have appropiate permissions. For example

    $ chmod 755 ~/.ssh
    $ chmod 644 ~/.ssh/authorized_keys


## Application Development<

Most of the clusters in OSG are running Red Hat Enterprise Linux (RHEL)
6 or 7, or some derivative thereof, on an x86_64 architecture. For
your application to work well in this environment, it is recommend
that the application is compiled on a similar system, for example on
the OSG Virtual Cluster login system: `submit-1.osg.xsede.org
`. It is also recommended that the application be statically
linked, or alternatively dynamically linked against just a few standard
libraries. What libraries a binary depends on can be checked using the
Unix `ldd` command-line utility:

    $ ldd a.out
          a.out is a static executable
            

In the case of interpreted languages like Python and Perl, applications
have to either use only standard modules, or be able to ship the modules
with the jobs. Please note that different compute nodes might have
different versions of these tools installed.

A good solution to complex software stack is Singularity containers
which are described below.


## Running Your Application
            
The OSG Virtual Cluster is based on Condor and the
[Condor manual](http://research.cs.wisc.edu/condor/manual/current/)
provides a reference for command line tools. The commonly used tools
are:

 * `**condor_submit**` - Takes a Condor submit file and adds the job to the queue

 * `**condor_q**` - Lists the jobs in the queue. Can be invoked with your
   username to limit the list of jobs to your jobs: `condor_q $USER`

 * `**condor_status**` - Lists the available slots in the system.
   Note that this is a dynamic list and if there are no jobs in the system,
   `condor_status` may return an empty list

 * `**condor_rm**` - Remove a job from the queue. If you are running a DAG,
  please `condor_rm` the id of the DAG to remove the whole workflow.

### Submitting a Simple Job

Below is a basic job description for the Virtual Cluster.

    universe = vanilla
    
    # specifies the XSEDE project to charge the job usage to - this is a
    # required attribute for all jobs submitted on the OSG-XSEDE resource
    +ProjectName = "TG-NNNNNN"
    
    # requirements is an expression to specify machines that can run jobs
    requirements = OSGVO_OS_STRING == "RHEL 6" && Arch == "X86_64" && HAS_MODULES == True
    request_cpus = 1
    request_memory = 2 GB
    request_disk = 10 GB
    
    executable = /bin/hostname
    
    arguments = -f
    
    should_transfer_files = YES
    WhenToTransferOutput = ON_EXIT
    
    output = job.out
    error = job.err
    log = job.log
    
    notification = NEVER
    
    queue


 Create a file named `job.condor` containing the above text and then run:

    $ condor_submit job.condor

You can check the status of the job using the `condor_q` command.

**Note:** The Open Science Pool is a distributed resource, and there
will be minor differences in the compute nodes, for example in what
system libraries and tools are installed. Therefore, when running
a large number of jobs, it is important to detect and handle job
failures correctly in an automatic fashion. It is recommended that your
application uses non-zero exit code convention to indicate failures, and
that you enable retries in your Condor submit files. For example:
    
    # stay in queue on failures
    on_exit_hold = (ExitBySignal == True) || (ExitCode != 0)
    
    # retry job 3 times, pause 1 hour between retries
    periodic_release =  (NumJobStarts &lt; 3) &amp;&amp; ((CurrentTime - EnteredCurrentStatus) &gt; (60*60))


### Job Example: Java with a job wrapper

The following is an example on how to run Java code on Open Science Pool. The job requirements specifies that the job requires
Java, and a wrapper script is used to invoke Java.

File: `condor.sub`

    universe = vanilla
    
    # specifies the XSEDE project to charge the job usage to - this is a
    # required attribute for all jobs submitted on the OSG-XSEDE resource
    +ProjectName = "TG-NNNNNN"
    
    # requirements is an expression to specify machines that can run jobs
    requirements = HAS_JAVA == True
    
    # stay in queue on failures on_exit_hold = (ExitBySignal == True) || (ExitCode != 0)
    
    # retry job 3 times, pause 1 hour between retries
    periodic_release = (NumJobStarts < 3) && ((CurrentTime - EnteredCurrentStatus) > (60*60))
    
    executable = wrapper.sh
    
    should_transfer_files = YES
    WhenToTransferOutput = ON_EXIT
    
    # a list of files that the job needs
    transfer_input_files = HelloWorld.jar
    
    output = job.out
    error = job.err
    log = job.log
    
    notification = NEVER
    
    queue

File: `wrapper.sh`

    #!/bin/bash
    
    set -e
    
    java HelloWorld


## Sample Jobs and Workflows

A set of sample jobs and workflows can be found under
`/opt/sample-jobs` on the submit-1.osg.xsede.org host. README
files are included with details for each sample.
            
`/opt/sample-jobs/single/` contains a single Condor job
example. Single jobs can be used for smaller set of jobs or if the job
structure is simple, such as parameter sweeps.

A sample-app package
([sampleapp.tgz](http://www.ncsa.illinois.edu/People/yanliu/codes/sampleapp.tgz))
is available in the `/opt/sample-jobs/sampleapp/` directory. This package shows
how to build a library and an executable, both with dynamic and static
linking, and submit the job to a set of different schedulers available
on XSEDE. The package includes submit files for PBS, SGE and Condor.
            
[DAGMan](http://research.cs.wisc.edu/condor/manual/current/2_10DAGMan_Applications.html)
is a HTCondor workflow tool. It allows the
creation of a directed acyclic graph of jobs to be run, and then DAGMan
submits and manages the jobs. DAGMan is also useful if you have a
large number of jobs, even if there are no job inter-dependencies, as
DAGMan can keep track of failures and provide a restart mechanism if
part of the workflow fails. A sample DAGMan workflow can be found in
`/opt/sample-jobs/dag/`

[Pegasus](https://pegasus.isi.edu) is a workflow system that
can be used for more complex workflows. It plans abstract workflow
representations down to an executable workflow and uses Condor DAGMan
as a workflow executor. Pegasus also provides debugging and monitoring
tools that allow users to easily track failures in their workflows.
Workflow provenance information is collected and can be summarized with
the provided statistical and plotting tools. A sample Pegasus workflow
can be found in `/opt/sample-jobs/pegasus/` .


## Singularity Containers

Singularity containers provide a great solution for complex software
stacks or OS requirements, and OSG has easy to use integrated support
for such containers. Full details can be found in the
[Singularity Containers](https://support.opensciencegrid.org/support/solutions/articles/12000024676).


## Distribute data with Stash

Stash is a data solution used under
[OSGConnect](https://osgconnect.net/), but is partly also available 
for OSG XSEDE users. Files under `/local-scratch/public_stash/` will
automatically synchronize to the globally available
`/cvmfs/stash.osgstorage.org/user/xd-login/public/` file system, which
is available to the majority of OSG connected compute nodes. This is a great
way to distribute software and commonly used data sets. To get started, create 
your own sub directory:

    $ mkdir -p /local-scratch/public_stash/$USER

Now, populate that directory with the software and data required for your jobs.
The synchronization can take couple of hours. You can verify the data has
reached the /cvmfs system by using `ls`:

    $ ls /cvmfs/stash.osgstorage.org/user/xd-login/public/

To steer your jobs to compute nodes which can access the file system, add
`HAS_CVMFS_stash_osgstorage_org == True` to your job 
requirements. For example:

    requirements = OSGVO_OS_STRING == "RHEL 6" && Arch == "X86_64" && HAS_MODULES == True && HAS_CVMFS_stash_osgstorage_org == True

Once a job starts up on such a compute node, the job can read directly
from `/cvmfs/stash.osgstorage.org/user/xd-login/public/`


## How to get help using OSG

XSEDE users of OSG may get technical support by
contacting OSG Research Facilitation staff at email
<support@opensciencegrid.org>.
Users may also contact the [XSEDE helpdesk](https://portal.xsede.org/help-desk).
