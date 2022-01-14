[title]: - "Use Containers on the OSG"

[TOC]

Docker and Singularity are container systems that allow users full control 
over their software environment. You can create your own container image or choose from a set of pre-defined images, 
and specify that your submitted jobs run within one of these. 

For jobs on OSG, it does not matter whether you provide a Docker or Singularity 
image. Either is compatible with our system and can be used with little to 
no modification, though *may* be dependent on your software. Please
feel free to contact us at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) if you have any questions. 

## Use an OSG-Provided Singularity Image

The OSG Team maintains a set of images that are already in the OSG Singularity repository. A list of available containers can be
found on [this page][container-list]. 

If the software you need isn't already supported in a listed container, you can use your 
own container or any container image in Docker Hub (see sections further below). Once the container you 
need is in the OSG Singularity repository, your can submit jobs that run within a particular container 
by listing the container image in the submit file, along with a requirement to only run on sites in the 
Open Science Pool that support Singularity.

For example, this is what a submit file might look like to run your job within our EL7 container:

    Requirements = HAS_SINGULARITY == TRUE
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7:latest"

    <other usual submit file lines>
    queue

> **When using a container for your jobs, as in the above example, the container image is automatically started up when HTCondor matches your job to a slot.  The executable provided in the submit script will be run within the context of the container image, having access to software and libraries that were installed to the image, as if they were already on the server where the job is running. Job executables need not (and should not) run any singularity or docker commands to start the container.**

## Use a Custom Singularity Image

If you already have software in the form of a `.sif` Singuilarity file, and that file
is within the [supported data sizes](https://support.opensciencegrid.org/support/solutions/articles/12000002985-overview-data-staging-and-transfer-to-jobs), you can stage the .sif file in your `/home` or `/public` 
location, and list it in the submit file to be transfered and used by 
the job (from within the working directory of the job, i.e. `./`):

    transfer_input_files = path/to/mycontainer.sif, <other files to transfer, as usual>
    +SingularityImage = "./mycontainer.sif"
    Requirements = HAS_SINGULARITY == TRUE

    <other usual submit file lines>
    queue
    
**Note that if your container is large enough to stage in `/public` that you will 
need to specify the appropriate `stash:///` address in the `transfer_input_files` line.

## Use Docker Images via Docker Hub

If you would prefer to create or use an existing Docker Hub container 
(especially if an authoritative container for your software already exists in DockerHub), you will: 

1. Create your own Docker container image, and push it to Docker Hub. (if a container for your software doesn't already exist in Docker Hub)
2. Add a Docker Hub image to the OSG Singularity repository.
3. Use the container image in jobs. 

We will expand on each of these steps below. 

### Create a Container

If you want to use an container image you have created yourself, the image
should be defined as a Docker image and published in [Docker
Hub](https://hub.docker.com/). Using Docker Hub allows us to easily import the images into
our the OSG Singularity repository (see further above). 

See [this page][container-howto] for how to create a Docker image on your own computer and 
push it to Docker Hub so it can be used by the Open Science Pool. 

### Submit your Docker Container to the OSG Repository

Once your Docker image has been published on Docker Hub, it needs to be 
submitted to the OSG Singularity repository (`/cvmfs/singularity.opensciencegrid.org/`), 
which also hosts the OSG-provided default images (described further above). 

To get your images included, please create a git pull request with the container 
identifier in `docker_images.txt` in the
[cvmfs-singularity-sync repository](https://github.com/opensciencegrid/cvmfs-singularity-sync), 
or contact
[support@opensciencegrid.org](mailto:support@opensciencegrid.org)
and we can help you.

Once your submission has been accepted, it will be automatically converted to a Singularity 
image and pushed to the OSG Singularity repository (see further above).  Note: some 
common Dockerfile features, like ENV and ENTRYPOINT, are ignored when the Docker 
image is converted to a Singularity image. See our the "Special Cases" section of our 
[how to guide][container-howto] for more details 
of how to deal with this. 

Once your container has been added to CVMFS, 
if you update your original Docker image, new versions pushed to Docker Hub will
automatically be detected and the version on the OSG (in the CVMFS filesystem)
will be updated accordingly.

### Use the Docker Container in a Job

To use your container to run jobs, you will specify the container path within CVMFS, as well as a requirement to run 
only on execute points that support Singularity. For example, if your Docker Hub username is `alice` and you created a container called 
`ncbi-blast` added to the OSG Singularity repository, your submit file will include: 
	
    Requirements = HAS_SINGULARITY == TRUE
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/alice/ncbi-blast"

    <other usual submit file lines>
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

For more information about Docker, please see:

* [Docker Home Page](https://www.docker.com/)

and  Singularity, please see:

 * [Singularity Home Page](http://singularity.lbl.gov/)
 
 Singularity has become the preferred containerization method in scientific computing. The following talk describes Singularity for scientific computing:

<iframe width="560" height="315" src="//www.youtube.com/embed/DA87Ba2dpNM" frameborder="0" allowfullscreen></iframe>

[container-howto]: 12000058245
[container-list]: 12000073449
