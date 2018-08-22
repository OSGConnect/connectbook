
[title]: - "Accessing Software using Distributed Environment Modules 2.0"
 

# Accessing Software using Distributed Environment Modules 2.0
## Introduction

This page covers use of the modules on RHEL6 and RHEL7 compatible compute nodes in the OSG computing environment.  

Environment modules have historically been used in HPC environments to provide users with an easy way to access 
different versions of software and to access various libraries, compilers, and software 
(c.f. the [wikipedia reference](https://en.wikipedia.org/wiki/Environment_Modules_%28software%29)).  OSG has 
expanded it's existing the modules system to support both RHEL6 and RHEL7 compatible compute nodes.  The new system 
not only provides newer versions of software but provides the same modules across RHEL6 and RHEL7 systems.


## Using modules on OSG Connect

Use `module avail` to see available software applications and libraries:

```
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
```

In addition, additional software is available once the `gcc/6.2.0` module is loaded. 

In order to load a module, you should run `module load [modulename]`.

For example:

	$ module load python/2.7.14-k

To unload a package and remove it from the environment, use `module unload [modulename]`.

For example:

	$ module unload python/2.7.14-k

To see currently loaded modules, use `module list`.

For example:

	$ module list
	Currently Loaded Modules:
  	1) python/2.7.14-k

Finally, `module help` will give you more detailed information.

## Using environment modules in jobs

Not all resources available through OSG Connect support distributed environment modules.  In order to make
sure that the jobs you submit run on resources that do support distributed environment modules, you will need to add
the following condition to the requirements in your HTCondor job submission file. We recommend the following requirements:

	Requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 7") && (OpSys == "LINUX")
	
	
or 

	Requirements = [Other requirements ] && (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 7") && (OpSys == "LINUX")

if you already have other requirements specified and need to append the OASIS requirement.

Jobs submitted with the HTCondor requirement given above will automatically have the module system set up for them when run.  So the only change needed to job scripts would be to add `module load` commands to load the appropriate modules.  If you are willing to run into potential RHEL6 vs RHEL7 incompatibilities in order to gain access to the maximum amount of resources, you can use the following requirements:

	Requirements = (HAS_MODULES =?= true) && (OpSys == "LINUX")
	
	
or 

	Requirements = [Other requirements ] && (HAS_MODULES =?= true) && (OpSys == "LINUX")

This set of requirements will run your jobs on RHEL6 and RHEL7 nodes so your job may run into problems because of the differences between the two distributions.

## Available Software

There are two sets of software available under this system.  A set of software packages that are available by default and a set of packages that are available once the `gcc/6.2.0` module has been loaded.

### Software available by default

```
   autoconf/2.69-s                                     perl/5.24.1-y
   automake/1.15.1-f                                   pixman/0.34.0-q
   bedtools2/2.27.1-s                                  pkgconf/1.4.0-w
   binutils/2.29.1-y                                   proj/4.9.2-h
   bison/3.0.4-d                                       py-asn1crypto/0.22.0-python-2.7.14-s
   boost/1.66.0-i                                      py-asn1crypto/0.22.0-python-3.6.5-6    (D)
   bowtie/1.2-2                                        py-bottleneck/1.0.0-python-2.7.14-a
   bowtie2/2.3.4.1-python-2.7.14-4                     py-bottleneck/1.0.0-python-3.6.5-2     (D)
   bwa/0.7.17-z                                        py-cffi/1.10.0-python-2.7.14-y
   bzip2/1.0.6-q                                       py-cffi/1.10.0-python-3.6.5-u          (D)
   cairo/1.14.12-python-2.7.14-g                       py-cryptography/1.8.1-python-2.7.14-c
   cfitsio/3.420-w                                     py-cryptography/1.8.1-python-3.6.5-x   (D)
   cmake/3.11.1-j                                      py-cycler/0.10.0-python-2.7.14-i
   cufflinks/2.2.1-6                                   py-cycler/0.10.0-python-3.6.5-5        (D)
   curl/7.59.0-m                                       py-cython/0.28.1-python-2.7.14-l
   eccodes/2.5.0-i                                     py-cython/0.28.1-python-3.6.5-f        (D)
   expat/2.2.2-j                                       py-dateutil/2.5.2-python-2.7.14-o
   ffmpeg/3.2.4-n                                      py-dateutil/2.5.2-python-3.6.5-g       (D)
   flex/2.6.4-u                                        py-enum34/1.1.6-python-2.7.14-r
   font-util/1.3.1-f                                   py-functools32/3.2.3-2-python-2.7.14-l
   fontconfig/2.12.3-l                                 py-h5py/2.7.1-python-2.7.14-r
   freetype/2.7.1-w                                    py-h5py/2.7.1-python-3.6.5-s           (D)
   gcc/4.9.2-n                                         py-idna/2.5-python-2.7.14-f
   gcc/4.9.2                                           py-idna/2.5-python-3.6.5-j             (D)
   gcc/6.2.0                                          py-ipaddress/1.0.18-python-2.7.14-b
   gcc/6.2.0-l                                         py-kiwisolver/1.0.1-python-2.7.14-i
   gcc/6.2.0                                    (D)    py-kiwisolver/1.0.1-python-3.6.5-5     (D)
   gdbm/1.14.1-7                                       py-lit/0.5.0-python-2.7.14-s
   gettext/0.19.8.1-b                                  py-matplotlib/2.2.2-python-2.7.14-3
   glib/2.56.0-python-2.7.14-g                         py-matplotlib/2.2.2-python-3.6.5-5     (D)
   gmp/6.1.2-5                                         py-nose/1.3.7-python-2.7.14-e
   gnuplot/5.2.0-python-2.7.14-g                       py-nose/1.3.7-python-3.6.5-b           (D)
   gobject-introspection/1.49.2-python-2.7.14-6        py-numexpr/2.6.1-python-2.7.14-5
   gperf/3.0.4-e                                       py-numexpr/2.6.1-python-3.6.5-v        (D)
   harfbuzz/1.4.6-python-2.7.14-j                      py-numpy/1.13.3-python-2.7.14-j
   hdf5/1.10.1-i                                       py-numpy/1.13.3-python-3.6.5-4         (D)
   help2man/1.47.4-p                                   py-pandas/0.21.1-python-2.7.14-2
   hwloc/1.11.9-5                                      py-pandas/0.21.1-python-3.6.5-j        (D)
   icu4c/60.1-6                                        py-paramiko/2.1.2-python-2.7.14-a
   inputproto/2.3.2-g                                  py-paramiko/2.1.2-python-3.6.5-t       (D)
   intel-tbb/2018.2-w                                  py-pillow/3.2.0-python-2.7.14-d
   isl/0.19-o                                          py-pillow/3.2.0-python-3.6.5-t         (D)
   jdk/8u141-b15-x                                     py-pkgconfig/1.2.2-python-2.7.14-v
   kbproto/1.0.7-x                                     py-pkgconfig/1.2.2-python-3.6.5-x      (D)
   libbsd/0.8.6-5                                      py-pyasn1/0.2.3-python-2.7.14-q
   libcerf/1.3-p                                       py-pyasn1/0.2.3-python-3.6.5-e         (D)
   libedit/3.1-20170329-n                              py-pycparser/2.17-python-2.7.14-w
   libffi/3.2.1-4                                      py-pycparser/2.17-python-3.6.5-v       (D)
   libgd/2.2.4-f                                       py-pyparsing/2.2.0-python-2.7.14-x
   libiconv/1.15-v                                     py-pyparsing/2.2.0-python-3.6.5-2      (D)
   libint/1.1.6-h                                      py-pytz/2017.2-python-2.7.14-f
   libjpeg-turbo/1.5.3-w                               py-pytz/2017.2-python-3.6.5-z          (D)
   libpciaccess/0.13.5-q                               py-scikit-learn/0.18.1-python-2.7.14-2
   libpng/1.6.34-4                                     py-scikit-learn/0.18.1-python-3.6.5-b  (D)
   libpthread-stubs/0.4-y                              py-scipy/1.0.0-python-2.7.14-r
   libsigsegv/2.11-3                                   py-scipy/1.0.0-python-3.6.5-u          (D)
   libszip/2.1.1-u                                     py-setuptools/39.0.1-python-2.7.14-y
   libtiff/4.0.8-t                                     py-setuptools/39.0.1-python-3.6.5-p    (D)
   libtool/2.4.6-h                                     py-six/1.11.0-python-2.7.14-3
   libuuid/1.0.3-n                                     py-six/1.11.0-python-3.6.5-m           (D)
   libx11/1.6.5-5                                      py-subprocess32/3.2.7-python-2.7.14-q
   libxau/1.0.8-3                                      python/2.7.14-k
   libxc/3.0.0-n                                       python/3.6.5-5                         (D)
   libxcb/1.13-v                                       qhull/2015.2-f
   libxdmcp/1.1.2-l                                    r/3.4.3-python-2.7.14-c
   libxml2/2.9.4-7                                     readline/7.0-j
   libxpm/3.5.12-z                                     sparsehash/2.0.3-n
   libxsmm/1.9-f                                       sqlite/3.22.0-s
   llvm/6.0.0-python-2.7.14-q                          stashcache/5.0.0-5
   m4/1.4.18-w                                         swig/3.0.12-6
   mpc/1.1.0-e                                         tar/1.29-y
   mpfr/3.1.5-x                                        tcl/8.6.8-5
   mpfr/4.0.1-i                                 (D)    tk/8.6.8-u
   mummer/3.23-python-2.7.14-h                         udunits2/2.2.24-t
   nasm/2.13.03-d                                      unzip/6.0-f
   ncurses/6.0-3                                       util-macros/1.19.1-m
   numactl/2.0.11-d                                    xcb-proto/1.13-2
   octave/4.2.1-p                                      xextproto/7.3.0-k
   openblas/0.2.20-j                                   xproto/7.0.31-w
   openjpeg/2.1.2-f                                    xrootd/4.6.0-3
   openmpi/3.0.1-o                                     xtrans/1.3.5-u
   openssl/1.0.2n-c                                    xz/5.2.3-y
   pango/1.41.0-python-2.7.14-j                        yasm/1.3.0-g
   pcre/8.41-x                                         zlib/1.2.11-v
```

### Software available after loading gcc/6.2.0

```
   autoconf/2.69-x                   (D)    hwloc/1.11.9-k                       nasm/2.13.03-7                       (D)
   automake/1.15.1-a                        hwloc/1.11.9-python-2.7.14-c         ncurses/6.0-e
   binutils/2.29.1-python-2.7.14-d   (D)    igraph/0.7.1-f                       numactl/2.0.11-a
   bison/3.0.4-g                     (D)    inputproto/2.3.2-t            (D)    openblas/0.2.20-3                    (D)
   boost/1.66.0-y                           intel-tbb/2018.2-m                   openmpi/3.0.1-r                      (D)
   boost/1.66.0-python-2.7.14-s      (D)    jasper/1.900.1-q                     openssl/1.0.2n-w                     (D)
   bowtie2/2.3.4.1-python-2.7.14-t          kbproto/1.0.7-x               (D)    pcre/8.41-7                          (D)
   bzip2/1.0.6-f                            lammps/20180316-4                    perl/5.24.1-a
   cairo/1.14.12-python-2.7.14-d            libbsd/0.8.6-g                       pixman/0.34.0-r                      (D)
   cfitsio/3.420-t                          libcerf/1.3-v                        pkg-config/0.29.2-w
   charm/6.7.1-t                            libffi/3.2.1-p                       pkgconf/1.4.0-i
   cmake/3.11.1-4                    (D)    libgd/2.2.4-q                 (D)    prodigal/2.6.3-h
   eigen/3.3.4-c                            libice/1.0.9-b                       proj/4.9.2-q                         (D)
   espresso/6.1.0-z                         libiconv/1.15-6               (D)    protobuf/3.5.1.1-z
   expat/2.2.2-k                     (D)    libjpeg-turbo/1.5.3-g                py-numpy/1.13.3-python-2.7.14-3
   fftw/3.3.7-5                             libpciaccess/0.13.5-f                py-setuptools/39.0.1-python-2.7.14-4
   flex/2.6.4-n                             libpng/1.6.34-i                      python/2.7.14-k
   font-util/1.3.1-r                 (D)    libpthread-stubs/0.4-k               readline/7.0-q                       (D)
   fontconfig/2.12.3-m                      libsigsegv/2.11-u                    renderproto/0.11.1-u
   fontconfig/2.12.3-python-2.7.14-2 (D)    libsm/1.2.2-h                        root/6.08.06-python-2.7.14-f
   freetype/2.7.1-i                         libtiff/4.0.8-b                      samtools/1.6-r
   gdbm/1.14.1-j                            libtool/2.4.6-s               (D)    scotch/6.0.4-u
   geant4/10.04-y                           libx11/1.6.5-2                       sqlite/3.22.0-q
   geos/3.6.2-v                             libxau/1.0.8-3                (D)    sra-toolkit/2.8.2-1-s
   gettext/0.19.8.1-w                       libxcb/1.13-5                 (D)    stringtie/1.3.4a-j
   gettext/0.19.8.1-python-2.7.14-u  (D)    libxdmcp/1.1.2-y              (D)    suite-sparse/5.2.0-2
   glib/2.56.0-python-2.7.14-q       (D)    libxext/1.3.3-y                      tar/1.29-2                           (D)
   gmp/6.1.2-y                              libxft/2.3.2-python-2.7.14-u         tophat/2.1.1-boost-python-2.7.14-x
   gnuplot/5.2.0-4                   (D)    libxml2/2.9.4-u                      util-macros/1.19.1-r                 (D)
   gperf/3.0.4-d                            libxpm/3.5.12-u                      xcb-proto/1.13-n
   graphviz/2.40.1-h                        libxpm/3.5.12-python-2.7.14-p        xerces-c/3.1.4-s
   gromacs/2018-k                           libxrender/0.9.10-2                  xextproto/7.3.0-a
   gsl/1.16-l                               m4/1.4.18-a                          xproto/7.0.31-5                      (D)
   gsl/2.4-2                         (D)    metis/5.1.0-5                        xrootd/4.6.0-5                       (D)
   hdf5/1.10.1-m                     (D)    mixmod/3-1-0-y                       xtrans/1.3.5-s
   help2man/1.47.4-j                        mixmod/3.2.2-c                (D)    xz/5.2.3-4                           (D)
   hisat2/2.1.0-n                           mothur/1.39.5-boost-i                zlib/1.2.11-q
   hmmer/3.1b2-7                            mpfr/4.0.1-2                  (D)
   htslib/1.6-o                             muscle/3.8.1551-h
```

## Using modules outside of OSG Connect

In order to use distributed environment modules outside of OSG Connect, you'll need to load the modules code manually from OASIS.  You can do this by running
	
	$ source /cvmfs/connect.opensciencegrid.org/modules/lmod/init/SHELL
	
where SHELL is the shell that you are using (this is usually bash).  


[request]: 5000649173
