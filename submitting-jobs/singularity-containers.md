[title]: - "Singularity Containers"

[TOC]


Singularity is a container system to allow users full control over their enviroment. You
can create your own container image which your job will execute within, or choose from
a set of pre-defined images. For more information about Singularity, please see:

 * [Singularity Home Page](http://singularity.lbl.gov/)


The following talk describes Singularity for scientific computing:

<iframe width="560" height="315" src="//www.youtube.com/embed/DA87Ba2dpNM" frameborder="0" allowfullscreen></iframe>


Derek Weitzel wrote a blog post about Singularity on OSG, which provides a good
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
job which lands on such a site, will have a container started just for that job, and
then run within that container. Most users will not even know that their jobs are run
within a container, but it will provide them with a consistent environment across
OSG sites. The current default container is based on EL6 and contains a basic
set of tools expected from OSG compute nodes. The image is loaded from
*/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo:el6* and the definition file
is available in GitHub
[https://github.com/opensciencegrid/osgvo-singularity](https://github.com/opensciencegrid/osgvo-singularity) .
If you want to steer a job to run on a default Singularity instance,
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
your job submit file. For example, to run your job under EL7:

    universe = vanilla
    executable = job.sh
    Requirements = HAS_SINGULARITY == TRUE

    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo:el7"
    +SingularityBindCVMFS = True

    should_transfer_files = IF_NEEDED
    when_to_transfer_output = ON_EXIT

    output = out
    error = err
    log = log

    queue

If you want to use a custom image, but still have access to /cvmfs, you can add
*+SingularityBindCVMFS = True* to your job (as in the example above). /cvmfs on
the compute node will then be bound to /cvmfs inside your container, but please
note that this only works if the /cvmfs directory exists in the image. If you do
not want /cvmfs mounted in the container, just set *SingularityBindCVMFS = False*


### Distributing Custom Images Via CVMFS

In order to be able to efficiently distribute the container images to a large
of distributed compute hosts, OSG has choosen to host the images under
[CVMFS](https://cernvm.cern.ch/portal/filesystem). Any image available in
Docker can be included for automatic syncing into the CVMFS repository. The
result is an unpacked image under */cvmfs/singularity.opensciencegrid.org/*

To get your images included, please either create a git pull request against
*docker_images.txt* in the
[cvmfs-singularity-sync repository](https://github.com/opensciencegrid/cvmfs-singularity-sync), 
or contact
[user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org)
and we can help you.


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




