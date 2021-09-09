[title]: - "Getting Started on the OSG"

[TOC]

# Overview

TODO: write text addressing these questions: 

- What is this guide?
- How should it be used?

# 1. Introduction to the OSG

<!-- link to video when finished --> 

- What is OSG Connect?
- What does it give you access to and how?
- What kind of jobs are a good fit for OSG
    - TODO: link to existing guide w/ table 
- Diagram/cartoon showing how jobs are distributed to multiple sites across the U.S.

# 2. Get On OSG Connect

TODO: Intro sentence

- [Generate ssh keys and activate your OSG login](https://support.opensciencegrid.org/support/solutions/articles/12000027675-generate-ssh-keys-and-activate-your-osg-login)
- [Set up project](https://support.opensciencegrid.org/support/solutions/articles/5000634360-join-and-use-a-project-in-osg-connect)

# 3. Explore HTCondor

TODO: Intro paragraph

- [OSG Connect Quickstart](https://support.opensciencegrid.org/support/solutions/articles/5000633410-osg-connect-quickstart)
- [Finding OSG Locations](https://support.opensciencegrid.org/support/solutions/articles/12000061978-finding-osg-locations)

# 4. Test a Job

TODO: Intro sentence

## Prepare your software

Software is an integral part of your HTC workflow.  Whether you’ve written it yourself, inherited it from your research group, or use common open-source packages, any required executables and libraries will need to be made available to your jobs if they are to run on OSG.  

Read through [this overview of Using Software in OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000634395-using-software-in-osg-connect) to help you determine the best way to provide your software.  Once you know which method you would like to try, select and complete one of the following guides/tutorials:

- To **install your own software**, begin with the guide on [Compiling Software for OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000652099) and then complete the [Example Software Compilation tutorial](https://support.opensciencegrid.org/support/solutions/articles/12000074984).
- To **use precompiled binaries**, try the example presented in the [AutoDock Vina tutorial](https://support.opensciencegrid.org/support/solutions/articles/5000634379-running-a-molecule-docking-job-with-autodock-vina) and/or the [Julia tutorial](https://support.opensciencegrid.org/support/solutions/articles/12000078187-using-julia-on-the-osg)
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

TODO: Intro paragraph

- Read about Data: [Data Management Policies](https://support.opensciencegrid.org/support/solutions/articles/12000002985-data-management-and-policies)
- Pick a tutorial?

<!-- TODO: add guides
## Organize your files*
## Troubleshooting*
-->

# 5. Scale Up

TODO: intro sentence

- Things to think about: [Scaling up after success with test jobs](https://support.opensciencegrid.org/support/solutions/articles/12000076552-scaling-up-after-success-with-test-jobs)
- Scale up to multiple jobs: [Easily submit multiple jobs](https://support.opensciencegrid.org/support/solutions/articles/12000073165-easily-submit-multiple-jobs)

<!-- TODO: Making jobs resilient* -->

# 6. Special Use Cases

- long jobs / checkpointing
- complex workflows / DAGMAN
- requesting GPUs or multiple CPUs
- more on docker/singularity
- using max_idle

# Getting Help 

For assistance or questions, please email the OSG User Support team  at <mailto:support@opensciencegrid.org> or visit the [help desk and community forums](http://support.opensciencegrid.org).
