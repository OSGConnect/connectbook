[title]: - "Use Containers on the OSG"

[TOC]

Docker and Singularity are container systems that allow users full control 
over their environment. You can create your own container image (a blueprint for 
the running container) which your 
job will execute within, or choose from a set of pre-defined images. 

For jobs on OSG, it does not matter whether you provide a Docker or Singularity 
image. Either is compatible with our system and can be used with little to 
no modification. This is of course highly dependent on your workload. Please
feel free to contact us at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) if you have any questions. 

## Using OSG Provided Singularity Images

The OSG user support team maintains a small set of images, hosted in a distributed
file system called [CVMFS](https://cernvm.cern.ch/portal/filesystem). These images
contain a basic set of tools and libraries. A list of available containers can be
found in [this page][container-list].

You can indicate that your job should use one of these images by making the following 
changes to your submit file: 

* Using `Requirements = HAS_SINGULARITY == TRUE` will trigger the scripts that 
load a Singularity image from CVMFS and run your job inside. 
* `+SingularityImage` will tell the job which Singularity image to use for the job.

For example, this is what a submit file might look like to run your job under EL7:

    universe = vanilla
    executable = job.sh
	
    Requirements = HAS_SINGULARITY == TRUE
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7:latest"

    output = out
    error = err
    log = log

    queue


> **When using a container for your jobs, as in the above example, the container image is automatically started up when HTCondor matches your job to a slot.  The executable provided in the submit script will be run within the context of the container image, having access to software and libraries that were installed to the image, as if they were already on the server where the job is running. Job executables need not (and should not) run any singularity or docker commands to start the container.**

## Using Custom Singularity Images

OSG Connect provides tooling for users to create, publish and load custom images.
This is useful if your job requires some very specific software setup. The general 
process goes like this: 

1. Create your own custom container image using **Docker** and push it to Docker Hub. 
2. Add your Docker image to the OS Pool image repository. 
3. Use the container image in jobs. 

We will expand on each of these steps below. 

### Creating a Container

If you want to use an container image you have created yourself, the image
should be defined as a Docker image and published in [Docker
Hub](https://hub.docker.com/). The reason we use Docker as a source
image repository is that it allows us to easily import the images into
our own distribution system (see below). 

See [this page][container-howto] for how to create a Docker image on your own computer and 
push it to Docker Hub so it can be used by the OS Pool. 

When creating the Docker image, you will give it with an 
identifier with this format: `namespace/repository_name`
This identifier will be used both to submit the Docker container to 
the OSG repository and to run jobs. 

### Submitting your Docker Container to the OSG Repository

Once your Docker image has been published on Docker Hub, it needs to be 
submitted to the CVMFS image repository (`/cvmfs/singularity.opensciencegrid.org/`), 
which also hosts the OSG-provided default images. 

To get your images included, please create a git pull request with the container 
identifier in `docker_images.txt` in the
[cvmfs-singularity-sync repository](https://github.com/opensciencegrid/cvmfs-singularity-sync), 
or contact
[support@opensciencegrid.org](mailto:support@opensciencegrid.org)
and we can help you.

Once your submission has been accepted, it will be automatically converted to a Singularity 
image and pushed to the CVMFS Singularity repository.  Note: some 
common Dockerfile features, like ENV and ENTRYPOINT, are ignored when the Docker 
image is converted to a Singularity image. See our the "Special Cases" section of our 
[how to guide][container-howto] for more details 
of how to deal with this. 

Once your container has been added to CVMFS, 
if you update your original Docker image, new versions pushed to Docker Hub will
automatically be detected and the version on the OSG (in the CVMFS filesystem)
will be updated accordingly.

### Using Your Container

To use your container to run jobs, you will follow the same steps as above (under "Using OSG 
Provided Singularity Images"), but will change the `+SingularityImage` option to 
include your container identifier, like so: 

    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/namespace/repository_name"

For example, if my Docker Hub username was `alice` and I created a container called 
`ncbi-blast`, my submit file might look like this: 

    universe = vanilla
    executable = job.sh
	
    Requirements = HAS_SINGULARITY == TRUE
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/alice/ncbi-blast"

    output = out
    error = err
    log = log

    queue


## Frequently Asked Questions / Common Issues

### I already have a Singularity container, not a Docker one

Email the OSG Connect team: support@opensciencegrid.org

### FATAL: kernel too old

If you get a *FATAL: kernel too old* error, it means that the glibc version in the
image is too new for the kernel on the host. You can work around this problem by
specifying the minimum host kernel. For example, if you want to run the Ubuntu 18.04
image, specfy a minimum host kernel of 3.10.0, formatted as 31000
(major * 10000 + minor * 100 + patch):

    Requirements = HAS_SINGULARITY == True && OSG_HOST_KERNEL_VERSION >= 31000

### Exploring Images on the Submit Host

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

### Learning More

For 
more information about Docker, please see:

* [Docker Home Page](https://www.docker.com/)

and  Singularity, please see:

 * [Singularity Home Page](http://singularity.lbl.gov/)
 
 Singularity has become the preferred containerization method in scientific computing. The following talk describes Singularity for scientific computing:

<iframe width="560" height="315" src="//www.youtube.com/embed/DA87Ba2dpNM" frameborder="0" allowfullscreen></iframe>

[container-howto]: 12000058245
[container-list]: 12000073449
