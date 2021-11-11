[title]: - "Create a Docker Container Image"

[TOC]

This guide is meant to accompany the instructions for using containers 
in the Open Science Pool.  You can use your own custom container to run jobs in the 
Open Science Pool, and we assume that those containers are built using Docker.  This 
guide describes how to create your own Docker container "image" (the blueprint for 
the container). Once you have created your custom image, 
you will need to register the image as described in [this page][osg-containers]

## Install Docker and Get a Docker Hub Account

You'll need a Docker Hub account in order to download Docker and share your 
Docker container images with the OSG: [DockerHub](https://hub.docker.com/)

Install Docker Desktop to your computer using the appropriate version for your 
operating system. 

## Identify Components

What software do you want to install? Make sure that you have either the source 
code or a command that can be used to install it through Linux (like `apt-get` or 
`yum`). 

You'll also need to choose a "base" container, on which to add your particular 
software or tools. *We strongly recommend using one of the OSG's published containers 
as your starting point.* See the available containers on Docker Hub here: 
[OSG Docker Containers](https://hub.docker.com/u/opensciencegrid)
The best candidates for you will be containers that have "osgvo" in the name. 

If you prefer, you can base your image on images not already published 
by OSG, but if you do this, we recommend that as one of the creation steps you 
create the `/cvmfs` directory. See [Special Cases](#special-cases) below. 

## Build a Container

There are two main methods for generating your own container image. 

1. Editing the `Dockerfile`
2. Editing the default image using local Docker

We recommend the first option, as it is more reproducible, but the second option 
can be useful for troubleshooting or especially tricky installs. 

### Editing the `Dockerfile`

Create a folder on your computer and inside it, create a blank text file 
called `Dockerfile`.  

The first line of this file should include the keyword `FROM` and then 
the name of a Docker image (from Docker Hub) you want 
to use as your starting point. If using the OSG's Ubuntu Xenial image that 
would look like this: 

	FROM opensciencegrid/osgvo-ubuntu-xenial

Then, for each command you want to run to add libraries or software, use the 
keyword `RUN` and then the command. Sometimes it makes sense to string 
commands together using the `&&` operator and line breaks `\`, like so:

	RUN apt-get update && \
	    apt-get install -yy build-essentials

or

	RUN wget https://cran.r-project.org/src/base/R-3/R-3.6.0.tar.gz && \
	    tar -xzf R-3.6.0.tar.gz && \
	    cd R-3.6.0 && \
	    ./configure && \
	    make && \
	    make install

Typically it's good to group together commands installing the same kind of thing 
(system libraries, or software packages, or an installation process) under one `RUN` command, 
and then have multiple `RUN` commands, one for each of the different type of 
software or package you're installing. 

(For all the possible Dockerfile keywords, see the [Docker Documentation](https://docs.docker.com/engine/reference/builder/))

Once your Dockerfile is ready, you can "build" the container image by running this command: 

    $ docker build -t namespace/repository_name .

Note that the naming convention for Docker images is your Docker Hub username and then 
a name you choose for that particular container image. So if my Docker Hub username 
is `alice` and I created an image with the NCBI `blast` tool, I might use this name: 

    $ docker build -t alice/NCBI-blast .


### Editing the default image using local Docker

You can also build an image interactively, without a Dockerfile. First, get 
the desired starting image from Docker Hub. Again, we will
look at the OSG Ubuntu Xenial image. 

    $ docker pull opensciencegrid/osgvo-ubuntu-xenial

We will run the image in a docker interactive session

    $ docker run -it --name <docker_session_name_here> opensciencegrid/osgvo-ubuntu-xenial /bin/bash

Giving the session a name is important because it will make it easier to 
reattach the session later and commit the changes later on. Now you will 
be greeted by a new command line prompt that will look something like this

    [root@740b9db736a1 /]#

You can now install the software that you need through the default package 
manager, in this case `apt-get`. 

    [root@740b9db736a1 /]# apt-get install build-essentials

Once you have installed all the software, you simply `exit`

    [root@740b9db736a1 /]# exit

Now you can commit the changes to the image and give it a name: 

    docker commit <docker_session_name_here> namespace/repository_name

You can also use the session's hash as found in the command prompt (`740b9db736a1` 
in the above example) in place of the docker session name. 

## Upload Docker Container to Docker Hub

Once your container is complete and tagged, it should appear in the list of local Docker 
container images, which you can see by running:

	$ docker images

From there, you need to put it in Docker Hub, which can be done via the `docker push` 
command:

	$ docker push namespace/repository_name

From here, if you're planning to use this container in OSG, return to our 
[Containers in OSG Guide][osg-containers] to learn how to upload your container to the OSG's container repository. 

## Special Cases

### Accessing CVMFS

If you want your jobs to access CVMFS, make sure that you either: 

1. Use one of the base containers provided by the Open Science Pool

or

2. Add a `/cvmfs` folder to your container: 
  1. If using a Dockerfile, you can do this with the line `RUN mkdir /cvmfs`
  2. If building your container interactively, run `$ mkdir -p /cvmfs`

This will enable the container to access 
tools and data published on `/cvmfs`. 

If you do not want `/cvmfs` mounted 
in the container, please add `+SingularityBindCVMFS = False` to your job submit file.

### ENTRYPOINT and ENV

Two options that can be used in the Dockerfile to set the environment or 
default command are `ENTRYPOINT` and `ENV`. Unfortunately, both of these 
aspects of the Docker container are deleted when it is converted to a 
Singularity image in the Open Science Pool. [Email us](mailto:support@opensciencegrid.org) if you would like 
to preserve these attributes. 

[osg-containers]: 12000024676

