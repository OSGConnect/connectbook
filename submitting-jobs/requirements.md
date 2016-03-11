[title]: - "Steer your jobs with HTCondor job requirements"

By default, your HTCondor job on OSG will match any available compute slot. This
is fine for very generic jobs, but many users have one or more requirements on
the environment the job will work in. You can limit where your jobs go by
defining requirements in your job submit file. Requirements is an expression, so
you can use logical operators to combine multiple requirements. The requirment
expression can be used in combination with a few basic attributes to specify
memory and disk requirements. For example, the following will run the jobs only
on 64 bit RHEL 6 machines, with access to the "modules" command, and with more
than 10 GBs of disk space:

    requirements = OSGVO_OS_STRING == "RHEL 6" && Arch == "X86_64" && HAS_MODULES == True
    request_cpus = 1
    request_memory = 2 GB
    request_disk = 10 GB

We will soon see more RHEL 7 based compute nodes on OSG. If you have code which
can run on either RHEL 6 or 7, you can use "or":

    requirements = (OSGVO_OS_STRING == "RHEL 6" || OSGVO_OS_STRING == "RHEL 7") && Arch == "X86_64" && HAS_MODULES == True
    request_cpus = 1
    request_memory = 2 GB
    request_disk = 10 GB
 
Another common requirement is to land on a node which has CVMFS. We recommend
that you use the revision attribute. The current revision can be found by
running:

	/usr/bin/attr -g revision /cvmfs/oasis.opensciencegrid.org

Then the requirements would be:

	requirements = CVMFS_oasis_opensciencegrid_org_REVISION >= 3983

There are many attributes that you can use. Below is a list of common
attributes. You can check values for an attribute with:

	condor_status -pool osg-flock.grid.iu.edu -af {ATTR_NAME}


- **HAS_MODULES** - Boolean specifying if you will be able to use
  _module load ..._ or not.
- **OSGVO_OS_NAME** - the name of the operating system of the compute node. 
  The most common name is _RHEL_
- **OSGVO_OS_VERSION** - Version of the operating system
- **OSGVO_OS_STRING** - Combined OS name and version. Common values are
  _RHEL 6_ and _RHEL 7_. Please see the requirements string above on the
  recommended setup.
- **OSGVO_CPU_MODEL** - The CPU model identifier string as presented in
  /proc/cpuinfo
- **CVMFS_oasis_opensciencegrid_org_REVISION** - This attribute is set
  a the following /cvmfs file systems. The revision on the submit node
  can be determined by running _attr -g revision /cvmfs/oasis.opensciencegrid.org/_
  Note that dots in the path is replaced with underscores in the
  attribute name.
  - oasis.opensciencegrid.org
  - stash.osgstorage.org
  - icecube.opensciencegrid.org
  - atlas.cern.ch
  - cms.cern.ch
  - ams.cern.ch
- **HAS_SQUID** - Boolean specifying if the _OSG_SQUID_LOCATION_ environment
  variable is set
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


