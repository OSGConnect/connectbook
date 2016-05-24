[title]: - "Troubleshooting jobs using the Connect Client"

[TOC]

## Identifying jobs with problems
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
	1234.8   username             4/29 16:42   0+00:00:49 H  0   0.0  short.sh
	1234.9   username             4/29 16:42   0+00:00:49 H  0   0.0  short.sh

	10 jobs; 0 completed, 0 removed, 3 idle, 5 running, 2 held, 0 suspended

Notice that the last two jobs have a state (the ST column) of H.  This indicates that the jobs 
encountered some sort of problem and have been held.  Jobs that are held remain in a suspended 
state in the system and are not run.  

## Troubleshooting job errors

In order to troubleshoot jobs, you'll need to use the `connect shell` command as follows:

   $ connect shell
   [connected to connect://connectusername@connect-client.osgconnect.net/connectusername; ^D to disconnect]
   sh-4.1$

Once this is done, you can use `condor_q` or `condor_ssh_to_job` to troubleshoot a job that's
having problems.

### Diagnostics with condor_q

The `condor_q` command shows the status of the jobs and it can be used 
to diagnose why jobs are not running. Using the `-better-analyze` or `-analyze` flag 
with `condor_q` can show you detailed information about why a job isn't 
starting. 

	sh-4.1$ condor_q -better-analyze JOB-ID 

This will indicate why the job is being held.  Often times, the problem
is due to missing input or output files.  If that's the case, you should
check your submit files to make sure that you have the correct filenames for
inputs and ouputs.

### condor_ssh_to_job
This command allows you to `ssh` to the compute node where the job is
running. After running `condor_ssh_to_job`, you will be connected to
the remote system, and you will be able to use normal shell commands to
investigate your job.

	sh-4.1$ condor_ssh_to_job JOB-ID  


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

