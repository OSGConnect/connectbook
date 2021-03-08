[title]: - "Compiling Software for OSG Connect"

# Compiling Software for OSG Connect

## Introduction

Due to the distributed nature of the Open Science Grid, you will always need to 
ensure that your jobs have access to the software that will be executed. This guide provides 
useful information for compiling and using your software in OSG Connect. A detailed 
example of performing software compilation is additionally available 
at [OSG Connect Example Compilation Guide](https://support.opensciencegrid.org/support/solutions/articles/12000074984). 


> *What is compiling?*
> The process of compiling converts human readable code into binary, 
> machine readable code that will execute the steps of the program. 

## Get software source code

The first step to compiling your software is to locate and download the source 
code, being sure to select the version that you want. Source code 
will often be made available as a compressed tar archive which will need to be 
extracted for before compilation.

You should also carefully review the installation instructions provided by the 
software developers. The installation instructions should include important 
information regarding various options for configuring and performing the compilation. 
Also carefully note any system dependencies (hardware, other software, and libraries) that are 
required for your software.

## Select the appropriate compiler and compilation options

A compiler is a program that is used to peform source code compilation. The GNU Compiler 
Collection (GCC) is a common, open source collection of compilers with support for C, C++, 
fotran, and other languages, and includes important libraries for supporting your compilation 
and sometimes software execution. Your software compilation may require certain versions 
of a compiler which should be noted in the installation instructions or system dependencies 
documention. Currently the login nodes have `GCC 4.8.5` as the default version, but newer 
versions of GCC may also be available - to learn more please contact <support@opensciencegrid.org>.

CMake is a commonly used compilation platform. Your software may have dependencies for 
specific `cmake` versions. Currently the login nodes have two versions of CMake, `3.12.3` 
and `3.13.0` available as [modules](https://support.opensciencegrid.org/support/solutions/articles/12000048518). 

### Static versus dynamic linking during compilation

Binary code often depends on additional information (i.e. instructions) from other software, 
known as libraries, for proper execution. The default behavior when compiling, is for the 
final binary to be "dynamically linked" to libraries that it depends on, such that when 
the binary is executed, it will look for these library files on the system that it is 
running on. Thus a copy of the appropriate library files will need to be available to your 
software wherever it runs. OSG Connect users can transfer a copy of the necessary 
libraries along with with their jobs to manage such dependencies if not supported by the 
execute node that your jobs run on.

However, the option exists to "statically link" the library dependencies of your software. 
By statically linking libraries during compilation, the library code will be 
directly packaged with your software binary meaning the libraries will always be 
available to your software which your software to run on more execute nodes.

To statically link libraries during compilation, use the `-static` flag when running `gcc`, 
use `--enable-static` when running a `configure` script, or set your `LD_FLAGS` 
environment variable to `--enable-static` (e.g. `export LD_FLAGS="--enable-static"`).

### Get access to libraries needed for your software

As described above, your software may require additional software, known as libraries, for 
compilation and execution. For greatest portability of your software, we recommend installing 
the libraries needed for your software and transferring a copy of the libraries along with 
your subsequent jobs. When using libraries that you have installed yourself, you will likely 
need to add these libraries to your `LIBRARY_PATH` environment variable before compiling 
your software. There may also be additional environment variables that will need to be 
defined or modified for software compilation, this information should be provided 
in the installtion instructions of your software. For any libraries added to `LIBRARY_PATH` 
before software compilation, you'll also need to add these same libraries to 
your `LD_LIBRARY_PATH` as a step in your job's executable bash script before executing 
your software.

The [distributed environment modules system](https://support.opensciencegrid.org/support/solutions/articles/12000048518) 
available on OSG Connect also provides several commonly used software libraries 
(lapack, atlas, hdf5, netcdf, etc.) that can be used for your software compilation and 
execution. The appropriate modules should be loaded before performing your software 
compilation. The process of loading a module will modify all appropriate 
environment variables (e.g. `CPATH` and `LIBRARY_PATH`) for you. If you do use modules 
from the modules system, you will need to modify your job scripts to load the appropriate 
modules before running you software.

## Perform your compilation

Software compilation is easiest to perform interactively, and OSG Connect users are 
welcome to compile software directly on their assigned login node. This will ensure
that your application is built on an environment that is similar to the majority
of the compute nodes on OSG. Because OSG Connect login nodes currently use the 
Red Hat Enterprise Linux 7 operating system, your software will, generally, only be 
compatible for execution on RHEL 7 or similar operating systems. You can use the 
`requirements` statement of your HTCondor submit file to direct your jobs to execute 
nodes with specific operating systems, for instance:

	requirements = (OSGVO_OS_STRING == "RHEL 7")

Software installation typically includes three steps: 1.) configuration, 2.) compilation, and 3.) 
"installation" which places the compiled code in a specific location. In most cases, 
these steps will be achieved with the following commands:

	./configure
	make
	make install

**Most software is written to install to a default location, however your OSG Connect 
account is not authorized to write to these default system locations.** Instead, you will want to 
create a folder for your software installation in your `home` directory and use an option in the 
configuration step that will install the software to this folder:

	./configure --prefix=/home/username/path

where `username` should be replaced with your OSG Connect username and `path` replaced with the 
path to the directory you created for your software installation.

## Use Your Software

When submitting jobs, you will need to transfer a copy of your compiled software, 
and any dynamically-linked dependencies that you also installed. Our 
[Introduction to Data Management on OSG Connect](https://support.opensciencegrid.org/support/solutions/articles/12000002985) 
guide is a good starting point for more information for selecting the appropriate
methods for transferring you software. Depending on your job workflow, it may be possible 
to directly specify your executable binary as the `executable` in your HTCondor 
submit file.

When using your software in subsequent job submissions, be sure to add additional  
commands to the executable bash script to define evironment variables, like
for instance `LD_LIBRARY_PATH`, that may be needed to properly execute your software.

## Get Additional Assistance
If you have questions or need assistance, please contact <support@opensciencegrid.org>.
