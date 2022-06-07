[title]: - "Monitor and Review Jobs With condor_q and condor_history"

[TOC]

# Objectives
This guide discusses how to monitor jobs in the queue with `condor_q` and to review jobs that have recently left the queue with `condor_history`. 

# Monitor Queued Jobs with `condor_q` 

## Default `condor_q`
The default behavior of `condor_q` is to list all of a user's jobs currently in HTCondor's queue grouped into batches. A batch consists of all jobs submitted using a single submit file. For example: 

```
$ condor_q

-- Schedd: login05.osgconnect.net : <192.170.227.146:9618?... @ 03/04/22 12:31:45
OWNER     BATCH_NAME  SUBMITTED    DONE   RUN    IDLE  TOTAL JOB_IDS
alice ID: 21562536   3/4  12:31      _      _      5      5 21562536.0-4

Total for query: 5 jobs; 0 completed, 0 removed, 5 idle, 0 running, 0 held, 0 suspended 
Total for alice: 5 jobs; 0 completed, 0 removed, 5 idle, 0 running, 0 held, 0 suspended 
Total for all users: 4112 jobs; 0 completed, 0 removed, 76 idle, 904 running, 3132 held, 0 suspended
```


## Constraints for `condor_q`

`condor_q` can be used to list individual jobs associated with a username`<U>`, cluster ID `<C>`, or job ID `<J>` as indicated by `<U/C/J>`. 

Additionally, the flag `-nobatch` can be used to list individual jobs instead of batches of jobs using the format `condor_q <U/C/J> -nobatch`. 

```
$ condor_q alice -nobatch

-- Schedd: login05.osgconnect.net : <192.170.227.146:9618?... @ 03/04/22 12:52:22
 ID          OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD
21562638.0   alice            3/4  12:52   0+00:00:00 I  0    0.0 soilModel.py parameter1.csv
21562638.1   alice            3/4  12:52   0+00:00:00 I  0    0.0 soilModel.py parameter2.csv
21562638.2   alice            3/4  12:52   0+00:00:00 I  0    0.0 soilModel.py parameter3.csv
21562638.3   alice            3/4  12:52   0+00:00:00 I  0    0.0 soilModel.py parameter4.csv
21562638.4   alice            3/4  12:52   0+00:00:00 I  0    0.0 soilModel.py parameter5.csv

21562639.0   alice            3/4  12:52   0+00:00:00 I  0    0.0 wordcount.py Alice_in_Wonderland.tx
21562639.1   alice            3/4  12:52   0+00:00:00 I  0    0.0 wordcount.py Dracula.txt
21562639.2   alice            3/4  12:52   0+00:00:00 I  0    0.0 wordcount.py Huckleberry_Finn.txt
21562639.3   alice            3/4  12:52   0+00:00:00 I  0    0.0 wordcount.py Pride_and_Prejudice.tx
21562639.4   alice            3/4  12:52   0+00:00:00 I  0    0.0 wordcount.py Ulysses.txt
```

## View All Job Attributes 

Information about HTCondor jobs are saved as "job attributes". Job attributes can be viewed using the `-l` flag, a shorthand for `-long`. The output of  `condor_q  <U/C/J> -l` can be used to learn more about a job and to diagnose errors.  

Examples of job attributes listed when using `condor_q  <U/C/J> -l` are as follows:  

| Attribute      | Description |
| ----------- | ----------- |
| MemoryUsage   | Maximum memory that a job used in MB |
| DiskUsage   | Maximum disk space that a job used in KB |
| BatchName      | Job batch label       |
| MATCH_EXP_JOBGLIDEIN_ResourceName | Location of site at which a job is running |
| RemoteHost   | Location of ite and slot number where a job is running |
| ExitCode   | Exit code of a job upon its completion |
| HoldReason   | Human-readable message as to why a job was held. It can be used to determine if a job should be released or not. |
| HoldReasonCode   | Integer value that represents why a job was put on hold |
| JobNotification   | Integer indicating when the user should be emailed regarding a change of status for their job |
| RemotePool   | Name of the pool in which a job is running |
| NumRestarts   | Number of restarts carried out by a job |

Many additional attributes are provided by HTCondor to learn about your jobs, including attributes dedicated to workflows that utilize DAGman and containers.

