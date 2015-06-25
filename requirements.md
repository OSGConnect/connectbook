[title]: - "Steer your jobs with HTCondor job requirements"

By default, your HTCondor job on OSG will match any available compute slot. This
is fine for very generic jobs, but many users have one or more requirements on
the environment the job will work in. You can limit where your jobs go by
defining requirements in your job submit file. Requirements is an expression, so
you can use logical operators to combine multiple requirements. For example, the
following will run the jobs only on RHEL 6 machines with more than 10 GBs of
disk space:

	requirements = OSGVO_OS_STRING == "RHEL 6" && Disk > 10000000

 
Another common requirement is to land on a node which has CVMFS. We recommend
that you use the revision attribute. The current revision can be found by
running:

	/usr/bin/attr -g revision /cvmfs/oasis.opensciencegrid.org


Then the requirements would be:

	requirements = CVMFS_oasis_opensciencegrid_org_REVISION >= 3983
 

There are many attributes that you can use. To see the attributes for all the
machines in the current pool. Note that this is a long list:

	condor_status -pool osg-flock.grid.iu.edu -long
