[title]: - "Roadmap to HTC Workload Submission via OSG Connect"

[TOC]

# Overview

This guide lays out the steps needed to go from logging in to an OSG 
Connect login node to running a full scale high throughput computing 
(HTC) workload on OSG's [Open Science Pool (OSPool)](https://opensciencegrid.org/about/open_science_pool/). 
The steps listed here apply to any new workload 
submission, whether you are a long-time OSG user or just getting 
started - this guide can be used as an "overview" of the steps 
needed to get up and running. 

For new users, this guide also includes links to our documentation pages, 
providing information and instruction about *how* to perform each step of 
developing a new workload submission. 

This guide assumes that you have applied for an account on the OSG Connect service and 
have been approved after meeting with an OSG Research Computing Facilitator. 
If you don't yet have an account, you can apply for one at <osgconnect.net>
or [contact us](mailto:support@opensciencegrid.org) with any questions you have. 

# 1. Introduction to the OSG

The OSG is an international consortium of computing resources at more
than one hundred institutional partners that, together, offer a
strategic advantage for computing work that can be run as numerous short
tasks. 

The OSG's Open Science Pool is best-suited for computing work that can be run as many, independent 
tasks, in an approach called "high throughput computing." For more information 
on what kind of work is a good fit for the OSG, 
see [Is the Open Science Pool for You?](5000632058). 

Learn more about the services provided by the OSG that can support your HTC workload: 

<a href="https://www.youtube.com/watch?v=5FMAFxROGv0"><img alt="OSG Introduction" src="https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/osg-intro-video-screenshot.png" width="360" height="204"></a>

<!-- Diagram/cartoon showing how jobs are distributed to multiple sites across the U.S.-->

# 2. Get on OSG Connect

After your OSG account has been approved, go through the following guides to 
complete your access to the login node and to enable your account to submit jobs. 

