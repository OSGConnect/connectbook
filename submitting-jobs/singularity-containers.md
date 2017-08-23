[title]: - "Docker and Singularity Containers"

[TOC]


Docker and Singularity are container systems that allow users full control 
over their environment. You can create your own container image which your 
job will execute within, or choose from a set of pre-defined images. For 
more information about Docker, please see:

* [Docker Home Page](https://www.docker.com/)


and  Singularity, please see:

 * [Singularity Home Page](http://singularity.lbl.gov/)

For jobs on OSG, it does not matter whether you provide a Docker or Singularity 
image. Either is compatible with our system and can be used with little to 
no modification. This is of course highly dependent on your workload. Please
feel free to contact us if you have any questions. 

Singularity has become the preferred containerization method in scientific computing. The following talk describes Singularity for scientific computing:

<iframe width="560" height="315" src="//www.youtube.com/embed/DA87Ba2dpNM" frameborder="0" allowfullscreen></iframe>

Derek Weitzel wrote a blog post about Singularity on OSG, which provides a good
introduction on how to create images and run them, but does not cover all the
functionality described further down:

  * [Singularity on the OSG](https://djw8605.github.io/2017/01/12/singularity-on-the-osg/)

## Default Image

The default setup is to auto load an image on sites which support Singularity. Every
job which lands on such a site, will have a container started just for that job, and
then run within that container. Most users will not even know that their jobs are run
within a container, but it will provide them with a consistent environment across
OSG sites. The current default container is based on EL6 and contains a basic
set of tools expected from OSG compute nodes. The image is loaded from
`/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el6` and the definition file
is available in GitHub
[https://github.com/opensciencegrid/osgvo-el6](https://github.com/opensciencegrid/osgvo-el6) .
If you want to steer a job to run on a default Singularity instance,
use `HAS_SINGULARITY == True` in the job requirements. For example:

    universe = vanilla
    executable = job.sh
    Requirements = HAS_SINGULARITY == TRUE

    should_transfer_files = IF_NEEDED
    when_to_transfer_output = ON_EXIT

    output = out
    error = err
    log = log

    queue

To instruct the system to load a different image, use the `+SingularityImage` attribute in 
your job submit file. For example, to run your job under EL7:

    universe = vanilla
    executable = job.sh
    Requirements = HAS_SINGULARITY == TRUE

    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7"
    +SingularityBindCVMFS = True

    should_transfer_files = IF_NEEDED
    when_to_transfer_output = ON_EXIT

    output = out
    error = err
    log = log

    queue

The user support team maintains a set of images. These contain a basic set of
tools and libraries. The images are are:

|                     | **Image Location**                                                                 | **Defintion** | **Description** |
|:--------------------|:-----------------------------------------------------------------------------------|:-------------:|:----------------|
| **EL 6**            | /cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el6:latest            | [GitHub](https://github.com/opensciencegrid/osgvo-el6)   | A basic Enterprise Linux (CentOS) 6 based image. This is currently our default image |
| **EL 7**            | /cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7:latest            | [GitHub](https://github.com/opensciencegrid/osgvo-el7) | A basic Enterprise Linux (CentOS) 7 based image. |
| **Ubuntu Xenial**   | /cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-ubuntu-xenial:latest  | [GitHub](https://github.com/opensciencegrid/osgvo-ubuntu-xenial) | A good image if you prefer Ubuntu over EL flavors |
| **TensorFlow**      | /cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow:latest           | [GitHub](https://github.com/opensciencegrid/osgvo-tensorflow) | Base on the TensorFlow base image, with a few OSG package added |
| **TensorFlow GPU**  | /cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow-gpu:latest       | [GitHub](https://github.com/opensciencegrid/osgvo-tensorflow-gpu) | Used for running TensorFlow jobs on OSG GPU resources |


## Exploring Images on the Submit Host

Images can be explored interactively on the submit hosts by starting it
in "shell" mode. The recommended command line, similar to how containers
are started for jobs, is:

    singularity shell \
                --home $PWD:/srv \
                --pwd /srv \
                --bind /cvmfs \
                --scratch /var/tmp \
                --scratch /tmp \
                --contain --ipc --pid \
                /cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-ubuntu-xenial:latest

## Custom Images

OSG Connect provides tooling for users to create, publish and load custom images.
This is useful if your job requires some very specific software setup.

### Creating a Custom Image

If you want to use an image you have created yourself, the image
should be defined as a Docker image and published in the [Docker
Hub](https://hub.docker.com/). The reason we use Docker as a source
image repository is that it allows us to easily import the images into
our own distribution system (see below). To get started, create a Docker
user, sign in to the hub, and create a new repository. You will end up
with an identifier of the `namespace/repository_name` format.

There are two main methods, we recommend to generating your own
custom image:

1. Editing the `Dockerfile`
2. Editing the default image using local Docker

which are described below. Once you have created your custom image, 
you will need to register the image as described in the next section. 
If you prefer, you can base you image on images not already published 
by OSG, but if you do this, we recommend that you as one of the steps 
create the `/cvmfs` directory. This will enable the container to access 
tools and data published on `/cvmfs`. If you do not want `/cvmfs` mounted 
in the container, please add `+SingularityBindCVMFS = False` to your job submit file.

#### Editing the `Dockerfile`

To create an image locally using a `Dockerfile`, 
first download the `Dockerfile` for your desired flavor from 
[OSG GitHub repository](https://github.com/opensciencegrid), 
see table above. For example, if you want to base the image on our Ubuntu
Xenial image, 

    $ git pull https://github.com/opensciencegrid/osgvo-ubuntu-xenial.git

and change into the directory

    $ cd osgvo-ubuntu-xenial

Edit the `Dockerfile` in the directory to fit your requirements. If
you want `/cvmfs` mounted in your image please add 

    # required directories
    RUN mkdir -p /cvmfs

to your `Dockerfile`

Then build the image with tag matching your 
Docker Hub repository:

    $ docker build -t namespace/repository_name .

Once you have a successful build, push it to the hub:

    $ docker push namespace/repository_name

#### Editing the default image using local Docker

To create an image locally using Docker, you will need to have Docker 
installed on your machine. For install instructions, see the 
[Docker documentation](https://docs.docker.com/engine/installation/#server).

With docker installed you can now get the desired image from Docker Hub. Again, we will
look at OSG Ubuntu Xenial image. 

    $ docker pull opensciencegrid/osgvo-ubuntu-xenial

We will run the image in a docker interactive session

    $ docker run -it --name <docker_session_name_here> opensciencegrid/osgvo-ubuntu-xenial /bin/bash

Giving the session a name is important because it will make it easier to 
reattach the session later and commit the changes later on. Now you will 
be greeted by a new command line prompt that will look something like this

    [root@740b9db736a1 /]#

You can now install the software that you need through the image package 
manager, in this case `apt-get`. If you want `/cvmfs` mounted in your image 
please run

    [root@740b9db736a1 /]# mkdir -p /cvmfs 

Once you have installed all the software, you simply `exit`

    [root@740b9db736a1 /]# exit

Now you can commit the changes to the image

    docker commit <docker_session_name_here>

Alternatively, you can use the sessions hash (`740b9db736a1` in the above example).
Then you make a tag for your desired `namespace/repository_name`:

    docker tag opensciencegrid/osgvo-ubuntu-xenial namespace/repository_name

And finally you simply need to push the changes:

    docker push namespace/repository_name

### Configuring GPU images

GPU images requires a few extra steps to get access to the host GPU libraries.
We recommend that in this case you edit the `Dockerfile` rather than building 
a image through Docker. 

GPU containers running under GPU slots will automatically get the host GPU
libraries bound to `/host-libs` inside the container. For this to work, 
the `/host-libs` directory has to exist in the image, and `LD_LIBRARY_PATH`
has to be set for the job. An example of how to do this is the 
[TensorFlow GPU image](https://github.com/opensciencegrid/osgvo-tensorflow-gpu).

### Distributing Custom Images Via CVMFS

In order to be able to efficiently distribute the container images to a large
of distributed compute hosts, OSG has chosen to host the images under
[CVMFS](https://cernvm.cern.ch/portal/filesystem). Any image publicly available in
Docker can be included for automatic syncing into the CVMFS repository. The
result is an unpacked image under `/cvmfs/singularity.opensciencegrid.org/`

To get your images included, please either create a git pull request against
`docker_images.txt` in the
[cvmfs-singularity-sync repository](https://github.com/opensciencegrid/cvmfs-singularity-sync), 
or contact
[user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org)
and we can help you.

Once your image has been registered, new versions pushed to Docker Hub will
automatically be detected and CVMFS will be updated accordingly.


