[title]: - "OSG XSEDE User Guide"

<h2><a name="overview"></a><a href="#overview">Overview</a></h2>
            
The <a href="http://www.opensciencegrid.org/">Open Science Grid</a> (OSG) promotes science by:

 * enabling a framework of distributed computing and storage resources

 * making available a set of services and methods that enable better access
   to ever increasing computing resources for researchers and communities

 * providing resource sharing principles and software that enable distributed
   high throughput computing (DHTC) for users and communities at all scales.
         
The OSG facilitates access to DHTC for scientific research
in the US. The resources accessible through the OSG are
contributed by the community, organized by the OSG, and
governed by the <a href="http://www.opensciencegrid.org">OSG
Consortium</a>; an overview is available at <a
href="http://osg-docdb.opensciencegrid.org/0008/000839/004/OSG%20Intro%2
0v23.pdf">An Introduction to OSG</a>. In 2017, OSG is comprised
of about 126 institutions with ~120 active sites that collectively
support usage of ~4,000,000 core hours per day. Up-to-date usage metrics
are available at the <a href="http://display.grid.iu.edu/">OSG Usage
Display</a>.

Cores that are not being used at any point in time by
the owning communities are made available for shared use by other
researchers; this usage mode is called opportunistic access. OSG
supports XSEDE users by providing a Virtual Cluster that forms an
abstraction layer to access the opportunistic cores in the distributed
OSG infrastructure. This interface allows XSEDE users to view the OSG as
a single cluster to manage their jobs, provide the inputs and retrieve
the outputs. XSEDE users access the OSG via the OSG-XSEDE login host
that appears as a resource in the XSEDE infrastructure.

<h2><a name="computations_match"></a><a href="#computations_match">Computation that is a good match for OSG</a></h2>

High throughput workflows with simple system and
data dependencies are a good fit for OSG. The
<a href="http://research.cs.wisc.edu/condor/manual/current/">Condor manual</a> has an overview of <a
href="http://research.cs.wisc.edu/condor/manual/current/1_Overview.html">high throughput computing</a>.

Jobs submitted into the OSG Virtual Cluster will be executed on machines
at several remote physical clusters. These machines may differ in terms
of computing environment from the submit node. Therefore it is important
that the jobs are as self-contained as possible by generic binaries
and data that can be either carried with the job, or staged on demand.
Please consider the following guidelines:


 * Software should preferably be <strong>single threaded</strong>, using
   <strong>less than 2 GB memory</strong> and each invocation should
   <strong>run for 1-12 hours</strong>. Please contact the support listed
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


The following are examples of computations that are <b>not</b> good
matches for OSG:

 * Tightly coupled computations, for example MPI based communication, will
  not work well on OSG due to the distributed nature of the infrastructure.
                
 * Computations requiring a shared file system will not work, as there is
   no shared filesystem between the different clusters on OSG.

 * Computations requiring complex software deployments are not a good fit.
   There is limited support for distributing software to the compute
   clusters, but for complex software, or licensed software, deployment
   can be a major task.


<h2><a name="system_configuration"></a><a href="#system_configuration">System Configuration</a></h2>

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
<code>/local-scratch/$USER</code> has a quota of 1 TB. There are no
global quotas on the remote compute nodes, but expect that about 10 GBs
are available as scratch space for each job.


<h2><a name="system_access"></a><a href="#system_access">System Access</a></h2>

The preferred method to access the system is via the XSEDE Single
Sign On (SSO) Hub. Please see the
<a href="https://portal.xsede.org/single-sign-on-hub">sso documentation</a>
for details.

A secondary access methor is to use SSH public key authentication.
Secure shell users should feel free to append their public RSA key
to their <code>~/.ssh/authorized_keys</code> file to enable access
from their own computer. Please login once via the SSO Hub to install your
key. Please make sure that the permissions on the .ssh directory and
the authorized_keys file have appropiate permissions. For example

    $ chmod 755 ~/.ssh
    $ chmod 644 ~/.ssh/authorized_keys


<h2><a name="appdev"></a><a href="#appdev">Application Development</a></h2>

Most of the clusters in OSG are running Red Hat Enterprise Linux (RHEL)
6 or 7, or some derivative thereof, on an x86_64 architecture. For
your application to work well in this environment, it is recommend
that the application is compiled on a similar system, for example on
the OSG Virtual Cluster login system: <code>submit-1.osg.xsede.org
</code>. It is also recommended that the application be statically
linked, or alternatively dynamically linked against just a few standard
libraries. What libraries a binary depends on can be checked using the
Unix <code>ldd</code> command-line utility:

    $ ldd a.out
          a.out is a static executable
            