- [Generate ssh keys and login](https://support.opensciencegrid.org/support/solutions/articles/12000027675-generate-ssh-keys-and-activate-your-osg-login)
- [Set up project](https://support.opensciencegrid.org/support/solutions/articles/5000634360-join-and-use-a-project-in-osg-connect)

# 3. Explore HTCondor

Computational work is run on the OSPool by submitting it as “jobs” to the
HTCondor scheduler. Jobs submitted to HTCondor are then scheduled and
run on different resources that are part of the Open Science Pool.
Before submitting your own computational work, it is important to
understand how HTCondor job submission works. The following guides show
how to submit basic HTCondor jobs. The second example allows you to see
where in the OSPool your jobs ran. 

- [OSG Connect Quickstart](https://support.opensciencegrid.org/support/solutions/articles/5000633410-osg-connect-quickstart)
- [Finding OSG Locations](https://support.opensciencegrid.org/support/solutions/articles/12000061978-finding-osg-locations)

# 4. Test a Job

After learning about the basics of HTCondor job submission, you will
need to generate your own HTCondor job -- including the software needed
by the job and the appropriate mechanism to handle the data. We
recommend doing this using a single test job. 

## Prepare your software

Software is an integral part of your HTC workflow.  Whether you’ve written it yourself, inherited it from your research group, or use common open-source packages, any required executables and libraries will need to be made available to your jobs if they are to run on the OSPool. 

Read through [this overview of Using Software in OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000634395-using-software-in-osg-connect) to help you determine the best way to provide your software.  Once you know which method you would like to try, select and complete one of the following guides/tutorials:

- To **install your own software**, begin with the guide on [Compiling Software for OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000652099) and then complete the [Example Software Compilation tutorial](https://support.opensciencegrid.org/support/solutions/articles/12000074984).
- To **use precompiled binaries**, try the example presented in the [AutoDock Vina tutorial](https://support.opensciencegrid.org/support/solutions/articles/5000634379-running-a-molecule-docking-job-with-autodock-vina) and/or the [Julia tutorial](https://support.opensciencegrid.org/support/solutions/articles/12000078187-using-julia-on-the-osg).
- To **use Docker containers** for your jobs, start with the [Docker and Singularity Containers guide](https://support.opensciencegrid.org/support/solutions/articles/12000024676), and (optionally) work through the [Tensorflow tutorial](https://support.opensciencegrid.org/support/solutions/articles/12000028940-working-with-tensorflow-gpus-and-containers) (which uses Docker/Singularity)
- To **use Distributed Environment Modules** for your jobs, start with [this Modules guide](https://support.opensciencegrid.org/support/solutions/articles/12000048518) and then complete the Module example in [this R tutorial](https://support.opensciencegrid.org/support/solutions/articles/5000674219-run-r-scripts-on-osg)

Finally, here are some additional guides specific to some of the most common scripting languages and software tools used on OSG\*\*:
- [Python](https://support.opensciencegrid.org/support/solutions/articles/12000058785-run-python-scripts-on-osg)
- [R](https://support.opensciencegrid.org/support/solutions/articles/5000674218-use-external-packages-in-your-r-jobs)
- [Julia](https://support.opensciencegrid.org/support/solutions/articles/12000078187-using-julia-on-the-osg)
- [Machine Learning](https://support.opensciencegrid.org/support/solutions/articles/12000028940-working-with-tensorflow-gpus-and-containers)
- [BLAST](https://support.opensciencegrid.org/support/solutions/articles/12000062020-running-a-blast-workflow)
- [Matlab](https://support.opensciencegrid.org/support/solutions/articles/5000660751-basics-of-compiled-matlab-applications-hello-world-example)

\*\*This is not a complete list.  Feel free to search for your software in our [Knowledge base](https://support.opensciencegrid.org/support/solutions/). 

## Move your data

The data for your jobs originates on the OSG Connect login node, but
needs to be copied to other nodes in the OSPool in order to be used by
jobs. There are different ways for your jobs to move their input and
output data based on their size. The following guides summarize which
options exist and when to use them. 

- Read about Data: [Data Management Policies](https://support.opensciencegrid.org/support/solutions/articles/12000002985-data-management-and-policies)
- Pick a tutorial?

<!-- TODO: add guides
## Organize your files*
## Troubleshooting*
-->

# 5. Scale Up

After you have a sample job running successfully, you’ll want to scale
up. HTCondor has many useful features that make it easy to submit
multiple jobs. First, look at the guide that describes a testing
process, and follow it, making sure to slowly scale up. To see how to
submit multiple jobs, see the second guide. 

- Things to think about: [Scaling up after success with test jobs](https://support.opensciencegrid.org/support/solutions/articles/12000076552-scaling-up-after-success-with-test-jobs)
- Scale up to multiple jobs: [Easily submit multiple jobs](https://support.opensciencegrid.org/support/solutions/articles/12000073165-easily-submit-multiple-jobs)

<!-- TODO: Making jobs resilient* -->

# 6. Special Use Cases

If you think any of the below applies to you, 
please [get in touch](mailto:support@opensciencegrid.org)
and our facilitation team will be happy to discuss your individual case. 

- How to run sequential workflows of jobs: [Workflows with HTCondor's DAGMan](12000079038)
- How to handle jobs that are longer than our recommended 12 hours: [Checkpointing Guide (forthcoming)]
- How to build your own Docker container: [Creating a Docker Container Image](12000058245)
- How to safely submit more than 10,000 jobs: [FAQ, search for max_idle](5000634384)
- Larger or speciality resource requests: 
	- GPUs: [GPU Jobs](5000653025)
	- Multiple CPUs: [Multicore Jobs](5000653862)
	- Large Memory: [Large Memory Jobs](5000652304)

# Getting Help 

For assistance or questions, please email the OSG Facilitation team  at <mailto:support@opensciencegrid.org> or visit the [help desk and community forums](http://support.opensciencegrid.org).
