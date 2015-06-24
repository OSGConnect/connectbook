
[title]: - "Accessing Software using Distributed Enivonrment Modules"
 

Introduction
------------

This page covers use of the module command in the OSG computing environment.  

Environment modules have historically been used in HPC environments to provide users with an easy way to access different versions of software and to access various libraries, compilers, and software (c.f. the wikipedia reference).  OSG has implemented a version based on Lmod to provide the typical module commands on any site in the OSG.  You can test workflows on the OSG Connect login node and then submit the same workflow without any changes.
Using modules on OSG Connect

Use `module avail` to see available software applications and libraries:

	$ module avail
	
	------------------ /cvmfs/oasis.opensciencegrid.org/osg/modules/modulefiles/Core ------------------
   	MUMmer3.23/3.23           gcc/4.6.4                pcre/8.35
   	OpenBUGS/3.2.3     (D)    gcc/4.9.2         (D)    pegasus/4.4.2-image_tools
   	R/3.1.1                   geos/3.4.2               poppler/0.24.1
   	SitePackage               git/1.9.0                povray/3.7
   	SparseSuite/4.2.1         glpk/4.54                proot/2014
   	ant/1.9.4                 gnome_libs/1.0           protobuf/2.5
   	apr/1.5.1                 gnuplot/4.6.5            python/2.7                (D)
   	apr-util/1.5.3            graphviz/2.38.0          python/3.4
   	aprutil/1.5.3             gromacs/4.6.5            qhull/2012.1
   	atlas                     gromacs/5.0.0     (D)    root/5.34-21
   	autodock/4.2.6            hdf5/1.8.9               ruby/2.1
   	bedtools/2.21             hdf5/1.8.12              samtools/0.1.17
   	blasr/1.3.1               hdf5/1.8.13       (D)    scons/2.3.4
   	blast                     hmmer/3.1                sdpa/7.3.8
   	blender                   java/7u71                serf/1.37
   	boost/1.50.0              java/8u25         (D)    settarg/5.6.2
   	boost/1.56                jpeg                     shrimp/2.2.3
   	boost/1.57.0       (D)    lammps/2.0               siesta/3.2
   	bowtie/2.2.3              lapack                   stashcp/1.0.0
   	bwa/2014                  libgfortran/4.4.7        stashcp/2.0.3
   	canopy/1.4.1              lmod/5.6.2               stashcp/2.0.6
   	casino/2.13.211           madgraph/2.1.2           stashcp/2.0.7
   	cdo/1.6.4                 madgraph/2.2.2    (D)    stashcp/2.0.8
   	cmake/3.0.1               matlab/2013b             stashcp/2.1
   	cp2k/2.5.1                matlab/2014a      (D)    stashcp/2.2               (D)
   	cufflinks/2.2.1           mercurial/1.9.1          subversion/1.8.10
   	curl/7.37.1               mplayer/1.1              sundials/2.5
   	ectools                   mrbayes/3.2.2            swift/0.94.1
   	espresso/5.1              muscle/3.8.31            tcl/8.6.2
   	expat/2.1.0               namd/2.9                 tophat/2.0.13
   	ffmpeg/0.10.15            nco/4.3.0                uclust/2.22
   	ffmpeg/2.5.2       (D)    netcdf/4.2.0             udunits/2.2.17
   	fftw/3.3.4-gromacs        octave/3.8.1             valgrind/3.10
   	fftw/3.3.4         (D)    openbabel/2.3.2          vmd/1.9.1
   	fpc/2.6.4                 opencv/2.4.10            wget/1.15
   	gamess/2013               papi/5.3.2               xrootd/4.1.1
   	gcc/4.6.2                 pbsuite/14.9.9
  	Where:
   	(D):  Default Module
	Use "module spider" to find all possible modules.
	Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".

In order to load a module, you should run `module load [modulename]`.

For example:

	$ module load python/2.7

Some modules require other modules to be loaded. If that occurs then you'll get an error message indicating this:

	$ module load all-pkgs
	
	Lmod has detected the following error: Cannot load module "all-pkgs" without these modules loaded:
  	atlas, lapack


	While processing the following module(s):

	Module fullname  Module Filename
	---------------  ---------------
	all-pkgs         /cvmfs/oasis.opensciencegrid.org/osg/modules/modulefiles/python/2.7.7/all-pkgs.lua

In addition, some modules such as the all-pkgs for python won't be available until the relevant packages are loaded.

For example:

	$ module avail
	
	--------------------------- /cvmfs/oasis.opensciencegrid.org/osg/modules/modulefiles/Core ----------------------------
   	atlas      fftw/fftw-3.3.4-gromacs    lapack              lmod/5.6.2 (D)    python/3.4
   	blast      gromacs/4.6.5              lmod/SiteHook       namd/2.9          settarg/5.6.2
   	blender    jpeg                       lmod/SitePackage    python/2.7 (D)

  	Where:
   	(D):  Default Module

	Use "module spider" to find all possible modules.
	Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".

	$ module load python/2.7
	$ module avail

	----------------------- /cvmfs/oasis.opensciencegrid.org/osg/modules/modulefiles/python/2.7.7 ------------------------
   	all-pkgs

	--------------------------- /cvmfs/oasis.opensciencegrid.org/osg/modules/modulefiles/Core ----------------------------
   	atlas      fftw/fftw-3.3.4-gromacs    lapack              lmod/5.6.2 (D)    python/3.4
   	blast      gromacs/4.6.5              lmod/SiteHook       namd/2.9          settarg/5.6.2
   	blender    jpeg                       lmod/SitePackage    python/2.7 (D)

  	Where:
   	(D):  Default Module

	Use "module spider" to find all possible modules.
	Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".

	To unload a package and remove it from the environment, use `module unload [modulename]`.

For example:

	$ module unload python/2.7

To see currently loaded modules, use `module list`.

For example:

	$ module list
	Currently Loaded Modules:
  	1) python/2.7

Finally, `module help` will give you more detailed information.

Submit file changes
-------------------

Not all resources available through OSG Connect support OASIS and distributed environment modules.  In order to make
sure that the jobs you submit run on resources that do support distributed environment modules, you will need to add
the following condition to the requirements in your condor  job submission file.

(HAS_CVMFS_oasis_opensciencegrid_org =?= TRUE)

Available Software
------------------

A list of currently installed software is available here. 

 
