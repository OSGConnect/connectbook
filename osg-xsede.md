[title]: - "OSG XSEDE User Guide"

<div class="user-guide-container">
    <div class="user-guide">
        <h2>
            <a name="overview"></a><a href="#overview">Overview</a></h2>
        <p>
            The <a href="http://www.opensciencegrid.org/">Open Science Grid</a> (OSG) promotes science by:</p>
        <ul>
            <li>
                enabling a framework of distributed computing and storage resources</li>
            <li>
                making available a set of services and methods that enable better access to ever increasing computing resources for researchers and communities</li>
            <li>
                providing resource sharing principles and software that enable distributed high throughput computing (DHTC) for users and communities at all scales.</li>
        </ul>
        <p>
            The OSG facilitates access to DHTC for scientific research in the US. The resources accessible through the OSG are contributed by the community, organized by the OSG, and governed by the <a href="http://www.opensciencegrid.org">OSG Consortium</a>; an overview is available at <a href="http://osg-docdb.opensciencegrid.org/0008/000839/004/OSG%20Intro%20v23.pdf">An Introduction to OSG</a>. In July 2013, OSG is comprised of about 126 institutions with ~120 active sites that collectively support usage of ~2,000,000 core hours per day. Up-to-date usage metrics are available at the <a href="http://display.grid.iu.edu/">OSG Usage Display</a>.</p>
        <p>
            Cores that are not being used at any point in time by the owning communities are made available for shared use by other researchers; this usage mode is called opportunistic access. OSG supports XSEDE users by providing a Virtual Cluster that forms an abstraction layer to access the opportunistic cores in the distributed OSG infrastructure. This interface allows XSEDE users to view the OSG as a single cluster to manage their jobs, provide the inputs and retrieve the outputs. XSEDE users access the OSG via the OSG-XSEDE login host that appears as a resource in the XSEDE infrastructure.</p>
        <h2>
            <a name="computations_match"></a> <a href="#computations_match">Computation that is a good match for OSG</a></h2>
        <p>
            High throughput workflows with simple system and data dependencies are a good fit for OSG. The <a href="http://research.cs.wisc.edu/condor/manual/v7.6/index.html">Condor manual</a> has an overview of <a href="http://research.cs.wisc.edu/condor/manual/v7.6/1_Overview.html">high throughput computing</a>.</p>
        <p>
            Jobs submitted into the OSG Virtual Cluster will be executed on machines at several remote physical clusters. These machines may differ in terms of computing environment from the submit node. Therefore it is important that the jobs are as self-contained as possible by generic binaries and data that can be either carried with the job, or staged on demand. Please consider the following guidelines:</p>
        <ul>
            <li>
                Software should preferably be <strong>single threaded</strong>, using <strong>less than 2 GB memory</strong> and each invocation should <strong>run for 1-12 hours</strong>. Please contact the support listed below for more information about these capabilities. System level check pointing, such as the HTCondor standard universe, is not available. Application level check pointing, for example applications writing out state and restart files, can be made to work on the system.</li>
            <li>
                Compute sites in the OSG can be configured to use pre-emption, which means jobs can be automatically killed if higher priority jobs enter the system. Pre-empted jobs will restart on another site, but it is important that the jobs can handle multiple restarts.</li>
            <li>
                Binaries should preferably be statically linked. However, dynamically linked binaries with standard library dependencies, built for a 64-bit Red Hat Enterprise Linux (RHEL) 5 machines will also work. Also, interpreted languages such as Python or Perl will work as long as there are no special module requirements.</li>
            <li>
                Input and output data for each job should be &lt; 10 GB to allow them to be pulled in by the jobs, processed and pushed back to the submit node. Note that the OSG Virtual Cluster does not currently have a global shared file system, so jobs with such dependencies will not work.</li>
            <li>
                Software dependencies can be difficult to accommodate unless the software can be staged with the job.</li>
        </ul>
        <p>
            The following are examples of computations that are <b>not</b> good matches for OSG:</p>
        <ul>
            <li>
                Tightly coupled computations, for example MPI based communication, will not work well on OSG due to the distributed nature of the infrastructure.</li>
            <li>
                Computations requiring a shared file system will not work, as there is no shared filesystem between the different clusters on OSG.</li>
            <li>
                Computations requiring complex software deployments are not a good fit. There is limited support for distributing software to the compute clusters, but for complex software, or licensed software, deployment can be a major task.</li>
        </ul>
        <h2>
            <a name="system_configuration"></a><a href="#system_configuration">System Configuration</a></h2>
        <p>
            The OSG Virtual Cluster is a Condor pool overlay on top of OSG resources. The pool is dynamically sized based on the demand, the number of jobs in the queue, and supply, resource availability at the OSG resources. It is expected that the average number of resources, on average, available to XSEDE users will be in the order of 1,000 cores.</p>
        <p>
            One important difference between the OSG Virtual Cluster and most of the other XSEDE resources is that the OSG Virtual Cluster does not have a shared file system. This means that your jobs will have to bring executables and input data. Condor can transfer the files for you, but you will have to identify and list the files in your Condor job description file.</p>
        <p>
            Local storage space at the submission site is controlled by quota. Your home directory has a quota of 10 GBs and your work directory <code>/local-scratch/$USER</code> has a quota of 1 TB. There are no global quotas on the remote compute nodes, but expect that about 10 GBs are available as scratch space for each job.</p>
        <h2>
            <a name="system_access"></a><a href="#system_access">System Access</a></h2>
        <p>
            The OSG Virtual Cluster supports Single Sign On through the XSEDE User Portal, and also from the command line using <code>gsissh</code> with a grid certificate for authentication. Please see the <a href="https://www.xsede.org/accessing-resources">XSEDE GSISSH documentation</a> for more information. Additionaly, you may install a SSH public key to do direct logins from your own computer.</p>
        <p>
            To log in via the XSEDE User Portal, log in to the portal and use the login link on the "accounts" tab there.</p>
        <p>
            To log in via gsissh:</p>
        <pre>