In the case of interpreted languages like Python and Perl, applications
have to either use only standard modules, or be able to ship the modules
with the jobs. Please note that different compute nodes might have
different versions of these tools installed.

A good solution to complex software stack is Singularity containers
which are described below.


<h2><a name="running"></a><a href="#running">Running Your Application</a></h2>
            
The OSG Virtual Cluster is based on Condor and the
<a href="http://research.cs.wisc.edu/condor/manual/current/">Condor manual</a>
provides a reference for command line tools. The commonly used tools
are:

 * <code><b>condor_submit</b></code> - Takes a Condor submit file and adds the job to the queue

 * <code><b>condor_q</b></code> - Lists the jobs in the queue. Can be invoked with your
   username to limit the list of jobs to your jobs: <code>condor_q $USER</code>

 * <code><b>condor_status</b></code> - Lists the available slots in the system.
   Note that this is a dynamic list and if there are no jobs in the system,
   <code>condor_status</code> may return an empty list

 * <code><b>condor_rm</b></code> - Remove a job from the queue. If you are running a DAG,
  please <code>condor_rm</code> the id of the DAG to remove the whole workflow.

<h3><a name="running:simple"></a> <a href="#running:simple">Submitting a Simple Job</a></h3>

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


 Create a file named "<code>job.condor</code>" containing the above text and then run:

    $ condor_submit job.condor

You can check the status of the job using the "<code>condor_q</code>" command.

<b>Note:</b> Open Science Grid is a distributed resource, and there
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


<h3><a name="running:simple"></a><a href="#running:simple">J</a>ob Example: Java with a job wrapper</h3>

The following is an example on how to run Java code on Open
Science Grid. The job requirements specifies that the job requires
Java, and a wrapper script is used to invoke Java.

File: <em>condor.sub</em>

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

File: <em>wrapper.sh</em>

    #!/bin/bash
    
    set -e
    
    java HelloWorld


<h3><a name="samplejobs"></a>&nbsp;More&nbsp;<a href="#samplejobs">Sample Jobs and Workflows</a></h3>

A set of sample jobs and workflows can be found under
<code>/opt/sample-jobs</code> on the submit-1.osg.xsede.org host. README
files are included with details for each sample.
            
<code>/opt/sample-jobs/single/</code> contains a single Condor job
example. Single jobs can be used for smaller set of jobs or if the job
structure is simple, such as parameter sweeps.

A sample-app package
(<a href="http://www.ncsa.illinois.edu/People/yanliu/codes/sampleapp.tgz">sampleapp.tgz</a>)
is available in the <code>/opt/sample-jobs/sampleapp/</code> directory. This package shows
how to build a library and an executable, both with dynamic and static
linking, and submit the job to a set of different schedulers available
on XSEDE. The package includes submit files for PBS, SGE and Condor.
            
<a href="http://research.cs.wisc.edu/condor/manual/current/2_10DAGMan_Applications.html">DAGMan</a>
is a HTCondor workflow tool. It allows the
creation of a directed acyclic graph of jobs to be run, and then DAGMan
submits and manages the jobs. DAGMan is also useful if you have a
large number of jobs, even if there are no job inter-dependencies, as
DAGMan can keep track of failures and provide a restart mechanism if
part of the workflow fails. A sample DAGMan workflow can be found in
<code>/opt/sample-jobs/dag/</code>

<a href="https://pegasus.isi.edu">Pegasus</a> is a workflow system that
can be used for more complex workflows. It plans abstract workflow
representations down to an executable workflow and uses Condor DAGMan
as a workflow executor. Pegasus also provides debugging and monitoring
tools that allow users to easily track failures in their workflows.
Workflow provenance information is collected and can be summarized with
the provided statistical and plotting tools. A sample Pegasus workflow
can be found in <code>/opt/sample-jobs/pegasus/</code> .

<h2><a name="help"></a><a href="#help">How to get help using OSG</a></h2>

XSEDE users of OSG may get technical support by
contacting OSG User Support staff at email
<a href="mailto:user-support@opensciencegrid.org">user-support@opensciencegrid.org</a>.
Users may also contact the <a href="https://portal.xsede.org/help-desk">XSEDE helpdesk</a>.


