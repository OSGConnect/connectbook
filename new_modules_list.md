
[title]: - "Accessing Software using Distributed Environment Modules"
 

# Accessing Software using Distributed Environment Modules
## Introduction

This page covers use of the modules on RHEL6 and RHEL7 compatible compute nodes in the OSG computing environment.  

Environment modules have historically been used in HPC environments to provide users with an easy way to access 
different versions of software and to access various libraries, compilers, and software 
(c.f. the [wikipedia reference](https://en.wikipedia.org/wiki/Environment_Modules_%28software%29)).  OSG has 
expanded it's existing the modules system to support both RHEL6 and RHEL7 compatible compute nodes.  The new system 
not only provides newer versions of software but provides the same modules across RHEL6 and RHEL7 systems.


## Using modules on OSG Connect

Use `module avail` to see available software applications and libraries:

	$ module avail
	
	------------------ /cvmfs/connect.opensciencegrid.org/modules/el7/spack/share/spack/lmod/linux-rhel7-x86_64/Core ---------------------
   autoconf/2.69-s                                     jdk/8u141-b15-x                    openssl/1.0.2n-c
   automake/1.15.1-f                                   kbproto/1.0.7-x                    pango/1.41.0-python-2.7.14-j
   bedtools2/2.27.1-s                                  libbsd/0.8.6-5                     pcre/8.41-x
   binutils/2.29.1-y                                   libcerf/1.3-p                      perl/5.24.1-y
   bison/3.0.4-d                                       libedit/3.1-20170329-n             pixman/0.34.0-q
   boost/1.66.0-i                                      libffi/3.2.1-4                     pkgconf/1.4.0-w
   bowtie/1.2-2                                        libgd/2.2.4-f                      proj/4.9.2-h
   bowtie2/2.3.4.1-python-2.7.14-4                     libiconv/1.15-v                    py-lit/0.5.0-python-2.7.14-s
   bwa/0.7.17-z                                        libint/1.1.6-h                     py-numpy/1.13.3-python-2.7.14-j
   bzip2/1.0.6-q                                       libjpeg-turbo/1.5.3-w              py-numpy/1.13.3-python-3.6.5-4         (D)
   cairo/1.14.12-python-2.7.14-g                       libpciaccess/0.13.5-q              py-scikit-learn/0.18.1-python-2.7.14-2
   cfitsio/3.420-w                                     libpng/1.6.34-4                    py-scikit-learn/0.18.1-python-3.6.5-b  (D)
   cmake/3.11.1-j                                      libpthread-stubs/0.4-y             py-scipy/1.0.0-python-2.7.14-r
   cufflinks/2.2.1-6                                   libsigsegv/2.11-3                  py-scipy/1.0.0-python-3.6.5-u          (D)
   curl/7.59.0-m                                       libszip/2.1.1-u                    py-setuptools/39.0.1-python-2.7.14-y
   eccodes/2.5.0-i                                     libtiff/4.0.8-t                    py-setuptools/39.0.1-python-3.6.5-p    (D)
   expat/2.2.2-j                                       libtool/2.4.6-h                    python/2.7.14-k
   ffmpeg/3.2.4-n                                      libuuid/1.0.3-n                    python/3.6.5-5                         (D)
   flex/2.6.4-u                                        libx11/1.6.5-5                     r/3.4.3-python-2.7.14-c
   font-util/1.3.1-f                                   libxau/1.0.8-3                     readline/7.0-j
   fontconfig/2.12.3-l                                 libxc/3.0.0-n                      sparsehash/2.0.3-n
   freetype/2.7.1-w                                    libxcb/1.13-v                      sqlite/3.22.0-s
   gcc/4.9.2                                           libxdmcp/1.1.2-l                   stashcache/5.0.0-5
   gcc/6.2.0                                    (D)    libxml2/2.9.4-7                    swig/3.0.12-6
   gdbm/1.14.1-7                                       libxpm/3.5.12-z                    tar/1.29-y
   gettext/0.19.8.1-b                                  libxsmm/1.9-f                      tcl/8.6.8-5
   glib/2.56.0-python-2.7.14-g                         llvm/6.0.0-python-2.7.14-q         tk/8.6.8-u
   gmp/6.1.2-5                                         m4/1.4.18-w                        udunits2/2.2.24-t
   gnuplot/5.2.0-python-2.7.14-g                       mpc/1.1.0-e                        unzip/6.0-f
   gobject-introspection/1.49.2-python-2.7.14-6        mpfr/3.1.5-x                       util-macros/1.19.1-m
   gperf/3.0.4-e                                       mpfr/4.0.1-i                (D)    xcb-proto/1.13-2
   harfbuzz/1.4.6-python-2.7.14-j                      mummer/3.23-python-2.7.14-h        xextproto/7.3.0-k
   help2man/1.47.4-p                                   nasm/2.13.03-d                     xproto/7.0.31-w
   hwloc/1.11.9-5                                      ncurses/6.0-3                      xrootd/4.6.0-3
   icu4c/60.1-6                                        numactl/2.0.11-d                   xtrans/1.3.5-u
   inputproto/2.3.2-g                                  octave/4.2.1-p                     xz/5.2.3-y
   intel-tbb/2018.2-w                                  openblas/0.2.20-j                  yasm/1.3.0-g
   isl/0.19-o                                          openjpeg/2.1.2-f                   zlib/1.2.11-v
   
	Where:
	(D):  Default Module

In addition, additional software is available 

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
	
	---- /cvmfs/oasis.opensciencegrid.org/osg/modules/modulefiles/Core -----
   	atlas      fftw/fftw-3.3.4-gromacs    lapack              lmod/5.6.2 (D)    
   	blast      gromacs/4.6.5              lmod/SiteHook       namd/2.9          
   	blender    jpeg                       lmod/SitePackage    python/2.7 (D)
	python/3.4 settarg/5.6.2
   	
  	Where:
   	(D):  Default Module

	Use "module spider" to find all possible modules.
	Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".

	$ module load python/2.7
	$ module avail

	--- /cvmfs/oasis.opensciencegrid.org/osg/modules/modulefiles/python/2.7.7 ---
   	all-pkgs

	---- /cvmfs/oasis.opensciencegrid.org/osg/modules/modulefiles/Core -----
   	atlas      fftw/fftw-3.3.4-gromacs    lapack              lmod/5.6.2 (D)    
   	blast      gromacs/4.6.5              lmod/SiteHook       namd/2.9          
   	blender    jpeg                       lmod/SitePackage    python/2.7 (D)
	python/3.4 settarg/5.6.2
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

## Using environment modules in jobs

Not all resources available through OSG Connect support distributed environment modules.  In order to make
sure that the jobs you submit run on resources that do support distributed environment modules, you will need to add
the following condition to the requirements in your HTCondor job submission file. E.g. :

	Requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 6") && (OpSys == "LINUX")
	
	
or 

	Requirements = [Other requirements ] && (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 6") && (OpSys == "LINUX")

if you already have other requirements specified and need to append the OASIS requirement.

Jobs submitted with the HTCondor requirement given above will automatically have the module system set up for them when run.  So the only change needed to job scripts would be to add `module load` commands to load the appropriate modules.

## Available Software

A list of currently installed software is available [here](http://support.opensciencegrid.org/support/solutions/articles/5000634397-software-modules-catalog). If your software is not already listed, you can [request it][request].

## Using modules outside of OSG Connect

In order to use distributed environment modules outside of OSG Connect, you'll need to load the modules code manually from OASIS.  You can do this by running
	
	$ source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/SHELL 
	
where SHELL is the shell that you are using (this is usually bash).  


[request]: 5000649173