$ gsissh submit-1.osg.xsede.org</pre>
        <p>
            To transfer files, you can use the GridFTP clients, <code>globus-url-copy</code> or <code>gsiscp</code>, as in the following examples:</p>
        <pre>
$ globus-url-copy file:///a/local/file gsiftp://submit-1.osg.xsede.org/local-scratch/username/filename</pre>
        <pre>
$ gsiscp /a/local/file submit-1.osg.xsede.org/local-scratch/username/filename
</pre>
        <h3>
            SSH public key authentication</h3>
        <p>
            Secure shell users should feel free to append their public RSA key to their ~/.ssh/authorized_keys file to enable access from their own computer. Please login once via the XSEDE portal to install your key. Please make sure that the permissions on the .ssh directory and the&nbsp;<span style="letter-spacing: 0.4px;">authorized_keys file have appropiate permissions. For example:</span></p>
        <pre>
$ chmod 755 ~/.ssh

$ chmod 644 ~/.ssh/authorized_keys</pre>
        <h2>
            <a name="appdev"></a><a href="#appdev">Application Development</a></h2>
        <p>
            Most of the clusters in OSG are running Red Hat Enterprise Linux (RHEL) 5 or 6, or some derivative thereof, on an x86_64 architecture. For your application to work well in this environment, it is recommend that the application is compiled on a similar system, for example on the OSG Virtual Cluster login system: <code>submit-1.osg.xsede.org </code>. It is also recommended that the application be statically linked, or alternatively dynamically linked against just a few standard libraries. What libraries a binary depends on can be checked using the Unix <code>ldd</code> command-line utility:</p>
        <pre>
$ ldd a.out
      a.out is a static executable
</pre>
        <p>
            In the case of interpreted languages like Python and Perl, applications have to either use only standard modules, or be able to ship the modules with the jobs. Please note that different compute nodes might have different versions of these tools installed.</p>
        <h2>
            <a name="running"></a><a href="#running">Running Your Application</a></h2>
        <p>
            The OSG Virtual Cluster is based on Condor and the <a href="http://research.cs.wisc.edu/condor/manual/v7.6/">Condor manual</a> provides a reference for command line tools. The commonly used tools are:</p>
        <ul>
            <li>
                <code><b>condor_submit</b></code> - Takes a Condor submit file and adds the job to the queue</li>
            <li>
                <code><b>condor_q</b></code> - Lists the jobs in the queue. Can be invoked with your username to limit the list of jobs to your jobs:
                <pre>
$ condor_q $USER</pre>
            </li>
            <li>
                <code><b>condor_status</b></code> - Lists the available slots in the system. Note that this is a dynamic list and if there are no jobs in the system, <code>condor_status</code> may return an empty list</li>
            <li>
                <code><b>condor_rm</b></code> - Remove a job from the queue. If you are running a DAG, please <code>condor_rm</code> the id of the DAG to remove the whole workflow.</li>
        </ul>
        <h3>
            <a name="running:simple"></a> <a href="#running:simple">Submitting a Simple Job</a></h3>
        <p>
            Below is a basic job description for the Virtual Cluster.</p>
        <pre>
universe = vanilla

# specifies the XSEDE project to charge the job usage to - this is a
# required attribute for all jobs submitted on the OSG-XSEDE resource
+ProjectName = "TG-NNNNNN"

# requirements is an expression to specify machines that can run jobs
requirements = OSGVO_OS_STRING == "RHEL 6" &amp;&amp; Arch == "X86_64" &amp;&amp; HAS_MODULES == True
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
</pre>
        <p>
            Create a file named "<code>job.condor</code>" containing the above text and then run:</p>
        <pre>
