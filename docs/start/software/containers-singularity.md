Create a Singularity Container Image 
====================================

[TOC]

**NOTE:** Building Singularity containers are currently not supported
on the OSGConnect access point. The guide assumes that you have
your own Linux machine where you can install Singularity and
execute commands via sudo.

This guide is meant to accompany the instructions for using containers  
in the Open Science Pool. You can use your own custom container to run  
jobs in the Open Science Pool. This guide describes how to create your  
own Singularity container "image" (the blueprint for the container).         

For an overview and how to execute images on OSG, please see
[Use Containers on the OSG][osg-containers]

## Install Singularity

Install Singularity to your computer using the appropriate version for
your operating system. Note that OSG does not provide any container
build hosts. sudo is required to build the images.

## Identify Components

What software do you want to install? Make sure that you have either the source 
code or a command that can be used to install it through Linux (like `apt-get` or 
`yum`). 

You'll also need to choose a "base" container, on which to add your particular 
software or tools. *We strongly recommend using one of the OSG's published containers 
as your starting point.* See the available containers on Docker Hub here: 
[OSG Docker Containers](https://hub.docker.com/u/opensciencegrid)
The best candidates for you will be containers that have "osgvo" in the name. 

### Editing the Build Spec

Create a folder on your computer and inside it, create a blank text file 
called `image.def`.  

The first lines of this file should include where to get the base image
from. If using the OSG's Ubuntu 20.04 image that  would look like this: 

    Bootstrap: docker
    From: opensciencegrid/osgvo-ubuntu-20.04:latest

Then there is a section called `%post` where you put the additional 
commands to make the image just like you need it. For example:

    %post
        apt-get update -y
        apt-get install -y \
                build-essential \
                libbz2-dev \
                libcurl4-gnutls-dev
        wget https://cran.r-project.org/src/base/R-3/R-3.6.0.tar.gz
        tar -xzf R-3.6.0.tar.gz
        cd R-3.6.0
        ./configure
        make
        make install

See the [Singularity documentation](https://apptainer.org/user-docs/master/definition_files.html)
for a full reference on how to specify build specs. Note that the `%runscript`
section is ignored when the container is executed on OSG.

The final `image.def` looks like:

    Bootstrap: docker
    From: opensciencegrid/osgvo-ubuntu-20.04:latest
    
    %post
        apt-get update -y
        apt-get install -y \
                build-essential \
                libbz2-dev \
                libcurl4-gnutls-dev
        wget https://cran.r-project.org/src/base/R-3/R-3.6.0.tar.gz
        tar -xzf R-3.6.0.tar.gz
        cd R-3.6.0
        ./configure
        make
        make install


Once your build spec is ready, you can "build" the container image by running this command: 

    $ sudo singularity build my-container.sif image.def

Note that `sudo` here is currently required.

Once the image is built, you can upload it to Stash, test it on OSGConenct,
and use it in your HTCondor jobs. This is all described in the
[container guide][osg-containers].

[osg-containers]: 12000024676

