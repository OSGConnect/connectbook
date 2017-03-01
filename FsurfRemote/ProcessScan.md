[title]: - "Using Fsurf"
[TOC]


## Overview

In this section, we will demonstrate how to use the `fsurf` utility to analyze
brain scans. 

**Important note on data privacy**:  In order to protect the privacy of your
participants’ scans, we request that you submit only defaced and fully
deidentified scans for processing by fsurf.  Images can be anonymized and
deidentified before they are uploaded to OSG servers as described in [the
article on anonymizing images](https://support.opensciencegrid.org/support/solutions/articles/12000008493-anonymizing-images).

## Get a Sample MRI file

Type the following to get a sample MRI file, 

     $ curl -L -o MRN_3_defaced.mgz 'http://stash.osgconnect.net/+fsurf/MRN_3_defaced.mgz'

`MRN_3_defaced.mgz` is an MRI file that has already been defaced and anonymized. 

## Performing a Standard Image Reconstruction

A typical image reconstruction with FreeSurfer requires the execution of
autorecon1, autorecon2, and autorecon3 on MRI scan.  All three steps are handled
by `fsurf`. 

Now we will create a workflow to process `MRN_3_defaced.mgz` using `fsurf`. In the
file `MRN_3_defaced.mgz`, the prefix `MRN_3` is the name of the subject. 


     $ ./fsurf submit --subject='MRN_3' --input='MRN_3_defaced.mgz'

`MRN_3_defaced.mgz` image is already deidentified and defaced, so say `y` to the
following questions. 

     Has the MRI data been deidentified (This is required) [y/n]? y 
     Has the MRI data been defaced (This is recommended) [y/n]? y

After typing `y` to the above two questions, `fsurf` creates and submits the
workflow

     Creating and submitting workflow
     Workflow 97 created
     Uploading input files
     Uploading MRN_3_defaced.mgz (file 1/1)
     Uploaded MRN_3_defaced.mgz successfully


The ID of your workflow is `97`. The ID is needed to check the status, remove
and get the output of the workflow. 


## Combining Multiple Scans of a Subject For a Single Reconstruction

In addition to the standard image reconstruction, FreeSurfer can also run the
autorecon1, autorecon2, and autorecon3 steps with multiple MGZ files from the
same subject.  This allows FreeSurfer to combine the scans to give a higher
quality result.  This section shows how to run this workflow.

We will create a workflow to process `MRN_3` subject using `fsurf` and multiple
input files. We'll assume that the input files for `MRN_3` are called
`MRN_3_defaced1.mgz`, and `MRN_3_defaced2.mgz`.

     $ ./fsurf submit --subject='MRN_3' --input='MRN_3_defaced1.mgz' --input='MRN_3_defaced2.mgz'

The images should already be deidentified and defaced, so say `y` to the
following questions. 

     Has the MRI data been deidentified (This is required) [y/n]? y 
     Has the MRI data been defaced (This is recommended) [y/n]? y

After typing `y` to the above two questions, `fsurf` creates and submits the
workflow 

     Creating and submitting workflow
     Workflow 98 created
     Uploading input files
     Uploading MRN_3_defaced1.mgz (file 1/2)
     Uploaded MRN_3_defaced1.mgz successfully
     Uploading MRN_3_defaced2.mgz (file 2/2)
     Uploaded MRN_3_defaced2.mgz successfully

The ID of your workflow is `98`. The ID is needed to check the status, remove
and get the output of the workflow. 

## Running recon-all With Custom Options

### Generating Subject Directory Files

Running a recon-all workflow with custom options requires a different input then 
the prior workflows.  This workflow requires a zip file with the contents of the 
subject directory that FreeSurfer uses. This subject directory file can be
generated from a MGZ file or from an existing subject directory in FreeSurfer.

#### Getting a Subject Directory File From a MGZ File

If you are starting with a MRI scan in mgz format,
you can run `recon-all -s SUBJECT -i SUBJECT_FILE` where `SUBJECT` is
the subject name (e.g. `MRN_3`) and `SUBJECT_FILE` is the name of the scan file
(e.g. `MRN_3_defaced.mgz`).  Once recon-all has completed, do the following:

     $ cd SUBJECTS_DIR
     $ zip -r SUBJECT_FILE.zip SUBJECT_NAME

Here `SUBJECTS_DIR` should be the location of the FreeSurfer subjects directory,
`SUBJECT_FILE` is the name that you'd like to use for the input file, and
`SUBJECT_NAME` is the subject name.

#### Getting a Subject Directory File From FreeSurfer 
If you have already done some processing of the subject using FreeSurfer,
then you can just do the following:

     $ cd SUBJECTS_DIR
     $ zip -r SUBJECT_FILE.zip SUBJECT_NAME

Here `SUBJECTS_DIR` should be the location of the FreeSurfer subjects directory,
`SUBJECT_FILE` is the name that you'd like to use for the input file, and
`SUBJECT_NAME` is the subject name.

### Running the Custom Workflow

 Fsurf also allows users to run recon-all with a set of custom options. Users can use this
workflow to run unique FreeSurfer workflows.

Type the following to get a sample MRI file,

     $ curl -L -o MRN_3_subject.zip 'http://stash.osgconnect.net/+fsurf/MRN_3_subject.zip'

`MRN_3_subject.zip` is a zip file containing a FreeSurfer subject directory that
has already been defaced and anonymized.

Now we will create a workflow that will run just the motion correction for the `MRN_3` 
subject using `fsurf`. Unlike the previous workflows, this workflow uses a zip file with the 
contents of a subject dir instead of a mgz file. To create this workflow, you'll need to run:

     $ ./fsurf submit --subject='MRN_3' --input='MRN_3_subject.zip' --freesurfer-options='-motioncor'

Note, that the options for FreeSurfer are surrounded by quotes and are given using the 
equal sign.  You need to do this so that the Fsurf script does not interpret them as options
for the `fsurf` script.

The images should already be deidentified and defaced, so say `y` to the
following questions. 

     Has the MRI data been deidentified (This is required) [y/n]? y 
     Has the MRI data been defaced (This is recommended) [y/n]? y

After typing `y` to the above two questions, `fsurf` creates and submits the
workflow 

     Creating and submitting workflow
     Workflow 99 created
     Uploading input files
     Uploading MRN_3_subject.zip (file 1/1)
     Uploaded MRN_3_subject.zip successfully

The ID of your workflow is `99`. The ID is needed to check the status, remove
and get the output of the workflow. 



##  Listing Workflows

To get the status of this workflow, run the following command:

     $ ./fsurf list 
     Current workflows
     Subject    Workflow   Submit time (Central Time)  Cores      Status     Tasks completed
     MRN_3      97         Fri Sep 30 15:53:51 2016    8          COMPLETED  4/4

The screen output shows that there is just one workflow in the list with the
subject name `MRN_3`. The status of the workflow is `RUNNING`. Two cores are 
being used for this workflow. The ID of the workflow is `97`. 

A unique ID is assigned to each submitted workflow. The ID is useful to get the
output or remove the workflow from the list. 

A workflow can have the following status:

* QUEUED - workflow has been created
* RUNNING - workflow is being run
* FAILED - an error occurred while the workflow was running
* COMPLETED  - workflow has successfully completed
* DELETE PENDING  - workflow will be deleted soon
* DELETED - workflow has been removed
* ERROR - an error occurred with the workflow

## Getting Detailed Information on a Workflow

To get detailed information on a workflow, run the following
command:

     $ ./fsurf status --id 97
     Workflow 97 Summary
     Workflow Type: Standard
     Subject: MRN_1
     Status: RUNNING
     Started: Fri Oct 14 10:17:00 2016

If the workflow has completed, you'll get slightly more information:

     $ ./fsurf status --id 99
     Workflow Type: Custom Workflow
     Subject: MRN_3
     Options: -autorecon1
     Status: COMPLETED
     Started: Wed Oct 12 08:09:53 2016
     Ended: Wed Oct 12 08:38:46 2016
     CPU Time used: 47 mins, 3 secs      Active for: 26 mins, 44 secs    
     Completed: 1/1 tasks


## Getting Outputs

Depending on the resources available on OSG, a workflow will typically
requires 6-12 hours to complete.  Once a workflow has completed successfully,
the status of the workflow should be `COMPLETED` as below

     $ ./fsurf list
     Current workflows
     Subject    Workflow   Submit time (Central Time)  Cores      Status     Tasks completed
     MRN_3      97         Fri Sep 30 15:53:51 2016    8          COMPLETED  4/4

Run the command below to get the output of the completed workflow by using its ID:

     $ ./fsurf output --id 97

The output files are compressed as a single file `MRN_3_output.tar.bz2` in the current work
directory. You can extract all the files in the archive using:

    $ tar -jxvf MRN_3_output.tar.bz2

 Similarly, you get the FreeSurfer logs of any completed  workflow with ID `WorkflowID`

     $ ./fsurf output --id WorkflowID  --log-only


##  Removing Workflows

Make sure you have downloaded the output of a workflow before you remove it.
Run the following command to remove an existing workflow:

    $ ./fsurf remove --id WorkflowID

For example, to remove a running worflow with an ID `97`, type

    $ ./fsurf remove --id 97
    Workflow removed

This will not affect the files you have downloaded already. Please note that
the results of a workflow will be removed after a certain period of time. However
you will be emailed a warning a few days before results are removed. 

## What's Next? 

See how to [process multiple scans with a shell script](https://support.opensciencegrid.org/support/solutions/articles/12000010122-submitting-multiple-scans-to-fsurf). 
If you want to check all the commands and options in `fsurf` [go here](https://support.opensciencegrid.org/support/solutions/articles/12000011119-fsurf-command-reference)
