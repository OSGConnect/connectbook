[title]: - "Installing the Connect Client (as a resource provider)"

[TOC]

# Obtaining the Connect Client distribution

The first step in installation is to grab the latest copy of the
client from GitHub:

	$ ssh login.mycluster.edu			 # [your cluster site here]
	$ wget stash.osgconnect.net/+connect/connect-client-0.5.3.tar.gz
	$ tar xzf connect-client-0.5.3.tar.gz
	$ cd connect-client-0.5.3

This obtains a copy of the distribution and sets your shell's working
directory to that copy.

# Installation using environment modules

To install the Connect Client you will need Python 2.x and a C compiler.
**Python 3 is not supported.** At some sites, `module load python`
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

Choose a directory to install Connect Client into.  You should
know what directories are used at your site.  For these examples
we'll `/software` as the location of software tools, and
`/software/modulefiles` as the location of module files.
Run `./install.sh` with these two directories:

	$ ./install.sh /software/connect-client-0.5.2 /software/modulefiles

N.B. There may be dependencies in your module environment that should
be loaded when `connect-client` is loaded. In particular, at many sites
Python is a module dependency. Putting `module load` statements into
the module file helps users load the software consistently. After a site
installation **please review the installed modulefile** -- search for the
text "module load" to find the right spot.  All modules that were loaded
when you installed the software will be listed but commented out. Uncomment
any that are true dependencies.


# Using RPM and Yum

We've prepared an RPM for Connect Client which you can install on any Linux
system that is based on Red Hat Enterprise Linux 6 (EL6).  This includes
CentOS 6 and Scientific Linux 6.

To start, install the CI Connect Yum repository with this command:

	$ yum install http://repo.ci-connect.net/yum/ci-connect/6/x86_64/ci-connect-release-6-1.noarch.rpm

This will give you access to CI Connect-related software packages, and to software
updates as they become available.  You can see this in the output of `yum repolist`:

	$ yum repolist
	Loaded plugins: downloadonly, security
	repo id                    repo name                                                          status
	EPEL-6-x86_64              EPEL-6-x86_64                                                      11808
	SL-64-x86_64               SL-64-x86_64                                                        6410
	SL-64-x86_64-security      SL-64-x86_64-security                                               3465
	ci-connect                 CI Connect for Enterprise Linux 6.4 - x86_64                           3
	core-0                     core-0                                                              4011
	dell-el6                   dell-el6                                                            2318
	repolist: 28015

Then just install the connect-client package:

	$ yum install connect-client

... and you're all set!


# Without environment modules

If your site does not have environment modules or RPM/Yum, install the
package from source.  This is much the same as above, but you only need
one destination directory:

	$ ./install.sh /software/connect-client

or even:

	$ ./install.sh /usr/local

If necessary, modify the $PATH:

	$ export PATH=/software/connect-client/bin:$PATH

You can safely install Connect Client to a common location such as
`/usr` or `/usr/local`.  The installation script will also install
the modulefile (which you won't need) but you can simply remove it.


