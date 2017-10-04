[title]: - "The "tutorial" Command"

OSG Connect tutorials on Github
-------------------------------

All of the OSG Connect examples are available on
[Github](<https://github.com/OSGConnect/>).  These
tutorials are tested regularly and should just work. If you find a problem,
please send a report to [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org).

Tutorial commands
-----------------

From the OSG Connect login host **login.osgconnect.net**, the following tutorial
commands are available:

	$ tutorial
	$ tutorial list
	$ tutorial info <tutorial-name>
	$ tutorial <tutorial-name>

Install and setup a tutorial
----------------------------

On the OSG Connect login host **login.osgconnect.net**, create a directory, cd
to it, and invoke the command:

	$ tutorial <tutorial-name>

Available tutorials
-------------------

The OSG Connect login host (**login.osgconnect.net**) has the examples
pre-installed. To see what is available:


	$ tutorial list
	Currently available tutorials:
	R ..................... Estimate Pi using the R programming language
	blast .................
	cp2k .................. How-to for the electronic structure package CP2K
	dagman-namd ........... Launch a series of NAMD simulations via Condor DAG
	error101 .............. Use condor_q -better-analyze to analyze stuck jobs
	exitcode .............. Use HTCondor's periodic_release to retry failed jobs
	htcondor-transfer ..... Transfer data via HTCondor's own mechanisms
	namd .................. Run a molecular dynamics simulation using NAMD
	nelle-nemo ............ Running Nelle Nemo's goostats on the grid
	oasis-parrot .......... Software access with OASIS and Parrot
	octave ................ Matrix manipulation via the Octave programming language
	pegasus ............... An introduction to the Pegasus job workflow manager
	pegasus-namd .......... Pegasus workflow to run large scale simulations - NAMD examples
	photodemo ............. A complete analysis workflow using HTTP transfer
	quickstart ............ How to run your first OSG job
	root .................. Inspect ntuples using the ROOT analysis framework
	scaling ............... Learn to steer jobs to particular resources
	scaling-up-resources .. A simple multi-job demonstration
	software .............. Software access tutorial
	stash-chirp ........... Use the chirp I/O protocol for remote data access
	stash-http ............ Retrieve job input files from Stash via HTTP
	stash-namd ............ Provide input files for NAMD via Stash's HTTP interface
	swift ................. Introduction to the SWIFT parallel scripting language
  
  
  Enter "tutorial name-of-tutorial" to clone and try out a tutorial.

