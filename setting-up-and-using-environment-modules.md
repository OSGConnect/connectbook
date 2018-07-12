
[title]: - "Accessing Software using Distributed Environment Modules"
 

# Accessing Software using Distributed Environment Modules
## Introduction

This page covers use of the module command in the OSG computing environment.  

Environment modules have historically been used in HPC environments to provide users with an easy way to access 
different versions of software and to access various libraries, compilers, and software 
(c.f. the [wikipedia reference](https://en.wikipedia.org/wiki/Environment_Modules_%28software%29)).  OSG has 
implemented a version based on Lmod to provide the typical module commands on any site in the OSG.  You can test 
workflows on the OSG Connect login node and then submit the same workflow without any changes.

## Using modules on OSG Connect

Use `module avail` to see available software applications and libraries:

	$ module avail
	
	ANTS/1.9.4                  gcc/4.6.4                  pbsuite/14.9.9
	ANTS/2.1.0           (D)    gcc/4.8.1                  pcre/8.35
	Julia/0.6.0                 gcc/4.9.2           (D)    pegasus/4.4.2-image_tools
	MUMmer3.23/3.23             gcc/4.9.3                  pegasus/4.5.3
	OpenBUGS/3.2.3              gcc/6.2.0                  pegasus/4.6.0dev
	OpenBUGS-3.2.3/3.2.3        gd/2.1.1                   pegasus/4.6.0cvs
	R/3.1.1              (D)    gdal/2.0.0                 pegasus/4.6.0
	R/3.2.0                     geant4/9.4p02              pegasus/4.6.1dev
	R/3.2.1                     geant4/10.02               pegasus/4.6.1
	R/3.2.2                     geant4/10.3p01      (D)    pegasus/4.7.0
	R/3.3.1                     geos/3.4.2                 pegasus/4.7.1
	R/3.3.2                     gfal/7.20                  pegasus/4.7.3
	RAxML/8.2.9                 git/1.9.0                  pegasus/4.7.4             (D)
	SeqGen/1.3.3                glpk/4.54                  phenix/1.10
	Shelx/2015                  gmp/6.0.0                  poppler/0.24.1            (D)
	SitePackage                 gnome_libs/1.0             poppler/0.32
	SparseSuite/4.2.1           gnuplot/4.6.5              povray/3.7
	ViennaRNA/2.2               graphviz/2.38.0            proj/4.9.1
	abyss/2.0.2                 grass/6.4.4                proot/2014
	ant/1.9.4                   gromacs/4.6.5              protobuf/2.5
	apr/1.5.1                   gromacs/5.0.0       (D)    psi4/0.3.74
	aprutil/1.5.3               gromacs/5.0.5.cuda         python/2.7                (D)
	arc-lite/2015               gromacs/5.0.5              python/3.4
	atlas/3.10.1                gromacs/5.1.2-cuda         python/3.5.2
	atlas/3.10.2         (D)    gsl/1.16                   qhull/2012.1
	autodock/4.2.6              gsl/2.3             (D)    root/5.34-32-py34
	bedtools/2.21               hdf5/1.8.9                 root/5.34-32
	binutils/2.26               hdf5/1.8.12-cxx11          root/6.06-02-py34         (D)
	blasr/1.3.1                 hdf5/1.8.12                rosetta/2015
	blast                       hdf5/1.8.13-cxx11          rosetta/2016-02
	blender                     hdf5/1.8.13         (D)    rosetta/2016-32           (D)
	boost/1.50.0                healpix/3.30               ruby/2.1
	boost/1.56                  hisat2/2.0.3-beta          rucio/1.6.6
	boost/1.57.0                hmmer/3.1                  sac/10.1.6a
	boost/1.62.0-cxx11          igraph/0.7.1               saga/2.2.0
	boost/1.62.0         (D)    imagemagick/7.0.2          samtools/0.1.17
	bowtie/2.2.3                intelMKL/11.3.0.109        samtools/1.3.1            (D)
	bowtie/2.2.9         (D)    ipopt/3.12.6               sca/10.1.6a
	bwa/0.7.12                  jasper/1.900.1             scons/2.3.4
	bwa/2014             (D)    java/7u71                  sdpa/7.3.8
	bzip2/1.0.6                 java/8u25           (D)    serf/1.37
	canopy/1.4.1                jpeg/6b                    settarg/5.6.2
	casino/2.13.211             jpeg/9a             (D)    shelx/2015
	cblosc/1.7.1                julia/0.6.0                shrimp/2.2.3
	ccp4/2015                   lammps/2.0                 siesta/3.2
	cctools/4.4.2               lammps/15May15      (D)    simbody/3.5.3
	cctools/5.2.3               lapack/3.5.0               snappy/1.1.3
	cctools/5.4.7               lapack/3.6.1        (D)    sqlite/3.8.11.1
	cctools/6.0.7        (D)    libXpm/3.5.10              sra/2.5.4
	cdo/1.6.4                   libgfortran/4.4.7          sra/2.8.0                 (D)
	cfitsio/3.37                libtiff/4.0.4              stashcp/2.2
	circos/0.68                 llvm/3.6                   stashcp/2.5
	clhep/2.1.0.1               llvm/3.7                   stashcp/2.6
	clhep/2.2.0.8               llvm/3.8.0          (D)    stashcp/3.0
	clhep/2.3.1.0               lmod/5.6.2                 stashcp/3.1
	clhep/2.3.1.1               madgraph/2.1.2             stashcp/3.2
	clhep/2.3.4.4        (D)    madgraph/2.2.2      (D)    stashcp/3.3
	cmake/3.0.1                 matlab/2013b               stashcp/3.4
	cmake/3.4.1                 matlab/2014a               stashcp/4.0
	cmake/3.8.0          (D)    matlab/2014b               stashcp/4.0.1
	connect-client/0.2.1        matlab/2015a               stashcp/4.1.0
	connect-client/0.3.0        matlab/2015b               stashcp/4.1.1
	connect-client/0.4.0        matlab/2016b        (D)    stashcp/4.2.0
	connect-client/0.5.3 (D)    mercurial/1.9.1            stashcp/4.2.1
	cp2k/2.5.1                  mixmodlib/3.1              stashcp/4.3.0
	cpan/perl-5.10              mono/4.2.1                 stashcp/4.3.1             (D)
	cufflinks/2.2.1             mothur/1.39.0              stringtie/1.1.2
	curl/7.37.1                 mpc/1.0.3                  stringtie/1.2.2           (D)
	dakota/6.4.0                mpfr/3.1.3                 subversion/1.8.10
	dmtcp/2.5.0                 mplayer/1.1                sundials/2.5
	ectools                     mrbayes/3.2.2              swift/0.94.1
	eemt/0.1                    muscle/3.8.31              swift/0.96.2              (D)
	elastix/2015                mysql/5.1.73               tassel/5.0
	entropy/2017.03.16          namd/2.9                   tcl/8.6.2
	espresso/5.1                namd/2.10.cuda             tcsh/6.20.00
	espresso/5.2         (D)    namd/2.10           (D)    tophat/2.0.13
	ete2/2.3.8                  nco/4.3.0                  tophat/2.1.1              (D)
	expat/2.1.0                 netcdf/4.2.0               transabyss/1.5.5
	ffmpeg/0.10.15              ngsTools/2017.03.16        tutorial/1.0
	ffmpeg/2.5.2         (D)    octave/3.8.1               uclust/2.22
	fftw/3.3.4-gromacs          openbabel/2.3.2            udunits/2.2.17
	fftw/3.3.4           (D)    opencv/2.4.10              unixodbc/2.3.2
	fiji/2.0                    opensees/6482              valgrind/3.10
	fpc/2.6.4                   opensim/3.3                vmd/1.9.1
	freesurfer/5.1.0            orca/3.0.3                 wget/1.15
	freesurfer/5.3.0            papi/5.3.2                 wxgtk/3.0.2
	freesurfer/6.0.0     (D)    pari/2.7.5                 xrootd/4.1.1
	freetype/2.5.5              pax/evan-testing           xrootd/4.2.1              (D)
	fsl/5.0.8                   pax/4.5.0                  xz/5.2.2
	gamess/2013                 pax/4.6.1                  zlib/1.2.8
	gate/7.2                    pax/4.9.1
	gcc/4.6.2                   pax/4.11.0          (D)

	Where:
	(D):  Default Module


Note that currently, most of our login and compute nodes are based on RHEL 6. RHEL 7 hosts
can be loaded with Singularity and the software catalog availalbe for that operating system
is not as extensive, but growing:


	bowtie/2.2.9       gsl/2.3           (D)    mpfr/3.1.3             sra/2.5.4
	cmake/3.8.0        java/8u25                pegasus/4.7.3          sra/2.8.0       (D)
	cufflinks/2.2.1    lapack/3.6.1             pegasus/4.7.4   (D)    stashcp/3.1
	gcc/4.9.2          libgfortran/4.4.7        python/2.6.9           stringtie/1.2.2
	gmp/6.0.0          mixmodlib/3.1            samtools/1.3.1         tophat/2.1.1
	gsl/1.16           mpc/1.0.3                sqlite/3.8.11.1


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
