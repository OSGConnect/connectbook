[title]: - "Using the Connect Client"

[TOC]

# Connect Client commands

For a list of available commands, enter `connect` from the command line:

	$ connect 
	This is Connect Client v0.4.3
	usage: connect [opts] <subcommand> [args]
	       connect [opts] dag <dagfile>
	       connect [opts] histogram 
	       connect [opts] history <condor_history arguments>
	       connect [opts] list [-v]
	       connect [opts] modules 
	       connect [opts] pull [-t|--time] [-v|--verbose] [-w|--where] [repository-dir]
	       connect [opts] push [-t|--time] [-v|--verbose] [-w|--where] [repository-dir]
	       connect [opts] q <condor_q arguments>
	       connect [opts] revoke 
	       connect [opts] rm <condor_rm arguments>
	       connect [opts] run <condor_run arguments>
	       connect [opts] setup [--replace-keys] [--update-keys] [user][@servername]
	       connect [opts] shell [command]
	       connect [opts] status <condor_status arguments>
	       connect [opts] submit <submitfile>
	       connect [opts] sync [-t|--time] [-v|--verbose] [-w|--where] [repository-dir]
	       connect [opts] test  
	       connect [opts] version 
	       connect [opts] wait <condor_wait arguments>

To run any of these commands, just enter `connect [opts] [command name]`.


# First-time setup

The first time you use the Connect Client from a given computer or
cluster, you will need to run the `setup` command to prepare your
remote access to Connect services.  You will need the username
and password you used to register for OSG Connect.  (If you have not
previously [registered for OSG Connect][register], please do that
first.)

[register]: http://support.opensciencegrid.org/solution/categories/5000160799/folders/5000260743/articles/5000632072

To set up the client, simply run `connect setup username`, where
`username` is your OSG Connect user name.  (If it's the same as
your local user name you may omit this.)  You will be prompted
for a password, then your remote access will be ready.

	$ connect setup
	Please enter the user name that you created during Connect registration.
	When you visit http://osgconnect.net/ and log in, your user name appears
	in the upper right corner: note that it consists only of letters and
	numbers, with no @ symbol.
	
	You will be connecting via the login.ci-connect.uchicago.edu server.
	Enter your Connect username: *your OSG Connect username goes here*
	Password for remote-username@connect-client.osgconnect.net: 
	notice: Ongoing client access has been authorized at connect-client.osgconnect.net.
	notice: Use "connect test" to verify access.
	
	$ connect test
	Success! Your client access to connect-client.osgconnect.net is working.


> N.B. `connect-client.osgconnect.net` is the default server name for OSG
> Connect users.  If you are using a different CI Connect service, such as
> ATLAS Connect, CMS Connect, etc., please check that site's documentation
> for setup instructions.  Your setup command may be slightly different.

If for some reason your access stops working, you can rerun setup again
any time.  Just provide the additional `--replace-keys` option:

	$ connect setup --replace-keys remote-username

The Connect Client will "remember" your server name and OSG Connect user
name.  You won't need to use this information again from this client.
(You do need to run `setup` for each distinct computer or cluster you
work from, though: for example, once from your HPC site and once from
your laptop.)


# Example submission

Now let's create a test script for execution of 10 jobs on the OSG.
Create a working directory (and logfile subdirectory) that will be
synched with the remote host on the OSG Connect server.  

	$ cd
	$ tutorial quickstart
	Installing quickstart (osg)...
	Tutorial files installed in ./tutorial-quickstart.
	Running setup in ./tutorial-quickstart...
	$ cd tutorial-quickstart
	$ cat short.sh

Here is the short.sh script:

	#!/bin/bash
	# short.sh: a short discovery job 
	
	printf "Start time: "; /bin/date 
	printf "Job is running on node: "; /bin/hostname 
	printf "Job running as user: "; /usr/bin/id 
	printf "Job is running in directory: "; /bin/pwd 
	
	echo
	echo "Working hard..."
	sleep ${1-15}
	echo "Science complete!"

