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
> libraries for your software.

### Step 3. Install HTSlib

Follow steps 1 and 2 above for first compiling HTSlib.

	wget https://github.com/samtools/htslib/releases/download/1.10.2/htslib-1.10.2.tar.bz2
	tar -xjz htslib-1.10.2.tar.gz

HTSlib has the same library dependencies as Samtools.