$ <b>condor_submit job.condor</b></pre>
        <p>
            You can check the status of the job using the "<code>condor_q</code>" command.</p>
        <p>
            <b>Note:</b> Open Science Grid is a distributed resource, and there will be minor differences in the compute nodes, for example in what system libraries and tools are installed. Therefore, when running a large number of jobs, it is important to detect and handle job failures correctly in an automatic fashion. It is recommended that your application uses non-zero exit code convention to indicate failures, and that you enable retries in your Condor submit files. For example:</p>
        <pre>
# stay in queue on failures
on_exit_hold = (ExitBySignal == True) || (ExitCode != 0)

# retry job 3 times, pause 1 hour between retries
periodic_release =  (NumJobStarts &lt; 3) &amp;&amp; ((CurrentTime - EnteredCurrentStatus) &gt; (60*60))
</pre>
        <h3>
            <a name="running:simple"></a> <a href="#running:simple">J</a>ob Example: Java with a job wrapper</h3>
        <p>
            The following is an example on how to run Java code on Open Science Grid. The job requirements specifies that the job requires Java, and a wrapper script is used to invoke Java.</p>
        <p>
            File: <em>condor.sub</em></p>
        <pre>
universe = vanilla

# specifies the XSEDE project to charge the job usage to - this is a
# required attribute for all jobs submitted on the OSG-XSEDE resource
+ProjectName = "TG-NNNNNN"

# requirements is an expression to specify machines that can run jobs
requirements = (HAS_JAVA =?= True)

# stay in queue on failures
on_exit_hold = (ExitBySignal == True) || (ExitCode != 0)

# retry job 3 times, pause 1 hour between retries
periodic_release =  (NumJobStarts &lt; 3) &amp;&amp; ((CurrentTime - EnteredCurrentStatus) &gt; (60*60))

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
        </pre>
        <p>
            FIle: <em>wrapper.sh</em></p>
        <pre>
#!/bin/bash

set -e

java HelloWorld</pre>
        <h3>
            <a name="samplejobs"></a>&nbsp;More&nbsp;<a href="#samplejobs">Sample Jobs and Workflows</a></h3>
        <p>
            A set of sample jobs and workflows can be found under <code>/opt/sample-jobs</code> on the<font face="Consolas, Bitstream Vera Sans Mono, Courier New, Courier, monospace"><span style="white-space: pre;">&nbsp;submit-1.osg.xsede.org</span></font>&nbsp;host. README files are included with details for each sample.</p>
        <p>
            <code>/opt/sample-jobs/single/</code> contains a single Condor job example. Single jobs can be used for smaller set of jobs or if the job structure is simple, such as parameter sweeps.</p>
        <p>
            A sample-app package (<a href="http://www.ncsa.illinois.edu/People/yanliu/codes/sampleapp.tgz">sampleapp.tgz</a>) is available in the <code>/opt/sample-jobs/sampleapp/</code> directory. This package shows how to build a library and an executable, both with dynamic and static linking, and submit the job to a set of different schedulers available on XSEDE. The package includes submit files for PBS, SGE and Condor.</p>
        <p>
            <a href="http://research.cs.wisc.edu/condor/manual/v7.6/2_10DAGMan_Applications.html">DAGMan</a> is a Condor workflow tool. It allows the creation of a directed acyclic graph of jobs to be run, and then DAGMan submits and manages the jobs. DAGMan is also useful if you have a large number of jobs, even if there are no job inter-dependencies, as DAGMan can keep track of failures and provide a restart mechanism if part of the workflow fails. A sample DAGMan workflow can be found in <code>/opt/sample-jobs/dag/</code></p>
        <p>
            <a href="http://pegasus.isi.edu">Pegasus</a> is a workflow system that can be used for more complex workflows. It plans abstract workflow representations down to an executable workflow and uses Condor DAGMan as a workflow executor. Pegasus also provides debugging and monitoring tools that allow users to easily track failures in their workflows. Workflow provenance information is collected and can be summarized with the provided statistical and plotting tools. A sample Pegasus workflow can be found in <code>/opt/sample-jobs/pegasus/</code> . See also: <a href="http://pegasus.isi.edu/news/osg-xsede">OSG-XSEDE - Improving the user experience with Pegasus</a></p>
        <h2>
            <a name="help"></a><a href="#help">How to get help using OSG</a></h2>
        <p>
            XSEDE users of OSG may get technical support by contacting OSG User Support staff at email <a href="mailto:osg-xsede-support@opensciencegrid.org">osg-xsede-support@opensciencegrid.org</a>. Users may also contact the <a href="https://portal.xsede.org/help-desk">XSEDE helpdesk</a>.</p>
        <p>
            <i>Last update: December 10, 2013</i></p>
    </div>
</div>