Make the script executable.

	$ chmod +x short.sh


## Create the HTCondor submit description file

This tutorial is part of the greater [ConnectBook], which has many
illustrations of distributed computation jobs. We'll sample just one
here to show how to execute tutorials using Connect Client.

The `tutorial02.submit` file is a good foundation. Let's edit it, changing
it from 25 jobs to just 10:

	$ nano tutorial.submit

The submit file should contain the following:

	Universe = vanilla 

	Executable = short.sh 

	Error = log/job.error.$(Cluster)-$(Process) 
	Output = log/job.output.$(Cluster)-$(Process) 
	Log = log/job.log.$(Cluster) 

	Queue 25

Change `Queue 25` to `Queue 10`. This will create 10 instances of your
`short.sh` job.

In an HTCondor submit file, `$(Cluster)` labels the submission task
(called "Cluster ID") and `$(Process)` labels individual jobs in the
task. This submit file thus directs logs for each job into files in the
`log/` directory. You'll see the relevance of this further on.

## Submit the script

Submit the script using `connect submit tutorial02.submit`.  You
must invoke connect client commands from the working directory.

	$ connect submit tutorial02.submit
	.++.++++++.+
	7 objects sent; 3 objects up to date; 0 errors
	Submitting job(s)..........
	10 job(s) submitted to cluster 880.
	............
	0 objects sent; 12 objects up to date; 0 errors

The lines of dots and pluses indicate file transfer status.  Each `+`
is a file or directory transferred from your client to the Connect
server.  Each `.` is a file or directory that's up to date already.
This file synchronization runs before your job is submitted (a _push_)
to ensure that the server has current information, and again after
submission in case the act of submitting the work creates new files.


## Check job queue
The `connect q` command tells the status of submitted jobs:

	$ connect q <osgconnect-username>

	-- Submitter: login01.osgconnect.net : <192.170.227.195:40814> : login01.osgconnect.net
 	ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD
	1234.0   username             4/29 16:42   0+00:00:00 I  0   0.0  short.sh
	1234.1   username             4/29 16:42   0+00:00:00 I  0   0.0  short.sh
	1234.2   username             4/29 16:42   0+00:00:49 R  0   0.0  short.sh
	1234.3   username             4/29 16:42   0+00:00:49 R  0   0.0  short.sh
	1234.4   username             4/29 16:42   0+00:00:49 R  0   0.0  short.sh
	1234.5   username             4/29 16:42   0+00:00:00 I  0   0.0  short.sh
	1234.6   username             4/29 16:42   0+00:00:49 R  0   0.0  short.sh
	1234.7   username             4/29 16:42   0+00:00:49 R  0   0.0  short.sh
	1234.8   username             4/29 16:42   0+00:00:49 R  0   0.0  short.sh
	1234.9   username             4/29 16:42   0+00:00:49 R  0   0.0  short.sh

	10 jobs; 0 completed, 0 removed, 3 idle, 7 running, 0 held, 0 suspended


## Retrieve outputs

Once your job is complete, or if it is not yet complete but you want to
review partial progress, you'll want to retrieve job outputs from the
connect server.  Do that using `connect pull`.

	$ connect pull
	..+++........+++++++++++++++++++++
	24 objects retrieved; 10 objects up to date; 0 errors

Again, the plusses and dots tell you how much file transfer activity
occurred.


## Check the job output

Once your jobs have finished, you can look at the files that HTCondor has
returned to the working directory. If everything was successful, it
should have returned in the `~/tutorial-quickstart/log` directory:

  * log files from Condor for the job cluster:  `job.log.$(Cluster).$(Process)`
  * output files for each job's output: `job.output.$(Cluster).$(Process)`
  * error files for each job's errors: `job.error.$(Cluster).$(Process)`

where `$(Cluster)` will be an integer number (typically a large number)
for this specific submission, and `$(Process)` will number 0...9.