For more information about these and other attributes, please see the [HTCondor Manual](https://htcondor.readthedocs.io/en/latest/classad-attributes/job-classad-attributes.html).


## Constraints for Job Attributes

To display only the output of specified attributes, it is possible to use the "auto format" flag denoted as `-af` with `condor_q <U/C/J>`. An example use case is to view the owner and location of the site where a given job, such as job ID `15244592.127`, is running by using:  

```
$ condor_q 15244592.127 -af Owner MATCH_EXP_JOBGLIDEIN_ResourceName 

alice BNL-ATLAS
```

In the above example, the `Owner` is the user alice and the job is running on resources owned by the Brookhaven National Laboratory as indicated by `BNL_ATLAS`.


## View Specific Job Attributes Across More Than One Job

It is possible to sort and filter the output for one or more job attributes across a batch of jobs. When investigating more than one job, it is advantageous to limit the print out to a certain number of jobs to avoid flooding your screen. To limit the output to a specified number of jobs, use `-limit N` and replace N with the number of jobs you would like to view. For example, to view the site location where 100 jobs belonging to batch `12245532` ran, you can use: 
 
```
$ condor_q 12245532 -limit 100 -af MATCH_EXP_JOBGLIDEIN_ResourceName | sort | uniq -c

      9 Crane
      4 LSU-DB-CE1
      4 ND-CAML_gpu
     71 Rice-RAPID-Backfill
      2 SDSC-PRP-CE1
      6 TCNJ-ELSA
      1 Tufts-Cluster
      3 WSU-GRID
```

In this example, 71 jobs ran at Rice University (Rice-RAPID-Backfill) while only one job ran at Tufts University (Tufts-Cluster). If you would like to know which abbreviations correspond to which compute resource provider in the OSPool, [contact a Research Computing Facilitator](https://support.opensciencegrid.org/support/solutions/articles/12000084585-get-help-). 


## View Jobs that are Held
To isolate and print out held jobs, use `condor_q <U/C/J> -held`. The this command will print jobs currently in the "Held" state and will not print jobs that are in the "Run", "Done", or "Idle" states. 

Using the job ads and constraints described above, it is possible to print out the reasons why a subset of a user's jobs are being held.

``` 
$ condor_q alice -held -af HoldReason | sort | uniq -c
      4 Error from glidein_3439920_345771664@c6-6-39-2.aglt2.org: SHADOW at 192.170.227.166 failed to send file(s) to <192.41.230.81:44309>: error reading from /home/alice/InputData.txt: (errno 2) No such file or directory; STARTER failed to receive file(s) from <192.170.227.166:9618>
      1 Job in status 2 put on hold by SYSTEM_PERIODIC_HOLD due to memory usage 10572684.
```

In the output above, four jobs were place on hold due to a "missing file or directory" in the path of `/home/alice/InputData.txt` that was specified in the `transfer_input_files` line of the submit file. Because HTCondor could not locate this input (possibly due to an incorrect file path), the job was placed on hold. Additionally, one job was placed on hold due to exceeding the requested memory specified in the submit file. 

An in-depth guide on troubleshooting issues with held jobs on the OSPool is currently in progress. The link to that guide will be added here once it is available. 


## View Machine Matches for a Job
The `-analyze` and `-better-analyze` options can be used to view the number of machines that match to a job. These flags are often used to diagnose many problems, including understanding why a job has not started running. 

A portion of the output from these options shows the number of machines in the pool and how many of these are able to run your job:

```
21607747.000:  Run analysis summary ignoring user priority.  Of 2189 machines,
   1605 are rejected by your job's requirements
     53 reject your job because of their own requirements
      1 match and are already running your jobs
      0 match but are serving other users
    530 are able to run your job
```

Additional output of these options include the requirements line of the job's submit file, last successful match date, hold reason messages, and other useful information. 

The `-analyze` and `-better-analyze` options deliver similar output, however, `-better-analyze` is a newer feature that provides additional information including the number of slots matched by your job given the different requirements specified in the submit file.  

Additional information on using `-analyze` and `-better-analyze` for troubleshooting will be available in our troubleshooting guide in the near future. 

# Review Job History with `condor_history`

## Default `condor_history`

Somewhat similar to `condor_q`, which shows jobs currently in the queue, `condor_history` is used to show information about jobs that have recently left the queue. 

By default, `condor_history` will show every user's job that HTCondor still has a record of in its history. Because HTCondor jobs are constantly being sent to the queue on OSG Connect Access Points, HTCondor cleans its history of jobs every few days to free up space for new jobs that have recently left the queue. Once a job is cleaned from HTCondor's history, it is removed permanently from the queue. 

Before a job is cleaned from HTCondor's queue, `condor_history` can be valuable for learning about recently completed jobs. 

As previously stated, `condor_history` without any additional flags will list every user's job, which can be thousands of lines long. To exit this behavior, use `control + C`. In most cases, it is recommended to combine `condor_history` with one or more of the options below to help limit the output of this command to only the desired information. 

## Constrain Your `condor_history` Query

Like `condor_q`, it is possible to limit the output of your `condor_history` query by user `<U>`, cluster ID `<C>`, and job ID `<J>` as indicated by (`<U/C/J>`). By default, HTCondor will continue to search through its history of jobs by the option it is constrained by. Since HTCondor's history is extensive, this means your command line prompt will not be returned to you until HTCondor has finished its search and analysis of its entire history. To prevent this time-consuming behavior from occurring, we recommend using the `-limit N` flag with `condor_history`. This will tell HTCondor to limit its search to the first `N` items that appear matching its constraint. For example, `condor_history alice -limit 20` will return the `condor_history` output of the user alice's 20 most recently submitted jobs.

## Viewing and Constraining Job Attributes

Displaying the list of job attributes using `-l` and `-af` can also be used with `condor_history`.

It is important to note that some attributes are renamed when a job exits the queue and enters HTCondor's history. For example, `RemoteHost` is renamed to `LastRemoteHost` and `HoldReason` will become `LastHoldReason`. 

## Special Considerations

Although many options that exist for `condor_q` also exist for `condor_history`, some do not. For example, `-analyze` and `-better-analyze` cannot be used with `condor_history`. Additionally, `-hold` cannot be used with `condor_history` as no job in HTCondor's history can be in the held state. 

# More Information on Options for `condor_q` and `condor_history`
A full list of the options for `condor_q` and `condor_history` may be listed by using combining them with the `–-help` flag or by viewing the [HTCondor manual](https://htcondor.readthedocs.io/en/latest/users-manual/index.html).


