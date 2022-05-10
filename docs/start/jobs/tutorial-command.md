Use OSG Connect Tutorials 
====================================

[TOC]

OSG Connect tutorials on Github
-------------------------------

All of the OSG Connect tutorials are available as repositories on
[Github](<https://github.com/OSGConnect/>). These
tutorials are tested regularly and should work as is, but if 
you experience any issues please contact us. 

Tutorial commands
-----------------

From the OSG Connect login node, the following tutorial
commands are available:

	$ tutorial
	$ tutorial list
	$ tutorial info <tutorial-name>
	$ tutorial <tutorial-name>

Available tutorials
-------------------

The OSG Connect login nodes have the following tutorials 
pre-installed. To see what is available:

	$ tutorial list
	Currently available tutorials:
	R ...................... Estimate Pi using the R programming language
	R-addlibSNA ............ Shows how to add R external libraries for the R jobs on the OSG
	ScalingUp-Python ....... Scaling up compute resources - Python example to optimize a function on grid points
	annex .................. None
	blast-split ............ How to run BLAST on the OSG by splitting a large input file
	connect-client ......... Demonstrates how to use the connect client for remote job submission
	dagman-wordfreq ........ DAGMan based wordfreq example
	dagman-wordfreq-stash .. DAGMan based wordfreq - data from stash
	error101 ............... Use condor_q -better-analyze to analyze stuck jobs
	exitcode ............... Use HTCondor's periodic_release to retry failed jobs
	htcondor-transfer ...... Transfer data via HTCondor's own mechanisms
	matlab-HelloWorld ...... Creating standalone MATLAB application - Hello World 
	nelle-nemo ............. Running Nelle Nemo's goostats on the grid
	oasis-parrot ........... Software access with OASIS and Parrot
	octave ................. Matrix manipulation via the Octave programming language
	osg-locations .......... Tutorial based on OSG location exercise from the User School
	pegasus ................ An introduction to the Pegasus job workflow manager
	photodemo .............. A complete analysis workflow using HTTP transfer
	quickstart ............. How to run your first OSG job
	root ................... Inspect ntuples using the ROOT analysis framework
	scaling ................ Learn to steer jobs to particular resources
	scaling-up-resources ... A simple multi-job demonstration
	software ............... Software access tutorial
	stash-cvmfs ............ Shows how to use stash-cvmfs for input data transfer
	stash-http ............. Retrieve job input files from Stash via HTTP
	tensorflow-matmul ...... Tensorflow math operations as a singularity container job on the OSG - matrix multiplication
  
Install and setup a tutorial
----------------------------

On the OSG Connect login node, create a directory, `cd`
to it, and invoke the command:

	$ tutorial <tutorial-name>
  
This command will clone the tutorial repository to your current working directory.
`cd` to the repository directory and follow the steps described in the `readme.md` file.
Alternatively, you can view the `readme.md` file at the tutorial's corresponding GitHub page.