Read one of the output files. It should look something like this:

	$ cat job.output.1234.0
	Start time: Wed Apr 29 17:44:36 EDT 2015
	Job is running on node: MAX-EDLASCH-S3-its-u12-nfs-20141003
	Job running as user: uid=1066(osgconnect) gid=502(condoruser) groups=502(condoruser),108(fuse)
	Job is running in directory: /tmp/rcc_syracuse/rcc.1bNeUskyJl/execute.10.5.70.108-1098/dir_2553

	Working hard...
	Science complete!
	
For this example we see the first job in the submission (1234.0) ran on a free node at Syracuse University.


## Job history

Once your jobs have finished, you can get information about their
execution from the `connect history` command. In this example:


	$ connect history 1234
 	ID     OWNER          SUBMITTED   RUN_TIME     ST COMPLETED   CMD
	1234.5   username             4/29 16:42   0+00:00:27 C   4/29 16:45 /home/...
	1234.4   username             4/29 16:42   0+00:01:18 C   4/29 16:45 /home/...
	1234.1   username             4/29 16:42   0+00:00:27 C   4/29 16:45 /home/...
	1234.0   username             4/29 16:42   0+00:00:27 C   4/29 16:45 /home/...
	1234.6   username             4/29 16:42   0+00:00:52 C   4/29 16:44 /home/...
	1234.8   username             4/29 16:42   0+00:00:52 C   4/29 16:44 /home/...
	1234.7   username             4/29 16:42   0+00:00:52 C   4/29 16:44 /home/...
	1234.9   username             4/29 16:42   0+00:00:51 C   4/29 16:44 /home/...
	1234.2   username             4/29 16:42   0+00:00:51 C   4/29 16:44 /home/...
	1234.3   username             4/29 16:42   0+00:00:51 C   4/29 16:44 /home/...


Note: You can see much more information about status
using the -long option (e.g. ```connect history -long 1234```).


# Job storage and synchronization

So far we haven't explained in detail what really happens when you use
the Connect Client to interact with OSG Connect.  Let's get a little
deeper into that.

All the files associated with any given workload are stored together
in a directory.  Coining a term, we call this the _job repository_ or
_job repo_.  A single job repo should contain enough information for
OSG Connect to submit work to the grid.  Every job repo must have an
HTCondor submit file.  Beyond that, there could be input data, state
metadata, code, supplementary libraries, documentation, output...
anything that might be related.  Some jobs might pull inputs from
another location (e.g. Stash or another web site), and not have any
inputs in the job repo.  Some jobs will deliver output some other place.
Some will bring their code along, while others will load job code from
shared filesystems (e.g. OASIS).  There is a lot of variability that our
tutorials will help you explore.

One thing is constant, however: not only does your job repo exist where
you log in, it _also_ must exist on the OSG Connect service.  Keeping
your local copy of the job repo in sync with the server copy is a
primary task of the Connect Client.


## Working with multiple repositories

Most users will have several job repos that they use, either serially or
in parallel.  The Connect Client must keep these separate.  You separate
job repos on the client simply by keeping different jobs in different
directories, but on the server, the Connect Client must manage these job
repos.  The client does not control or advise the server's management of
job repos; they simply exist, and have names that correspond to their
directory names on the client system.

> _N.B. Currently, the client is unable to differentiate separate job
> repos with the same name.  This will be addressed in a future version
> of the software._

How do you know what repos you have?  If you only use one client system,
and you keep your work very well organized, this may be a simple matter.
But in case you need a reminder of what the server knows about, you
can obtain a listing with `connect list`:

	$ connect list
	connect-client
	connectbook
	ratchet
	tutorial-quickstart
	tz

Add the `-v` option to see more detail (this makes the listing a
touch slower):

	$ connect list -v
	connect-client   [51 files, 158m total]
	connectbook   [1 files, 20b total]
	ratchet   [0 files, 0b total]
	tutorial-quickstart   [2 files, 14k total]
	tz   [1 files, 11b total]


# Data handling

