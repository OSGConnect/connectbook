[title]: - "Use Software Containers"

[TOC]

Docker and Apptainer/Singularity are container systems that allow users full
control over their software environment. You can create your own
container image or choose from a set of pre-defined images, and specify
that your submitted jobs run within one of these.

For jobs on OSG, it does not matter whether you provide a Docker or
Apptainer/Singularity image. Either is compatible with our system and can be
used with little to no modification. Determining factors on when to
use Apptainer/Singularity images over Docker images include if an image already
exists, external to OSG distribution preferences, and if you have
experience building images in one for format and not the other.

Because OSG is a distributed infrastructure and workloads consists
of a large number jobs (and there container executions), it is
important to consider how the container image is transferred to
the execution nodes. The instructions below contain best practices
when it comes to access both Apptainer/Singularity and Docker images.

When using a container for your jobs, the container image is
automatically started up when HTCondor matches your job to a slot. The
executable provided in the submit script will be run within the context
of the container image, having access to software and libraries that
were installed to the image, as if they were already on the server where
the job is running. Job executables need not (and should not) run any
commands to start the container. Nor should the container image
contain any entrypoint/cmd - the job is the command to be run in the
container.

### Exploring Images on the Access Points

Just like it is important to test your codes and jobs at a small scale,
you should make sure that your container is working correctly. One way
to explore how OSG sees your container images, is to explore them on
the OSG Connect access points. Start an interactive session with the
Apptainer/Singularity "shell" mode. The recommended command line, similar
to how containers are started for jobs, is:

    apptainer shell \
                --home $PWD:/srv \
                --pwd /srv \
                --bind /cvmfs \
                --scratch /var/tmp \
                --scratch /tmp \
                --contain --ipc --pid \
                /cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-ubuntu-20.04:latest/

This will give you an interactive shell in an Ubuntu 20.04 container,
with your current working directory mounted under /srv. You can explore
the container and test your code with for example your own inputs from
your home directory. Once you are down exploring, exit the container
by running `exit` or with `CTRL+D`

## OSG-Provided Images

The OSG Team maintains a set of images that are already in the OSG
Apptainer/Singularity repository. *[A list of available containers can be found on this page][container-list].*

If the software you need isn't already supported in a listed container,
you can use your own container or any container image in Docker Hub
(see sections further below). Once the container you need is in the
OSG Apptainer/Singularity repository, your can submit jobs that run within a
particular container by listing the container image in the submit file.

For example, this is what a submit file might look like to run your job
within our EL8 container:

    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el8:latest"

    <other usual submit file lines>
    queue

## Custom Singularity Images

If you already have software in the form of a `.sif` Apptainer/Singuilarity file,
and that file is within the [supported data sizes][data-staging], you
can stage the .sif file with your job. The image will be resused for
each job, and thus the preferred transfer method is [Stash][stash].
Store the .sif file under `/protected/$USERNAME/`, and then use the stash
url directly in the `+SingularityImage` attribute. Note that you can not
use shell variable expansion in the submit file - be sure to replace the
username with your actual OSG Connect username. Example:

    +SingularityImage = "stash:///osgconnect/protected/USERNAME/my-custom-image-v1.sif"

    <other usual submit file lines>
    queue

Be aware that Stash aggressively caches the image based on file naming.
If you need to do quick changes, please use versioning of the .sif file
so that the caches see a "new" name. In this example, replacing
`my-custom-image-v1.sif` with new content will probably mean that some
nodes get the old version and some nodes the new version. Prevent this
by creating a new file named with v2.

More information on how to create Apptainer/Singularity images can be found
in the [Singularity Images Guide][singularity-guide].

## Custom Docker Images

If you would prefer to create or use an existing Docker Hub container,
for example an authoritative container for your software which
already exists in Docker Hub, OSG can distribute the image for you
via CVMFS. The result is a synchronized copy of the image under
`/cvmfs/singularity.opensciencegrid.org/` which is cached and available
to the execution nodes. Creating and/or registering a Docker
image is described in the [Docker Images Guide][docker-guide].

To run a job with a Docker image, use the `+SingularityImage` to
specify the image the job should be using. Example:

    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el8:latest"

    <other usual submit file lines>
    queue

Another example would be if your Docker Hub username is `alice` and you
created a container called `ncbi-blast`, and tag `v1`, added to the OSG
Singularity repository, your submit file will include:

    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/alice/ncbi-blast:v1"

    <other usual submit file lines>
    queue

## Using Containers from Non-OSG Connect Access Points

Users on non-OSG Connect access points can use all the container
functionality described above, but will have to use slightly more
complex job submit files. This is because the OSG Connect access points
uses job transforms to update the jobs based on the `+SingularityImage`
attribute, and OSG Connect users also have direct access to Stash.

To run a Apptainer/Singularity image from a non-OSG Connect access point, include
a job `requirements`, and specify a method for image transfer. For example:

    Requirements = HAS_SINGULARITY == TRUE && SINGULARITY_CAN_USE_SIF = TRUE
    transfer_input_files = http://datastore.host/mycontainer.sif
    +SingularityImage = "./mycontainer.sif"

    <other usual submit file lines>
    queue

For images available on CVMFS, just add job `requirements`:

    Requirements = HAS_SINGULARITY == TRUE
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el8:latest"

    <other usual submit file lines>
    queue

## Frequently Asked Questions / Common Issues

### FATAL: kernel too old

If you get a *FATAL: kernel too old* error, it means that the glibc version in the
image is too new for the kernel on the host. You can work around this problem by
specifying the minimum host kernel. For example, if you want to run the Ubuntu 18.04
image, specfy a minimum host kernel of 3.10.0, formatted as 31000
(major * 10000 + minor * 100 + patch):

    Requirements = HAS_SINGULARITY == True && OSG_HOST_KERNEL_VERSION >= 31000


### Learning More

For more information about Docker, please see:

* [Docker Home Page](https://www.docker.com/)

and Apptainer/Singularity, please see:

 * [Apptainer Home Page](https://apptainer.org/)
 
Apptainer/ Singularity has become the preferred containerization method in scientific computing. The following talk describes Apptainer/Singularity for scientific computing:

<iframe width="560" height="315" src="//www.youtube.com/embed/DA87Ba2dpNM" frameborder="0" allowfullscreen></iframe>

[container-howto]: 12000058245
[container-list]: 12000073449
[data-staging]: 12000002985
[stash]: 12000002775
[docker-guide]: 12000058245
[singularity-guide]: 12000086275

