[title]: - "Indicate the Duration Category of Your Jobs"

[TOC]
## Indicate the Duration Category of Your Jobs
To maximize the value of the capacity contributed by the different organizations to the Open Science Pool (OSPool), 
users are requested to identify one of three duration categories for their jobs. These categories should be selected based upon test 
jobs (run on the OSPool) and allow for more effective scheduling of the capacity contributed to the pool,
honoring the community’s shared responsibility for efficient use of the contributed resources. As a reminder, 
[jobs with single executions longer than 20 hours in tests on the OSPool should not be submitted](5000632058), without 
self-checkpointing (see further below).

Beginning Nov 16 of 2021, every job submitted via an OSG Connect access point must 
be labeled with a **Job Duration Category** upon submission.
By knowing the expected duration, the OSG is working to be able to direct longer-running jobs to resources that are 
faster and are interrupted less, while shorter jobs can run across more of the OSPool.

## Specifying a Job Duration Category
The JobDurationCategory must be listed anywhere prior to the final ‘queue’ statement of the submit file, as below:

    +JobDurationCategory = “Long”
   
| **JobDurationCategory** | **Expected Job Duration** | Maximum Allowed Duration |
|:---------|:------------|:-------------|
| <span style="white-space: nowrap">Medium (default)</span> | <span style="white-space: nowrap"><10 hrs</span> | 20 hrs |
| <span style="white-space: nowrap">Long</span> | <span style="white-space: nowrap"><20 hrs</span> | 40 hrs |


If the user does not indicate a JobDurationCategory in the submit file, the relevant job(s) will be 
labeled as **Medium** by default. **Batches with jobs that individually execute for longer than 20 hours
are not a good fit for the OSPool**. *If your jobs are self-checkpointing,
see “Self-Checkpointing Jobs”, further below.*
 
## Testing Jobs for Expected Duration
    
As part of the [preparation for running a full-scale job batch](https://support.opensciencegrid.org/support/solutions/articles/12000076552-always-test-a-few-jobs-before-submitting-many), 
users should test a small subset (~10) of their jobs with the **Medium** or **Long** categories, 
and then review actual job durations in the job log files. 
If the user expects potentially significant variation in job durations within a single batch 
(even if tested on identical computers), a longer JobDurationCategory may be warranted relative to the duration of test jobs. Or, if variations in job duration may be predictable, the user may choose to submit different 
subsets of jobs with different Job Duration Categories.

## Maximum Allowed Duration

Jobs in each category will be placed on hold in the queue if they run longer than their Maximum Allowed Duration 
(starting Tuesday, Nov 16). In that case, the user may remove and resubmit the jobs, identifying a longer category. 

**Jobs that test as longer than 20 hours are not a good fit for the OSPool resources, and should not be submitted prior to contacting** 
[support@opensciencegrid.org](mailto:support@opensciencegrid.org) **to discuss options**. The Maximum Allowed Durations 
are longer than the Expected Job Durations in order to accommodate CPU speed variations across OSPool computing resources, 
as well as other contributions to job duration that may not be apparent in smaller test batches. 
Similarly, **Long** jobs held after running longer 
than 40 hours represent significant wasted capacity and should never be released or resubmitted by the user without
first taking steps to modify and test the jobs to run shorter.

## Self-Checkpointing Jobs

Jobs that [self-checkpoint](https://htcondor.readthedocs.io/en/latest/users-manual/self-checkpointing-applications.html)
at least every 10 hours are an excellent way for users to run jobs that would otherwise be longer in total execution time
than the durations listed above. Jobs that complete a checkpoint at least as often as allowed for their JobDurationCategory will not be held.

We are excited to help you think through and implement self-checkpointing. Get in touch via support@opensciencegrid.org if you have questions.
