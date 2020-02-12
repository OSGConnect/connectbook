[title]: - "Steer Your Jobs with HTCondor Job Requirements"

By default, your jobs will match any available spot in the OSG. This is fine
for very generic jobs, however in some cases a job may have one or more system
requirements in order to complete successfully. For instance, your job may need to run
on a node with a specific operating system.

HTCondor provides several options for "steering" your jobs to appropriate
nodes and system environments. The `request_cpus`, `request_memory`, and `request_disk`
submit file attributes should be used to specify the hardware needs of your jobs.
Please see our guides [Multicore Jobs](https://support.opensciencegrid.org/support/solutions/articles/5000653862-multicore-jobs) and [Large Memory Jobs](https://support.opensciencegrid.org/support/solutions/articles/5000652304-large-memory-jobs)
for more details. HTCondor also provides a `requirements` attribute and feature-specific
attributes that can be added to your submit files to target specific environments in
which to run your jobs. This guide will focus on these additional environment-specific
submit file attributes.   

### Requirements

The `requirements` attribute is formatted as an expression, so you can use logical
operators to combine multiple requirements where `&&` is used for AND and
`||` used for OR. For example, the following `requirements` statement will direct
jobs only to 64 bit RHEL 7 nodes, with access to the "modules" command.

    requirements = OSGVO_OS_STRING == "RHEL 7" && Arch == "X86_64" && HAS_MODULES == True

Alternatively, if you have code which can run on either RHEL 6 or 7, you can use OR:

    requirements = (OSGVO_OS_STRING == "RHEL 6" || OSGVO_OS_STRING == "RHEL 7") && Arch == "X86_64" && HAS_MODULES == True

Note that parentheses placement is important for controling how the logical operations
are interpreted by HTCondor.
 
Another common requirement is to land on a node which has CVMFS.
Then the `requirements` would be:

	requirements = CVMFS_oasis_opensciencegrid_org_REVISION >= 3983

As shown in the above example, when specifying a CVMFS requirement, we recommend
that you use the REVISION attribute. To determine which REVISION to specify
you can run the following command while connected to your login node:

	$ /usr/bin/attr -g revision /cvmfs/oasis.opensciencegrid.org

### Additional Feature-Specific Attributes
There are many attributes that you can use with `requirements`. To see what values
you can specify for a given attribute you can run the following command while
connected to your login node:

	$ condor_status -pool flock.opensciencegrid.org -af {ATTR_NAME} | sort -u
	
For example, to see what values you can specify for the OSGVO_OS_VERSION attribute run:
	
	$ condor_status -pool flock.opensciencegrid.org -af OSGVO_OS_VERSION | sort -u
	6
	7
	8
	undefined

This means that we can specify an OS version of `6`, `7`, `8`. Alternatively
you will find many attrubites will take the boolean values `true` or `false`
as shown in the HAS_MODULES example above.

Below is a list of common attributes that you can include in your submit file `requirements` statement. 

- **HAS_SINGULARITY** - Boolean specifying the need to use Singularity containers in your job.

- **HAS_MODULES** - Boolean specifying the need to use modules in your job.
  _module load ..._ or not.

- **OSGVO_OS_NAME** - The name of the operating system of the compute node. 
  The most common name is _RHEL_

- **OSGVO_OS_VERSION** - Version of the operating system

- **OSGVO_OS_STRING** - Combined OS name and version. Common values are
  _RHEL 6_ and _RHEL 7_. Please see the requirements string above on the
  recommended setup.

- **OSGVO_CPU_MODEL** - The CPU model identifier string as presented in
  /proc/cpuinfo
- **CVMFS_oasis_opensciencegrid_org_REVISION** - Attribute specifying
  the need to access specific oasis /cvmfs file system repositories. See the
  example above for determining the appropriate REVISION number when using
  this `requirements` attribute.

- **CUDACapability** - For GPU jobs, specifies the CUDA compute capability.

- **HAS_SQUID** - Boolean specifying the need for access to SQUID fileshare,
  set to `true` if your job has the _OSG_SQUID_LOCATION_ environment
  variable set

- **HAS_TCSH** - Boolean specifying if the node has /bin/tcsh

- **HAS_XRDCP** - Boolean specifying if the node has _xrdcp_ in the default path

- **HAS_TIMEOUT** - Boolean specifying if the node has _timeout_ in the default path

- **HAS_R** - Boolean specifying if the node has R

- **HAS_NUMPY** - Boolean specifying if the node has Python Numpy

- **HAS_FILE_foo** - Sometimes it is easier to match against system library
  files rather than higher level tool names. Note that dots and slashes in the
  paths are replaced with underscores in the attribute names. For example:
  **HAS_FILE_lib64_libgcc_s_so_1** advertises if /lib64/libgcc_s.so.1 exists.
  Currently the following files are advertised: 
    - /lib64/libgcc_s.so.1
    - /lib64/libglib-2.0.so.0
    - /usr/lib64/libgfortran.so.3
    - /usr/lib64/libglib-2.0.so
    - /usr/lib64/libgslcblas.so.0
    - /usr/lib64/libgsl.so.0
    - /usr/lib64/libstdc++.so.6
    - /usr/lib64/libgtk-x11-2.0.so.0
    - /usr/lib64/libXt.so.6 


