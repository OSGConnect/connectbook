[title]: - "Example Software Compilation"

# Example of Compilng Software For Use In OSG Connect

## Introduction

Due to the distributed nature of the Open Science Grid, you will always need to 
ensure that your jobs have access to the software that will be executed. This guide provides 
a detailed example of compiling software for use in OSG Connect. 

For this example, we will be compiling Samtools which is a very common bioinformatics 
software for working with aligned sequencing data. However, the steps described in this 
example are applicable to many other software. For a general introduction to software 
compilation in OSG Connect, please see [Compiling Software for OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000652099).

## Compile Samtools

### Step 1. Acquire Samtools source code

Samtools source code is available at [http://www.htslib.org/download/](http://www.htslib.org/download/). The 
development code is also available via GitHub at [https://github.com/samtools/samtools](https://github.com/samtools/samtools).

Either download the Samtools source code to your co
Right-click on the Samtools source code link and copy the link location. Login in to your OSG Connect login 
and use `wget` to download the source code directly and extract the tarball:

	wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
	tar -xjf samtools-1.10.tar.bz2

The above two commands will create directory named `samtools-1.10` which contains all the code 
needed for compiling Samtools.

### Step 2. Read through installation instructions

The HTSlib website page where the Samtools source code is hosted provides basic installation instructions 
and refers to `INSTALL` for more information. Source code directories will always include a `README` 
file with important information including where to get detailed installation instructions. 

`cd` to samtools-1.10 and read through `README` and `INSTALL`. As described in `INSTALL`, there are 
a number of required and optional system dependencies for installing Samtools. Some dependencies are 
needed to support certain features from Samtools (such as `tview` and CRAM). You will not need `tview`
as this is intended for interactive work which is not currently supported in OSG Connect. These 
installation instructions include additional flags that can be used to disable certain software 
features that remove the need for some of these dependencies.

To determine what libraries are available on your OSG Connect login node, you can look at `/usr/lib` 
and `/usr/lib64` for the various Samtools library dependencies, for example:

	ls /usr/lib64 | grep libcurl
	ls /usr/lib64 | grep libz
	ls /usr/lib64 | grep libbz2

will return with several hits, confirming that specific versions of these libraries are 
already installed on the login node. However, the HTSlib library is not currently 
available on the login node, nor is is currently available as a module, and thus HTSlib 
will need to additionally be compiled before proceeding with compiling samtools.

> When performing your compilation, if your compiler is unable to locate the necessary 
> libraries, or if newer versions of libraries are needed, it will result in an error - this 
> makes for an alternative method for determining whether your system has the appropriate 
> libraries for your software and more often than not, installation by trial and error is 
> a common approach many people take. However, taking a little bit of time before hand 
> and looking for library files can save you time and frustration.

### Step 3. Install HTSlib

Follow steps 1 (acquire soure code and untar) and 2 (review installation instructions) for HTSlib.

	wget https://github.com/samtools/htslib/releases/download/1.10.2/htslib-1.10.2.tar.bz2
	tar -xjz htslib-1.10.2.tar.gz
	cd htslib-1.10.2/
	less INSTALL

You will see that HTSlib has the same library dependencies as Samtools and from our initial examination of 
available libraries on the submit node. Under "Basic Installation" you will see that 
HTSLib follows the conventional `configure`, `make`, `make install` process described in 
[Compiling Software for OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/5000652099).

To execute these three steps, first create a new directory in your home directoy where you 
want the installation to be written to: 

	mkdir $HOME/htslib-1.10.2-install

> If you haven't already, next change directories to the HTSLib source code directory.

Then run:

	./configure --prefix=$HOME/htslib-1.10.2-install

This will produce an error: `configure: error: libbzip2 development files not found`. 
**Why did we get this error?** Following the example above, we confirmed that bzip2 library 
was present when we ran `ls /usr/lib64 | grep libbz2`, but if you look closer, additional 
information was provided in the error message:

	The CRAM format may use bzip2 compression, which is implemented in HTSlib
	by using compression routines from libbzip2 <http://www.bzip.org/>.

	Building HTSlib requires libbzip2 development files to be installed on the
	build machine; you may need to ensure a package such as libbz2-dev (on Debian
	or Ubuntu Linux) or bzip2-devel (on RPM-based Linux distributions or Cygwin)
	is installed.
	
	Either configure with --disable-bz2 (which will make some CRAM files
	produced elsewhere unreadable) or resolve this error to build HTSlib. 

What this means is that the bzip2 libraries on the login node don't include support 
for certain HTSlib features, specifically CRAM file format support. If your work does 
not depend on CRAM format support, then repeat the `configure` step using the flag provided 
in the error message to disable these features:

	./configure --prefix=$HOME/htslib-1.10.2-install --disable-bz2

For this example compilation, we will assume that CRAM file format support is not required. 
However, see [below](#something) for details about getting full bzip2 support for HTSlib and 
Samtools.

 
	make
	make
