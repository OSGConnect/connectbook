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

Specifically, this guide provides two examples of compiling Samtools, [one without CRAM file 
support](#compile-samtools-without-cram-support) and [one with CRAM file support](#compile-samtools-with-cram-support). 
*Why two examples?* Currently, to install Samtools 
with CRAM support requires additional dependencies (aka libraries) that will also need to be 
installed and most Samtools users are only working with BAM files which does not require CRAM 
support.

*Do I need CRAM support for my work?* CRAM is an alternative compressed sequence alignment 
file format to BAM. Learn more at [https://www.sanger.ac.uk/tool/cram/](https://www.sanger.ac.uk/tool/cram/).

## Compile Samtools Without CRAM Support

### Step 1. Acquire Samtools source code

Samtools source code is available at [http://www.htslib.org/download/](http://www.htslib.org/download/). The 
development code is also available via GitHub at [https://github.com/samtools/samtools](https://github.com/samtools/samtools). On the download page is some important information to make note of:

> "\[Samtools\] uses HTSlib internally \[and\] these source packages contain their own copies of htslib"

What this means is 1.) HTSlib is a dependency of Samtools and 2.) the HTSlib source code is included 
with the Samtools source code.

Either download the Samtools source code to your computer and upload to the your login node, or
right-click on the Samtools source code link and copy the link location. Login in to your OSG Connect login node  
and use `wget` to download the source code directly and extract the tarball:

	[user@login ~]$ wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
	[user@login ~]$ tar -xjf samtools-1.10.tar.bz2

The above two commands will create a directory named `samtools-1.10` which contains all the code 
and instructions needed for compiling Samtools and HTSlib. Take a moment to look at the content available 
in this new directory.

### Step 2. Read through installation instructions

*What steps need to be performed for our compilation? What system dependencies exist for our 
software?* Answers to these questions, and other important information, should be available 
in the installation instructions for your software which will be available online and/or 
included in the source code.

The HTSlib website where the Samtools source code is hosted provides basic installation instructions 
and refers users to `INSTALL` (which is a plain text file that can be found in `samtools-1.10/`) for 
more information. You will also see a `README` file in the source code directory which will provide 
important information. `README` files will always be included with your source code and we 
recommend reviewing before compiling software. There is also a `README` and `INSTALL` file available 
for HTSlib in the source code directory `samtools-1.10/htslib-1.10/`.

`cd` to samtools-1.10 and read through `README` and `INSTALL`. As described in `INSTALL`, 
the Samtools installation will follow the common `configure`, `make`, `make install` process:

	Basic Installation
	==================
	
	To build and install Samtools, 'cd' to the samtools-1.x directory containing
	the package's source and type the following commands:
	
	    ./configure
	    make
	    make install
	
	The './configure' command checks your build environment and allows various
	optional functionality to be enabled (see Configuration below). 

Also described in `INSTALL` are a number of required and optional system dependencies 
for installing Samtools and HTSlib (which is itself a dependency of Samtools):

	System Requirements
	===================
	
	Samtools and HTSlib depend on the following libraries:
	
	  Samtools:
	    zlib       <http://zlib.net>
	    curses or GNU ncurses (optional, for the 'tview' command)
	               <http://www.gnu.org/software/ncurses/>
	
	  HTSlib:
	    zlib       <http://zlib.net>
	    libbz2     <http://bzip.org/>
	    liblzma    <http://tukaani.org/xz/>
	    libcurl    <https://curl.haxx.se/>
	               (optional but strongly recommended, for network access)
	    libcrypto  <https://www.openssl.org/>
	               (optional, for Amazon S3 support; not needed on MacOS)
	
	...
	
	The bzip2 and liblzma dependencies can be removed if full CRAM support
	is not needed - see HTSlib's INSTALL file for details.

Some dependencies are needed to support certain features from Samtools (such as `tview` and 
CRAM compression). You will not need `tview` as this is intended for interactive work which is 
not currently supported in OSG Connect. For this specific compilation example, we will disable 
both `tview` and CRAM support - see [below](#compile-samtools-with-cram-support) for our 
compilation example that will provide CRAM file support. 

Following the suggestion in the Samtools `INSTALL` file, we can view the HTSlib `INSTALL` 
file at `samtools-1.10/htslib-1.10/INSTALL`. Here we will find the necessary 
information for disabling bzip2 and liblzma dependencies:

	--disable-bz2
	    Bzip2 is an optional compression codec format for CRAM, included
	    in HTSlib by default.  It can be disabled with --disable-bz2, but
	    be aware that not all CRAM files may be possible to decode.

	--disable-lzma
	    LZMA is an optional compression codec for CRAM, included in HTSlib
	    by default.  It can be disabled with --disable-lzma, but be aware
	    that not all CRAM files may be possible to decode. 

These are two flags that will need to be used when performing our installation.

To determine what libraries are available on our OSG Connect login node, we can look at `/usr/lib` 
and `/usr/lib64` for the various Samtools library dependencies, for example:

	[user@login ~]$ ls /usr/lib* | grep libcurl
	[user@login ~]$ ls /usr/lib* | grep htslib

Although we will find matches for `libcurl`, we will not find any `htslib` files meaning that 
HTSlib is not currently installed on the login node, nor is it currently available 
as a module. This means that HTSlib will also need to be compiled. Luckly, the Samtools 
developers have conveniently included the HTSlib source code with the Samtools source code 
and have made it possible to compile both Samtools and HTSlib at the same time. From the 
Samtools `INSTALL` file, is the following: 

	    By default, configure looks for an HTSlib source tree within or alongside
	    the samtools source directory; if there are several likely candidates,
	    you will have to choose one via this option.

This mean that we don't have to do anything extra to get HTSlib installed because 
the Samtools installation will do it by default.

> When performing your compilation, if your compiler is unable to locate the necessary 
> libraries, or if newer versions of libraries are needed, it will result in an error - this 
> makes for an alternative method of determining whether your system has the appropriate 
> libraries for your software and more often than not, installation by trial and error is 
> a common approach. However, taking a little bit of time before hand 
> and looking for library files can save you time and frustration during software compilation.

### Step 3. Perform Samtools compilation

We now have all of the information needed to start our compilation of Samtools without CRAM support.

First, we will create a new directory in our `home` directory that will store the 
Samtools compiled software. The example here will use a directory, called `my-software`, 
for organizing all compiled software in the `home` directory:

	[user@login ~]$ mkdir $HOME/my-software
	[user@login ~]$ mkdir $HOME/my-software/samtools-1.10

> As a best practice, always include the version name of your software in the directory name.

Next we'll change to the Samtools source code direcory that was created in 
[Step 1](#step-1-acquire-samtools-source-code). You should see the `INSTALL` and `README` files 
as well as a file called `configure`.

The first command we will run is `./configure` - this step will execute the configure script 
and allows us to modify various details about our Samtools installation. We will be executing `configure` 
with several flags:

	[user@login samtools-1.10]$ ./configure --prefix=$HOME/my-software/samtools-1.10 --disable-bz2 --disable-lzma --without-curses

Here we used `--prefix` to specify where we would like the final Samtools software 
to be installed, `--disable-bz2` and `--disable-lzma` to disable `lzma` 
and `bzip2` dependencies for CRAM, and `--without-curses` to disable `tview` support.

Next run the final two commands:

	[user@login samtools-1.10]$ make
	[user@login samtools-1.10]$ make install

Once `make install` has finished running, the compilation is complete. We can 
also confirm this by looking at the content of `~/my-software/samtools-1.10/` where 
we had Samtools installed:

	[user@login samtools-1.10]$ cd ~
	[user@login ~]$ ls -F my-software/samtools-1.10/
	bin/ share/

There will be two directories present in `my-software/samtools-1.10`, one named `bin` and 
another named `share`. The Samtools executable will be located in `bin` and we can give 
it a quick test to make sure it runs as expected:

	[user@login ~]$ ./my-software/samtools-1.10/bin/samtools view

which will return the Samtools `view` usage statement.

### Step 4. Make our software portable

Our subsequent job submissions on OSG Connect will need a copy of our software. For 
convenience, we recommend converting your software directory to a tar archive. 
First move to `my-software/`, then create the tar archive:

	[user@login ~]$ mv my-software/
	[user@login my-software]$ tar -czf samtools-1.10.tar.gz samtools-1.10/
	[user@login my-software]$ ls samtools-1.10*
	samtools-1.10/ samtools-1.10.tar.gz
	[user@login my-software]$ du -h samtools-1.10.tar.gz
	2.0M	samtools-1.10.tar.gz

The last command in the above example returns the size of our tar archive. This is 
important for determine the appropriate method that we should use for transferring 
this file along with our subsequent jobs. To learn more, please see 
[Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985).

To clean up and clear out space in your home directory, we recommend deleting the Samtools source 
code directory.

### Step 5. Use Samtools in our jobs

Now that Samtools has been compiled we can submit jobs that use this software. Below is an example submit file 
for a job that will use Samtools with a BAM file named `my-sample.bam` which is <100MB in size:

	#samtools.sub
	log = samtools.$(Cluster).log
	error = samtools.$(Cluster)_$(Process).err
	output = samtools.$(Cluster)_$(Process).out
	
	executable = samtools.sh
	
	transfer_input_files = /home/username/my-software/samtools-1.10.tar.gz, my-sample.bam

	should_transfer_files = YES
	when_to_transfer_output = ON_EXIT
	
	requirements = (OSGVO_OS_STRING == "RHEL 7")
	request_memory = 1.3GB
	request_disk = 1.5GB
	request_cpus = 1
	
	queue 1

The above submit file will transfer a complete copy of the Samtools tar archive 
created in [Step 4](#step-4-make-our-software-portable) and also includes an important 
`requirements` attribute which tells HTCondor to run our job on 
execute nodes running Red Hat Linux version 7 operating system.

> The resource requests for your jobs may differ from what is shown in the 
> above example. Always run tests to determine the appropriate requests for your jobs.

Some additional steps are then needed in the executable bash script used by this job 
to "untar" the Samtools and add this software to the `PATH` enviroment variable:

	#!/bin/bash
	# samtools.sh
	
	# untar software
	tar -xzf samtools-1.10.tar.gz

	# modify environment variables 
	export PATH=$_CONDOR_SCRATCH_DIR/samtools-1.10/bin:$_CONDOR_SCRATCH_DIR/xz-5.2.5/bin:$PATH
	
	# run samtools commands
	...

## Compile Samtools With CRAM Support

This example includes steps to install and use a library and to use a module, 
which are both currently needed for compiling Samtools with CRAM support. 

The steps in this example assume that you have performed 
[Step 1](#step-1-acquire-samtools-source-code) and 
[Step 2](#step-2-read-through-installation-instructions) in the above example for 
compiling Samtools without CRAM support.

### Step 2. Read through installation instructions, continued

From both the Samtools and HTSlib `INSTALL` files, we know that both bzip2 and 
libzlma are required for CRAM support. We can check our system for these libraries:

	[user@login ~]$ ls /usr/lib* | grep libz
	[user@login ~]$ ls /usr/lib* | grep libbz2

which will reveal that both sets of libraries are available on the login. **However** 
if we were to attempt Samtools installation with CRAM support right now 
we would find that this results in an error when performing the `configure` step.

*If the libraries are present, why do we get this error?* This error is due to 
differences between types of library files. For example, running 
`ls /usr/lib* | grep libbz2` will return two matches, `libbz2.so.1` and `libbz2.so.1.0.6`. 
But running `ls /usr/lib* | grep liblz` will return four matches including three 
`.so` and one `.a` files. Our Samtools compilation specifically requires 
the `.a` type of library file for both `libbz2` and `liblzma` and the absence of 
this type of library file in `/usr/lib64` is why compilation 
will fail without additional steps.

Luckily for us, bzip2 version 1.0.6 is available as a module and this module 
includes access to a `.a` library file. We will use this module for our Samtools compilation. 
To learn more about using modules, please see 
[Accessing Software using Distributed Environment Modules](https://support.opensciencegrid.org/support/solutions/articles/12000048518). 
`liblzma` however is not currently available as a module and our next step 
will be to install `liblzma`.

### Step 3. Compile liblzma

To compile Samtools with CRAM support requires that we first compile 
`liblzma`. Following the same approach as we did for Samtools, first we 
acquire a copy of the the latest liblzma source code, then review the installation instructions. 
From our online search we will that `liblzma` 
is availble from the XZ Utils library package.

	[user@login ~]$ wget https://tukaani.org/xz/xz-5.2.5.tar.gz
	[user@login ~]$ tar -xzf xz-5.2.5.tar.gz

Then review the installation instructions and check for dependencies. Everything 
that is needed for the default installation of XZ utils is currently available on the login node.

	[user@login ~]$ cd xz-5.2.5/
	[user@login xz-5.2.5]$ less INSTALL

Perform the XZ Utils compilation:

	[user@login xz-5.2.5]$ mkdir $HOME/my-software/xz-5.2.5
	[user@login xz-5.2.5]$ ./configure --prefix=$HOME/my-software/xz-5.2.5
	[user@login xz-5.2.5]$ make
	[user@login xz-5.2.5]$ make install
	[user@login xz-5.2.5]$ ls -F $HOME/my-software/xz-5.2.5
	/bin  /include  /lib  /share

Success!

Lastly we need to set some environment variables so that Samtools knows where to 
find this library:

	[user@login xz-5.2.5]$ export PATH=$HOME/my-software/xz-5.2.5/bin:$PATH
	[user@login xz-5.2.5]$ export LIBRARY_PATH=$HOME/my-software/xz-5.2.5/bin:$LIBRARY_PATH
	[user@login xz-5.2.5]$ export LD_LIBRARY_PATH=$LIBRARY_PATH

### Step 4. Load bzip2 module

After installing XZ Utils and setting our environment variable, next we will 
load the bzip2 module:

	[user@login xz-5.2.5]$ module load bzip2/1.0.6

Loading this module will further modify some of your environment variables 
so that Samtools is able to locate the bzip2 library files.

To learn more about using modules, please see 
[Accessing Software using Distributed Environment Modules](https://support.opensciencegrid.org/support/solutions/articles/12000048518). 

### Step 5. Compile Samtools

After compiling XZ Utils (which provides `liblzma`) and loading the `bzip2 1.0.6` module, 
we are now ready to compile Samtools with CRAM support.

First, we will create a new directory in our `home` directory that will store the 
Samtools compiled software. The example here will use a common directory, called `my-software`, 
for organizing all compiled software in the `home` directory:

	[user@login ~]$ mkdir $HOME/my-software
	[user@login ~]$ mkdir $HOME/my-software/samtools-1.10

> As a best practice, always include the version name of your software in the directory name.

Next, we will change our directory to the Samtools source code direcory that was created in 
[Step 1](#step-1-acquire-samtools-source-code). You should see the `INSTALL` and `README` files 
as well as a file called `configure`.

The first command we will run is `./configure` - this file is a script that allows us 
to modify various details about our Samtools installation and we will be executing `configure` 
with a flag that disables `tview`:

	[user@login samtools-1.10]$ ./configure --prefix=$HOME/my-software/samtools-1.10 --without-curses

Here we used `--prefix` to specify where we would like the final Samtools software 
to be installed and `--without-curses` to disable `tview` support.

Next run the final two commands:

	[user@login samtools-1.10]$ make
	[user@login samtools-1.10]$ make install

Once `make install` has finished running, the compilation is complete. We can 
also confirm this by looking at the content of `~/my-software/samtools-1.10/` where 
we had Samtools installed:

	[user@login samtools-1.10]$ cd ~
	[user@login ~]$ ls -F my-software/samtools-1.10/
	bin/ share/

There will be two directories present in `my-software/samtools-1.10`, one named `bin` and 
another named `share`. The Samtools executable will be located in `bin` and we can give 
it a quick test to make sure it runs as expected:

	[user@login ~]$ ./my-software/samtools-1.10/bin/samtools view

which will return the Samtools `view` usage statement.

### Step 6. Make our software portable

Our subsequent job submissions on OSG Connect will need a copy of our software. For 
convenience, we recommend converting your software directory to a tar archive. 
First move to `my-software/`, then create the tar archive:
	
	[user@login ~]$ mv my-software/
	[user@login my-software]$ tar -czf samtools-1.10.tar.gz samtools-1.10/
	[user@login my-software]$ ls samtools-1.10*
	samtools-1.10/ samtools-1.10.tar.gz
	[user@login my-software]$ du -h samtools-1.10.tar.gz
	2.0M	samtools-1.10.tar.gz

The last command in the above example returns the size of our tar archive. This is 
important for determine the appropriate method that we should use for transferring 
this file along with our subsequent jobs. To learn more, please see 
[Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985).

Follow the these same steps for creating a tar archive of the xz-5.2.5 library as well. 

To clean up and clear out space in your home directory, we recommend deleting the Samtools source 
code directory.

### Step 7. Use Samtools in our jobs

Now that Samtools has been compiled we can submit jobs that use this software. For Samtools 
with CRAM we will also need to bring along a copy of XZ Utils (which includes the `liblzma` library) 
and ensure that our jobs have access to the `bzip2 1.0.6` module. Below is an example submit file 
for a job that will use Samtools with a CRAM file named `my-sample.cram` which is <100MB in size:

	#samtools-cram.sub
	log = samtools-cram.$(Cluster).log
	error = samtools-cram.$(Cluster)_$(Process).err
	output = samtools-cram.$(Cluster)_$(Process).out
	
	executable = samtools-cram.sh
	
	transfer_input_files = /home/username/my-software/samtools-1.10.tar.gz, /home/username/my-software/xz-5.2.5.tar.gz, genome.fa, my-sample.cram

	should_transfer_files = YES
	when_to_transfer_output = ON_EXIT
	
	requirements = (OSGVO_OS_STRING == "RHEL 7") && (HAS_MODULES =?= TRUE)
	request_memory = 1.3GB
	request_disk = 1.5GB
	request_cpus = 1
	
	queue 1

The above submit file will transfer a complete copy of the Samtools tar archive 
created in [Step 6](#step-6-make-our-software-portable) as well as a copy of XZ Utils installation from 
[Step 3](#step-3-compile-liblzma). This submit file 
also includes two important `requirements` which tell HTCondor to run our job on 
execute nodes running Red Hat Linux version 7 operating system and which has 
access to OSG Connect software modules.

> The resource requests for your jobs may differ from what is shown in the 
> above example. Always run tests to determine the appropriate requests for your jobs.

Some additional steps are then needed in the executable bash script used by this job 
to "untar" the Samtools and XZ Util tar archives, modify the `PATH` and 
`LD_LIBRARY_PATH` enviroments of our job, and load the `bzip2` module:

	#!/bin/bash
	# samtools-cram.sh
	
	# untar software and libraries
	tar -xzf samtools-1.10.tar.gz
	tar -xzf xz-5.2.5.tar.gz

	# modify environment variables 
	export LD_LIBRARY_PATH=$_CONDOR_SCRATCH_DIR/xz-5.2.5/lib:$LD_LIBRARY_PATH
	export PATH=$_CONDOR_SCRATCH_DIR/samtools-1.10/bin:$_CONDOR_SCRATCH_DIR/xz-5.2.5/bin:$PATH
	
	# load bzip2 module
	module load bzip2/1.0.6

	# run samtools commands
	...


