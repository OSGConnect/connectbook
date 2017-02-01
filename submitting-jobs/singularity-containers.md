[title]: - "Singularity Containers"

[TOC]

Singularity is a container system to allow users full control over their enviroment. You
can create your own container image which your job will execute within, or choose from
a set of pre-defined images. For more information about Singularity, please see:

 * [Singularity Home Page](http://singularity.lbl.gov/)

Also, Derek Weitzel wrote a blog post about Singularity on OSG, which provides a good
introduction on how to create images and run them, but does not cover all the
functionality described further down:

  * [Singularity on the OSG](https://djw8605.github.io/2017/01/12/singularity-on-the-osg/)

Note that Singularity support on OSG is still being explored, and the approach
taken might change. Currently there are only a small number of sites which support
Singularity which means that resource availability might be limited.
Please send any feedback of the system to
[user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org)

## Auto Loading the Default Image

The default setup is to auto load an image on sites which support Singularity. Every
job which lands on such a site, will have a container started for them, and the job
run within that container. Most users will not even know that their jobs are run
within a container, but it will provide them with a consistent environment across
OSG sites. The current default container is [CernVM](https://cernvm.cern.ch/) which is
derivative of EL6. If you want to steer a job to run on a default Singularity instance,
use *HAS_SINGULARITY == True* in the job requirements. For example:

    universe = vanilla
    executable = job.sh
    Requirements = HAS_SINGULARITY == TRUE

    should_transfer_files = IF_NEEDED
    when_to_transfer_output = ON_EXIT

    output = out
    error = err
    log = log

    queue

## Auto Loading a Custom Image

To instruct the system to load a custom image, use the *+SingularityImage* attribute in 
your job submit file. For example:

    universe = vanilla
    executable = job.sh
    Requirements = HAS_SINGULARITY == TRUE

    +SingularityImage = "docker://python:latest python"

    should_transfer_files = IF_NEEDED
    when_to_transfer_output = ON_EXIT

    output = out
    error = err
    log = log

    queue

The image can be specified in any of the formats supported by Singularity (see
[Supported URIs](http://singularity.lbl.gov/user-guide#supported-uris). However, if
you are going to be running a lot of jobs, the docker: and http(s): formats might
cause unnecessary network traffic. A better alterative is to store the image in 
CVMFS. The image will then be automatically cached close to the compute nodes.

When using a docker: or http(s):, the images will be downloaded to the current
working directory. If you use HTCondor's automatic data transfer for output files
you might get copies of the image staged back for each and every job. To prevent
this from happening, explicitly tell HTCondor what files to stage back using
the *transfer_output_files = ...* attribute.

If you want to use a custom image, but still have access to /cvmfs, you can add
*+SingularityBindCVMFS = True* to your job. /cvmfs on the compute node will then
be bound to /cvmfs inside your container, but please not that this only works
if the /cvmfs directory exists in the image.

## Disabling Auto Loading

Sometimes it is usuful to be able to land on a node which has Singularity, but not
have OSG do any auto loading. For example, if you have a very specific requirements
on how Singularity is invoked, it might be easier to just disable auto loading and
run the Singularity command line from within your job (see Derek's blog post mentioned
above). To disable autoloading, add *+SingularityAutoLoad = False* to your HTCondor
submit file. For example:

    universe = vanilla
    executable = job.sh
    Requirements = HAS_SINGULARITY == TRUE

    +SingularityAutoLoad = False

    should_transfer_files = IF_NEEDED
    when_to_transfer_output = ON_EXIT

    output = out
    error = err
    log = log

    queue







