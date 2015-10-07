[title]: - "Installing the Connect Client (as a user)"

[TOC]

# Supported platforms

The connect client is currently fully supported on Red Hat
Enterprise Linux 6, including CentOS and Scientific Linux.
Other Linux distributions are supported on a best effort
basis, but there should be no major challenges. The client
has been tested on Mac OS X 10.9 and higher, but OSX is also
best-effort supported. Expect these and other operating systems
to become more fully supported in the future.

# Tools you will need

To perform an installation of the Connect Client, you will need
the following software. These might or might not be present on
your computer already:

* a terminal emulation program
* python 2.7 (python 2.6 works, with caveats; see below)
* python 2.7 development libraries and headers
* pip
* git
* gcc or clang
* openssl development libraries and headers

## Too long; didn't read

The following steps will prepare a *pristine* CentOS 6 installation
to compile and install Connect Client. You must have administrator
access!

As root (if you do not have sudo):
	yum -y install sudo

As a user with sudo rights:
	sudo yum -y install https://centos6.iuscommunity.org/ius-release.rpm
	sudo yum -y install python27 python27-pip python27-devel openssl-devel git gcc

If you're in a hurry, you can copy and paste these commands.


## Terminal emulator

Every computer has something to suffice. On Linux, your usual command
prompt is fine. If installing on a MacOS system, use `Terminal.app`
or `iTerm` as your terminal emulator.

## Python

Virtually all operating systems today come with a copy of Python.  Python 2.7
is recommended for the Connect Client. Python 2.6 might work under some conditions,
but is not supported; this is due to a known problem with Python that is fixed
in Python 2.7.  If you _need_ to run the client under Python 2.6, let us know
and we'll try to help you get around these issues.

To determine what version of Python you have installed, run: `python --version`.
**Python 3 is not currently supported.** 
	
If you are on a remote login system that uses environment modules, see below
for special considerations.

### Means of installing Python 2.7

**Linux**: If you're on a Red Hat Enterprise Linux 6 derivative, you will need to be
able to install software system-wide using `sudo yum`. Python 2.7 is not
distributed from the standard repositories on any EL6 distribution, but the
[IUS Community](http://ius.io) has [supplemental software
repositories](https://ius.io/GettingStarted/) that are safe to add to your
system.  Once those are installed, you can use `yum install python27` to
install a `python27` executable.

**MacOS**: Mac OS X ships Python 2.7 by default. You can also use the Python
that comes with MacPorts.

**Anaconda**: Alternatively, you can install
[Anaconda](https://www.continuum.io/downloads). Many users in scientific
disciplines prefer this ready-to-run distribution.

**Source**: If you must build from source, follow the guidelines here:
https://www.python.org/download/releases/2.7/ .  This is not a
recommended option; installing from source requires some considerable
expertise.

## Pip

Many Python installations already have pip. To check, run: `pip --version`.
If you need to install pip, see the directions at
http://pip.readthedocs.org/en/stable/installing/ . These instructions
should work across all platforms.

## Git

To find out whether you have git already, open a terminal window and
type: `git`. You should see a bunch of output starting like this:

	usage: git [--version] [--help] [-C <path>] [-c name=value]

If not, you need to install git.  See
https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
for installation instructions.

## GCC or Clang

A C compiler is required to guarantee some of the cryptographic software
tooling that the Connect Client uses.  Most Linux installations have `gcc`
enabled already.  To check, run `gcc --version`; you should see something like:

	$ gcc --version
	gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-3)
	Copyright (C) 2010 Free Software Foundation, Inc.
	This is free software; see the source for copying conditions.  There is NO
	warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

### Installing a compiler

If you do not have `gcc`, you will need to install it on your system as
the system administrator.

**Linux**: On EL6-based platforms, `sudo yum -y install gcc` should be enough.

**MacOS**: You will need to install [Apple's XCode development
environment](https://itunes.apple.com/us/app/xcode/id497799835). Then
install the XCode command line tools:
* open XCode
* open XCode Preferences
* click the Locations tab
* ensure that a command-line tools package is selected at the bottom of the pane

# Obtaining the Connect Client distribution

The first step in installation is to grab the latest copy of the
client from GitHub:

	$ ssh login.mycluster.edu			 # [your cluster site here]
	$ module load git                    # [if needed]
	$ git clone --recursive https://github.com/CI-Connect/connect-client
	$ cd connect-client

This obtains a copy of the distribution and sets your shell's working
directory to that copy. **The --recursive option is important!**

Typically you'll want to install a release version.

	$ git checkout v0.5


# Installation using environment modules

At some sites, `module load python`
will load Python 3, so it _might_ be necessary to load Python 2
explicitly. For example:

	$ module load gcc
	$ module load python/2.7.6

You will also need pip, the Python package installation program.  Very
often it is part of the Python installation itself.

	**Note**
	We've seen some indication that if your system uses Python 2.6,
	it may be necessary to have installed the **pycrypto** module
	already.  With Python 2.7 and up this dependency is handled
	automatically.

Choose a directory to install Connect Client into.  A reasonable
choice is `~/software/connect`.  Also choose a directory for the
module description information.  A reasonable choice for this is
`~/privatemodules`; for many sites, this is where the `use.own` module
looks for personal modules.

Run `./install.sh` with these two directories.  The install script
will figure out the current version number.

	$ ./install.sh ~/software/connect-client ~/privatemodules


N.B. Any modules that you have loaded at the time you install Connect
Client will be loaded by the Connect Client modulefile _each time you
load the `connect-client` module_. This ensures that dependencies are
handled internally. To reduce unnecessary module loads, be sure not to
load unnecessary modules before installing.  You may wish to hand-edit
the modulefile to ensure that only true dependencies are listed.  Search
for `module load` in the installed modulefile.

After the software is installed, you may use the `module` command to get
access:

	module load use.own
	module load connect-client

Loading `use.own` tells the module system to search your `~/privatemodules`
folder for modules.


# Without environment modules

If your site does not have environment modules, install the package as
above and, if necessary, modify the $PATH:

	$ export PATH=~/software/connect-client/bin:$PATH

The installation script will also install the modulefile (which you
won't need) but you can simply remove it.
