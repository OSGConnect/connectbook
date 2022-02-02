[title]: - "Build a Copy of Python"

[TOC]

# Overview

This guide shows how to build a compiled copy of the Python interpreter and 
runtime environment. It is meant to be used along with 
our [Run Python Scripts on the OS Pool][python-pkgs] guide, where instead of using 
the OSG provided versions of Python, you have created your own. 

# Create Python Installation

1. **Download Python source code**

	Choose the version of Python you would like to build from the main 
	[Python website](https://www.python.org/downloads/source/). Download the "Gzipped 
	source tarball" (a .tgz file) to your home 
	directory on OSG Connect; if you have the link, you can do this using the 
	`wget` command, for example: 

		$ wget https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz

2. **Create installation directories**

	Create a main "build" directory, and place the downloaded Python source code inside. 
	Create a second subdirectory -- in what follows, we have called this subdirectory `python`. 
	The final directory structure should looks something like this:

		├── build_dir/
		│   └── python/ 
		│   └── Python-3.9.10.tgz

	and can be created using a sequence of commands like: 

		$ mkdir build_dir
		$ cd build_dir
		$ cp ~/Python-3.9.10.tgz ./ #  The Python source code could alternatively be downloaded *directly* into this folder.
		$ mkdir python

3. **Start a singularity container**

	The login node does not have everything we need to build Python, so we 
	are going to use a singularity container instead. Run the following command 
	from the main build directory: 

		$ singularity shell \
					--home $PWD:/srv \
					--pwd /srv \
					--bind /cvmfs \
					--scratch /var/tmp \
					--scratch /tmp \
					--contain --ipc --pid \
					/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7:latest

4. **Un-tar source code and compile Python**

	Run the following commands to un-tar the .tgz source code file and 
	compile Python, installing it to the `python` subdirectory created earlier: 

		Singularity> tar -xzf Python-3.9.10.tgz
		Singularity> cd Python-3.9.10
		Singularity> ./configure --prefix=/srv/python
		Singularity> make; make install
		Singularity> cd ..

	Once these commands are done, you can exit the container: 

		$ exit

5. **Check installation**

	The `python` directory should now have subdirectories `bin`, `include`, `lib` and `share`.

		$ ls python
		bin  include  lib  share

	Run a quick check of the python program by running: 

		$ python/bin/python3 --version

6. **Prepare the installation directory for jobs**

	Combine and compress the `python` installation directory to a tar.gz file: 

		$ tar -czf python.tar.gz python

	You may want to include the version number in the name of the tar.gz file if you 
	are planning to work with different versions of Python. 

	Once this tar.gz file is created, move it to your public directory: 

		$ mv python.tar.gz /public/username

	Once you confirm that this file was moved to your public folder 
	successfully, you can delete the remaining files in our `build_dir` folder to 
	help maintain a clean workspace. We can delete them by typing: 
	
		$ rm -r python Python-3.9.10 Python-3.9.10.tgz

	You can also remove the entire build directory. 

7. **Submit jobs**

	From here, follow the instructions in our [Run Python Scripts on the OS Pool][python-pkgs] 
	guide, replacing the `stash:///osgconnect/public/osg` links with links to the copy of 
	Python in your own `/public` directory. 

[python-pkgs]: 