We've already seen how to update the local job repository using `connect
pull`, retrieving all files and outputs modified by the running job.

## Updating the remote

You can also use `connect push` to update the server's copy of your
job.  It works exactly like `connect pull` does, but goes in the other
direction.  (As you suspect, `connect push` is done implicitly each time
you `connect submit`.)


## Additional options

If you need performance metrics on data transfer, you can add `-t` or
`--time` to a `push` or `pull` command.

If you want to see the name of each file transferred, add the
`-v` or `--verbose` option.


## Transfer using external tools

In general, for smaller quantities of data, we recommend staying with
`connect push` and `connect pull` for data transfer to your jobs.
But there are cases, typically involving either a large number of
separate files or a large net quantity of data, where you will want
to send or retrieve data using something more efficient, like Globus.
To do that, you need to know where your job is stored on the OSG
Connect server.  `connect push -w` or `connect push --where` will
tell you that.  (It also works for `pull`.)

	$ pwd
	/home/dgc/projects/ratchet
	
	$ connect push -w
	/stash/user/dgc/ratchet
	
	$ connect pull --where
	/stash/user/dgc/ratchet


# Special tasks and preparations: `connect shell`

In some cases it's useful or necessary to be able to work with your job
_on the server itself_.  For example, you might have code that must be
compiled before submission, and you want to ensure compatibility with
the OSG by compiling it on OSG Connect instead of locally.

For cases like this, there is `connect shell`.  This command gives you
an immediate (bash) login shell on the OSG Connect server, with your
home directory set to the job repo directory -- right away you'll see
your job files there.

	$ cd tutorial-quickstart
	$ connect shell
	
	[connected to connect://dgc@connect-client.osgconnect.net/tutorial-quickstart; ^D to disconnect]
	sh-4.1$ ls
	README.md  job.log     log	 test		    tutorial02.submit
	job.error  job.output  short.sh  tutorial01.submit  tutorial03.submit

This is a full-fledged shell -- do whatever you need to do to prepare
your job.  When you're done, log out with `exit` or by pressing
control-D.  A `connect pull` will fetch anything you changed while
shelled in, and bring it back to your local system.

You can also use `connect shell` for one-off commands, like ssh.

	$ connect shell uname -a
	Linux login02.osgconnect.net 3.18.13-UL1.el6 #2 SMP Fri May 15 09:34:50 CDT 2015 x86_64 x86_64 x86_64 GNU/Linux


# Runtime information

There may be times that it's useful to know more about your copy of the
Connect Client, the system that it is running on, or the user account
it's running under.  There's a command for that:

	$ connect version
	Client information:
	| Connect client version: v0.4.3
	| Python version: 2.7.10 (default, May 30 2015, 23:49:24) 
	|   [GCC 4.2.1 Compatible Apple LLVM 6.1.0 (clang-602.0.53)]
	| Prefix: /opt/local/Library/Frameworks/Python.framework/Versions/2.7
	| User profile: [dgc@connect-client.osgconnect.net: user=dgc, server=connect-client.osgconnect.net]
	
	System:
	| Darwin paranoia 14.3.0 Darwin Kernel Version 14.3.0: Mon Mar 23 11:59:05 PDT 2015; root:xnu-2782.20.48~5/RELEASE_X86_64 x86_64
	|  3:50  up 14 days, 10:23, 4 users, load averages: 3.24 3.36 3.32

In this case, I'm running the client on my Macbook, using MacPorts.
The "user profile" information tells what remote account the client
remembers your using last.  It will reuse this account information for
the next server interaction.


# Getting Help
For assistance or questions, please email the OSG User Support team at
`user-support@opensciencegrid.org`, direct message tweet to
[@osgusers](http://twitter.com/osgusers) or visit the [help desk and
community forums](http://support.opensciencegrid.org).


[CI Connect]:http://ci-connect.net/
[OSG Connect]:http://osgconnect.net/
[HTCondor]:http://research.cs.wisc.edu/htcondor/
[Open Science Grid]:http://www.opensciencegrid.org/
[signed up for an account]:http://osgconnect.net/signup
[ConnectBook]:http://osgconnect.net/book

