[title]: - "Using Julia on the OSG"

[TOC]

# Overview

This guide provides an introduction to running Julia code on the Open 
Science Grid. The [Quickstart Instructions](#quickstart-instructions) provide 
an outline of job submission. The following sections provide more details about 
installing Julia packages ([Install Julia Packages](#install-julia-packages)) and creating a complete
job submission ([Submit Julia Jobs](#submit-julia-jobs)). This guide assumes that 
you have a script written in Julia and can identify the additional Julia packages 
needed to run the script. 

If you are using many Julia packages or have other software dependencies as 
part of your job, you may want to manage your software via a container instead 
of using the tar.gz file method described in this guide. The OSG Connect team 
maintains a [Julia container](12000073449) that can be used as a starting point 
for creating a customized container with added packages. See 
our [Docker and Singularity Guide](12000024676) for more details. 

# Quickstart Instructions

1. Download the precompiled Julia software from <https://julialang.org/downloads/>. 
You will need the 64-bit, tarball compiled for general use on a Linux x86 system. The 
file name will resemble something like `julia-#.#.#-linux-x86_64.tar.gz`.

    * Tip: use `wget` to download directly to your `/home` directory on the 
submit server, **OR** use `transfer_input_files = url` in your HTCondor submit files.

1. Install your Julia packages on the login node, else skip to the next step.

    * For more details, see the section on installing Julia 
    packages below: [Installing Julia Packages](#install-julia-packages)

1. Submit a job that executes a Julia script using the Julia precompiled binary
with base Julia and Standard Library, via a shell script like the following as 
the job's executable: 

		#!/bin/bash

		# extract Julia tar.gz file
		tar -xzf julia-#.#.#-linux-x86_64.tar.gz

		# add Julia binary to PATH
		export PATH=$_CONDOR_SCRATCH_DIR/julia-#-#-#/bin:$PATH

		# run Julia script
		julia my-script.jl

    * For more details on the job submission, see the section 
    below: [Submit Julia Jobs](#submit-julia-jobs)

# Install Julia Packages

If your work requires additional Julia packages, you will need to peform a one-time 
installation of these packages within a Julia project. A copy of the project 
can then be saved for use in subsequent job submissions. For more details, 
please see Julia's documentation at [Julia Pkg.jl](https://julialang.github.io/Pkg.jl).

## Download Julia and set up a "project"

If you have not already downloaded a copy of Julia, download the 
precompiled Julia software from <https://julialang.org/downloads/>. 
You will need the 64-bit, tarball compiled for general use on a Linux x86 system. The 
file name will resemble something like `julia-#.#.#-linux-x86_64.tar.gz`. 

We will need a copy of the original tar.gz file for running jobs, but to install 
packages, we also need an unpacked version of the software. Run the following commands 
to extract the Julia software and add Julia to your `PATH`: 

	$ tar -xzf julia-#.#.#-linux-x86_64.tar.gz
	$ export PATH=$PWD/julia-#.#.#/bin:$PATH

After these steps, you should be able to run Julia from the command line, e.g.

	$ julia --version

Now create a project directory to install your packages (we've called 
it `my-project/` below) and tell Julia its name: 

	$ mkdir my-project
	$ export JULIA_DEPOT_PATH=$PWD/my-project

> If you already have a directory with Julia packages on the login node, you can 
> add to it by skipping the `mkdir` step above and going straight to setting the 
> `JULIA_DEPOT_PATH` variable. 

You can choose whatever name to use for this directory \-- if you have
different projects that you use for different jobs, you could
use a more descriptive name than "my-project".

## Install Packages

We will now use Julia to install any needed packages to the project directory 
we created in the previous step. 

Open Julia with the `--project` option set to the project directory: 

	$ julia --project=my-project

Once you've started up the Julia REPL (interpreter), start the Pkg REPL, used to 
install packages, by typing `]`. Then install and test packages by using 
Julia's `add Package` syntax. 

				   _
	   _       _ _(_)_     |  Documentation: https://docs.julialang.org
	  (_)     | (_) (_)    |
	   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
	  | | | | | | |/ _` |  |
	  | | |_| | | | (_| |  |  Version 1.0.5 (2019-09-09)
	 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
	|__/                   |

	julia> ]
	(my-project) pkg> add Package
	(my-project) pkg> test Package

If you have multiple packages to install they can be combined 
into a single command, e.g. `(my-project) pkg> add Package1 Package2 Package3`.

**If you encounter issues getting packages to install successfully, please 
contact us at support@osgconnect.net**

Once you are done, you can exit the Pkg REPL by typing the `DELETE` key and then 
typing `exit()`

	(my-project) pkg> 
	julia> exit()

Your packages will have been installed to the `my_project` directory; we want 
to compress this folder so that it is easier to copy to jobs. 

	$ tar -czf my-project.tar.gz my-project/

# Submit Julia Jobs

To submit a job that runs a Julia script, create a bash 
script and HTCondor submit file following the examples in this section. These 
example assume that you have downloaded a copy of Julia for Linux as a `tar.gz` 
file and if using packages, you have gone through the steps above to install them 
and create an additional `tar.gz` file of the installed packages. 

## Create Executable Bash Script

Your job will use a bash script as the HTCondor `executable`. This script 
will contain all the steps needed to unpack the Julia binaries and 
execute your Julia script (`script.jl` below). What follows are two example bash scripts, 
one which can be used to execute a script with base Julia only, and one that 
will use packages you installed to a project directory (see [Install Julia Packages](#install-julia-packages)).

### Example Bash Script For Base Julia Only

If your Julia script can run without additional packages (other than base Julia and 
the Julia Standard library) use the example script directly below.

	#!/bin/bash

	# julia-job.sh

	# extract Julia tar.gz file
	tar -xzf julia-#.#.#-linux-x86_64.tar.gz

	# add Julia binary to PATH
	export PATH=$_CONDOR_SCRATCH_DIR/julia-#.#.#/bin:$PATH

	# run Julia script
	julia script.jl


### Example Bash Script For Julia With Installed Packages

	#!/bin/bash

	# julia-job.sh

	# extract Julia tar.gz file and project tar.gz file
	tar -xzf julia-#.#.#-linux-x86_64.tar.gz
	tar -xzf my-project.tar.gz

	# add Julia binary to PATH
	export PATH=$_CONDOR_SCRATCH_DIR/julia-#.#.#/bin:$PATH
	# add Julia packages to DEPOT variable
	export JULIA_DEPOT_PATH=$_CONDOR_SCRATCH_DIR/my-project

	# run Julia script
	julia --project=my-project script.jl


## Create HTCondor Submit File 

After creating a bash script to run Julia, then create a submit file 
to submit the job. 

More details about setting up a submit file, including a submit file template, 
can be found in our quickstart guide: [Quickstart Tutorial](5000633410)

	# julia-job.sub
	
	executable = julia-job.sh

	transfer_input_files = julia-#.#.#-linux-x86_64.tar.gz, script.jl
	should_transfer_files   = Yes
	when_to_transfer_output = ON_EXIT

	output        = job.$(Cluster).$(Process).out
	error         = job.$(Cluster).$(Process).error
	log           = job.$(Cluster).$(Process).log

	requirements   = (OSGVO_OS_STRING == "RHEL 7")
	request_cpus   = 1
	request_memory = 2GB
	request_disk   = 2GB

	queue 1

If your Julia script needs to use packages installed for a project, 
be sure to include `my-project.tar.gz` as an input file in `julia-job.sub`. 
For project tarballs that are <100MB, you can follow the below example:

	transfer_input_files = julia-#.#.#-linux-x86_64.tar.gz, script.jl, my-project.tar.gz

Modify the CPU/memory request lines to match what is needed by the job. 
Test a few jobs for disk space/memory usage in order to make sure your 
requests for a large batch are accurate! Disk space and memory usage can be found in the 
log file after the job completes.
