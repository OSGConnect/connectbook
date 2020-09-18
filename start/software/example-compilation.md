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

Specifically, this guide provides two examples of compiling Samtools, one without CRAM file 
support and one with CRAM file support. *Why two examples?* Currently, to install Samtools 
with CRAM support requires additional dependencies (aka libraries) that will also need to be 
installed and most Samtools users are only working with BAM files which does not require CRAM 
support.

*Do I need CRAM support for my work?* CRAM is an alternative compressed sequence alignment 
file format to BAM. Learn more at [https://www.sanger.ac.uk/tool/cram/](https://www.sanger.ac.uk/tool/cram/).

## Get Organized

How you organize the content of your `home` directory is entirely up to you, but there are some 
general best practices that we recommend. First, and foremost, use directories to organize your 
`home` content. Second, install your software to a separate location

## Compile Samtools Without CRAM Support

### Step 1. Acquire Samtools source code

Samtools source code is available at [http://www.htslib.org/download/](http://www.htslib.org/download/). The 
development code is also available via GitHub at [https://github.com/samtools/samtools](https://github.com/samtools/samtools). On the download page is some important information to make note of:

> "\[Samtools\] uses HTSlib internally \[and\] these source packages contain their own copies of htslib"

What this means is 1.) HTSlib is a dependency of Samtools and 2.) the HTSlib source code is included 
in along with the Samtools source code.

Either download the Samtools source code to your computer and upload to the your login node, or
right-click on the Samtools source code link and copy the link location. Login in to your OSG Connect login 
and use `wget` to download the source code directly and extract the tarball:

	[user@login ~]$ wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
	[user@login ~]$ tar -xjf samtools-1.10.tar.bz2

The above two commands will create directory named `samtools-1.10` which contains all the code 
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
both `tview` and CRAM support - see [below](#install-samtools-with-cram-support) for our 
compilation example that will provide CRAM file support. 

Following the suggestion in the Samtools `INSTALL` file, we can view the HTSlib `INSTALL` 
file at `samtools-`1.10/htslib-1.10/INSTALL`. Here we will find the necessary 
information for disabling bzip2 and liblzma dependencies:

	--disable-bz2
	    Bzip2 is an optional compression codec format for CRAM, included
	    in HTSlib by default.  It can be disabled with --disable-bz2, but
	    be aware that not all CRAM files may be possible to decode.

	--disable-lzma
	    LZMA is an optional compression codec for CRAM, included in HTSlib
	    by default.  It can be disabled with --disable-lzma, but be aware
	    that not all CRAM files may be possible to decode. 

These are examples of two flags that will need to be used when performing our installation.

To determine what libraries are available on your OSG Connect login node, you can look at `/usr/lib` 
and `/usr/lib64` for the various Samtools library dependencies, for example:

	[user@login ~]$ ls /usr/lib* | grep libcurl
	[user@login ~]$ ls /usr/lib* | grep htslib

Although we will find hits for libcurl, we will not find any htslib files meaning that 
HTSlib is not currently installed on the login node, nor is it currently available 
as a module. This means that HTSlib will also need to be compiled. Luckly, the Samtools 
developers have conveniently included the HTSlib source code with the Samtools source code 
and have made it possible to compile both Samtools and HTSlib at the same time. From the 
Samtools `INSTALL` file, is the following: 

	    By default, configure looks for an HTSlib source tree within or alongside
	    the samtools source directory; if there are several likely candidates,
	    you will have to choose one via this option.

This mean that we don't have to do anything extra to get HTSlib installed because 
the Samtools installation will by default do it for us.

> When performing your compilation, if your compiler is unable to locate the necessary 
> libraries, or if newer versions of libraries are needed, it will result in an error - this 
> makes for an alternative method for determining whether your system has the appropriate 
> libraries for your software and more often than not, installation by trial and error is 
> a common approach many people take. However, taking a little bit of time before hand 
> and looking for library files can save you time and frustration.

### Step 3. Perform Samtools Compilation

We now have all of the information needed to start our compilation of Samtools without CRAM support.

First, we will create a new directory in our`home` directory that will store the 
Samtools compiled software. The example here will use a common directory, called `my-software`, 
for organizing all compiled software in the `home` directory:

	[user@login ~]$ mkdir my-software
	[user@login ~]$ mkdir my-software/samtools-1.10

> As a best practice, always include the version name of your software in the directory name.

Change our directories to the Samtools source code direcory that was created in 
[Step 1](#step-1-.-acquire-samtools-source-code). You should see the `INSTALL` and `README` files 
as well as a file called `configure`.

The first command we will run is `./configure` - this file is a script that allows us 
to modify various details about our Samtools installation and we will be executing `configure` 
with several flags:

	[user@login samtools-1.10]$ ./configure --prefix=$HOME/my-software/samtools-1.10 --disable-bz2 --disable-lzma --without-curses

Here we used `--prefix` to specify where we would like the final Samtools software 
to be installed, `--disable-bz2` and `--disable-lzma` to disable lzma 
and bzip2 dependencies for CRAM, and `--without-curses` to disable `tview` support.

Next run the final two commands:

	[user@login samtools-1.10]$ make
	[user@login samtools-1.10]$ make install

Once `make install` has finished running, the compilation is complete. We can 
also confirm this by looking at the content of `~/my-software/samtools-1.10/` where 
we has Samtools installed:

	[user@login samtools-1.10]$ cd ~
	[user@login ~]$ ls -F my-software/samtools-1.10/
	bin/ share/

There will be two directories present in `my-software/samtools-1.10`, one named `bin` and 
another named `share`. The Samtools executable will be located in `bin` and we can give 
it a quick test to make sure it runs as expected:

	[user@login ~]$ ./my-software/samtools-1.10/bin/samtools view

which will return the Samtools `view` usage statement.

### Step 4. Make Your Software Portable

Our subsequent job submissions on OSG Connect will need a copy of our software. For 
convenience, we recommend converting your software directory to a tar archive, this will 
be particularly useful if our jobs will use more than one "tool" from Samtools. 
First move to `my-software/`, then create the tar archive:

	[user@login ~]$ mv my-software/
	[user@login my-software]$ tar -czf samtools-1.10.tar.gz samtools-1.10/
	[user@login my-software]$ ls -lh samtools-1.10.tar.gz
	samtools-1.10/ samtools-1.10.tar.gz
	[user@login my-software]$ du -h samtools-1.10.tar.gz
	2.0M	samtools-1.10.tar.gz

The last command in the above example returns the size of our tar archive. This is 
important for determine the appropriate method that we should use for transferring 
this file in our subsequent jobs. To learn more, please see 
[Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985).

To clean up and clear out space in your home directory, we recommend deleting the Samtools source 
code directory and the installation directory.

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
	ls /usr/lib* | grep libz
	ls /usr/lib* | grep libbz2
