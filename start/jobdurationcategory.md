[title]: - "Indicate the Duration Category of Your Jobs"

[TOC]
## Indicate the Duration Category of Your Jobs
To maximize the value of the capacity contributed by the different organizations to the Open Science Pool (OSPool), 
users are requested to identify one of three duration categories for their jobs. These categories should be selected based upon test 
jobs and allow for more effective scheduling of the capacity contributed to the pool,
honoring the community’s shared responsibility for efficient use of the contributed resources.

Every job submitted via an OSG Connect access point must be labeled a job duration category.
Users can identify one of three **Job Duration Categories** when submitting a job.
By knowing the expected duration, the OSG is working to be able to direct longer-running jobs to resources that are faster and interrupt less,
while shorter jobs can run across more of the OSPool.

## Specifying a Job Duration Category
Job submit files should list the JobDurationCategory anywhere prior to the final ‘queue’ statement, as below:

    +JobDurationCategory = “Medium”
   
| **Category** | **Expected Job Duration** | **Maximum Allowed Duration** |
|:---------|:------------|:-------------|
| <span style="white-space: nowrap">Medium (default)</span> | <span style="white-space: nowrap"><10 hrs</span> | 20 hrs |
| <span style="white-space: nowrap">Long</span> | <span style="white-space: nowrap"><20 hrs</span> | 40 hrs |

If the user does not provide an estimate for the job’s execution time, the relevant job(s) will be 
labeled as **Medium** by default. **Batches with jobs that individually execute for longer than 20 hours
are not a good fit for the OSPool** (see “Maximum Allowed Duration”, further below). *If your jobs are self-checkpointing,
see “Self-Checkpointing Jobs”, further below for additional flagging.*
 
## Testing Jobs for Expected Duration
As part of the [preparation for running a full-scale job batch](https://support.opensciencegrid.org/support/solutions/articles/12000076552-always-test-a-few-jobs-before-submitting-many), users should test a small set (<10) 
of their jobs with the **Medium** or **Long** categories, and then review actual job durations in the job log files or by using the ‘condor_history’ command. 
If the user expects potentially significant variation in job durations within a single batch (even if running jobs on identical computers), a longer Job Duration
Category may be warranted relative to the duration of test jobs. Or, if variations in job duration may be predictable, the user may choose to submit different 
subsets of jobs to different Job Duration Categories.

## Maximum Allowed Duration
Jobs in each category will be placed on hold in the queue if they run longer than their Maximum Allowed Duration 
(starting Tuesday, Nov 16). In that case, the user may remove and resubmit the jobs, identifying a longer category. 

**Jobs that test as longer than 20 hours are not a good fit for the OSPool resources, and should not be submitted prior to contacting** 
[support@opensciencegrid.org](mailto:support@opensciencegrid.org) **to discuss options**. The Maximum Allowed Durations 
are longer than the Expected Job Durations in order to accommodate CPU speed variations across OSPool computing resources, 
as well as other contributions to job duration that may not be apparent in smaller test batches. **Long** jobs held for running longer 
than 40 hours represent significant wasted capacity and should never be released or resubmitted by the user without
first taking steps to modify and test the jobs to run shorter. 

## Self-Checkpointing Jobs
Jobs that [self-checkpoint](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html)
at least every 10 hours are an excellent way for users to run jobs that would otherwise be longer in total execution time
than the durations listed above. For such jobs, please include both of the below options in your submit file:

    +JobDurationCategory = Medium
    +IsSelfCheckpointing = true

We are excited to help you think through and implement self-checkpointing
