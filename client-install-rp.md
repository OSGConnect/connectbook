[title]: - "Installing the Connect Client (as a resource provider)"

[TOC]

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

	$ git checkout v0.4.6

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

	$ ./install.sh /software/connect-client-0.4.6 /software/modulefiles

N.B. There may be dependencies in your module environment that should
be loaded when `connect-client` is loaded. In particular, at many sites
Python is a module dependency. Putting `module load` statements into
the module file helps users load the software consistently. After a site
installation **please review the installed modulefile** -- search for the
text "module load" to find the right spot.  All modules that were loaded
when you installed the software will be listed but commented out. Uncomment
any that are true dependencies.


# Without environment modules

If your site does not have environment modules, install the package as
above and, if necessary, modify the $PATH:

	$ export PATH=/software/connect-client/bin:$PATH

You can safely install Connect Client to a common location such as
`/usr` or `/usr/local`.  The installation script will also install
the modulefile (which you won't need) but you can simply remove it.


# Other

We expect to provide an RPM-based installation in the near future.

