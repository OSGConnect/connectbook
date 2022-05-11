Control Where Your Jobs Run / Job Requirements 
====================================



By default, your jobs will match any available spot in the OSG. This is fine
for very generic jobs. However, in some cases a job may have one or more system
requirements in order to complete successfully. For instance, your job may need to run
on a node with a specific operating system.

HTCondor provides several options for "steering" your jobs to appropriate
nodes and system environments. The `request_cpus`, `request_gpus`, `request_memory`, and `request_disk`
submit file attributes should be used to specify the hardware needs of your jobs.
Please see our guides [Multicore Jobs](https://support.opensciencegrid.org/support/solutions/articles/5000653862-multicore-jobs) and [Large Memory Jobs](https://support.opensciencegrid.org/support/solutions/articles/5000652304-large-memory-jobs)
for more details.

HTCondor also provides a `requirements` attribute and feature-specific
attributes that can be added to your submit files to target specific environments in
which to run your jobs. 

Lastly, there are some custom attributes you can add to your submit file to
either focus on, or avoid, certain execution sites.

# Requirements

The `requirements` attribute is formatted as an expression, so you can use logical
operators to combine multiple requirements where `&&` is used for AND and
`||` used for OR. For example, the following `requirements` statement will direct
jobs only to 64 bit RHEL (Red Hat Enterprise Linux) 8 nodes.

    requirements = OSGVO_OS_STRING == "RHEL 8" && Arch == "X86_64"

Alternatively, if you have code which can run on either RHEL 7 or 8, you can use OR:

    requirements = (OSGVO_OS_STRING == "RHEL 7" || OSGVO_OS_STRING == "RHEL 8") && Arch == "X86_64"

Note that parentheses placement is important for controling how the logical operations
are interpreted by HTCondor.
 
Another common requirement is to land on a node which has CVMFS.
Then the `requirements` would be:

	requirements = HAS_oasis_opensciencegrid_org == True

## Additional Feature-Specific Attributes

There are many attributes that you can use with `requirements`. To see what values
you can specify for a given attribute you can run the following command while
connected to your login node:

	$ condor_status -af {ATTR_NAME} | sort -u
	
For example, to see what values you can specify for the OSGVO_OS_STRING attribute run:
	
	$ condor_status -af OSGVO_OS_STRING | sort -u
    RHEL 7
    RHEL 8

This means that we can specify an OS version of `RHEL 7` or `RHEL 8`. Alternatively
you will find many attributes will take the boolean values `true` or `false`.

Below is a list of common attributes that you can include in your submit file `requirements` statement. 

- **HAS_SINGULARITY** - Boolean specifying the need to use Singularity containers in your job.

- **HAS_MODULES** - Boolean specifying the need to use modules in your job.
  _module load ..._ or not.

- **OSGVO_OS_NAME** - The name of the operating system of the compute node. 
  The most common name is _RHEL_

- **OSGVO_OS_VERSION** - Version of the operating system

- **OSGVO_OS_STRING** - Combined OS name and version. Common values are
  _RHEL 7_ and _RHEL 8_. Please see the requirements string above on the
  recommended setup.

- **OSGVO_CPU_MODEL** - The CPU model identifier string as presented in
  /proc/cpuinfo

- **HAS_CVMFS_oasis_opensciencegrid_org** - Attribute specifying
  the need to access specific oasis /cvmfs file system repositories.

- **CUDACapability** - For GPU jobs, specifies the CUDA compute capability.
  See our [GPU guide](5000653025) for more details.

# Specifying Sites / Avoiding Sites

To run your jobs on a list of specific execution sites, or avoid a set of 
sites, use the `+DESIRED_Sites`/`+UNDESIRED_Sites` attributes in your job
submit file. **These attributes should only be used as a last resort.** For
example, it is much better to use feature attributes (see above) to make
your job go to nodes matching what you really require, than to broadly
allow/block whole sites. We encourage you to contact the facilitation team before taking this action, to make sure it is right for you. 

To avoid certain sites, first find the site names. You can find a 
current list by querying the pool:

    condor_status -af GLIDEIN_Site | sort -u

In your submit file, add a comma separated list of sites like:

    +UNDESIRED_Sites = "ISI,SU-ITS"

Those sites will now be exluded from the set of sites your job can
run at.

Similarly, you can use `+DESIRED_Sites` to list a subset of sites
you want to target. For example, to run your jobs at the SU-ITS site,
and only at that site, use:


    +DESIRED_Sites = "ISI,SU-ITS"

Note that you should only specify one of `+DESIRED_Sites`/`+UNDESIRED_Sites`
in the submit file. Using both at the same time will prevent the job from
running.

