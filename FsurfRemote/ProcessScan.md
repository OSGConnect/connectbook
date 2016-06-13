[title]: - "Analyzing a Brain MRI Scan"
[TOC]


## Overview

In this section, we will demonstrate how to use the `fsurf` utility by analyzing
a brain scan. 

**Important note on data privacy**:  In order to protect the privacy of your
participants’ scans, we request that you submit only defaced and fully
deidentified scans for processing by fsurf.  Images can be anonymized and
deidentified before they are uploaded to OSG servers as described in [the
article on anonymizing images](https://support.opensciencegrid.org/support/solutions/articles/12000008493-anonymizing-images).

## Get a Sample MRI file

Type the following to get a sample MRI file, 

     curl -L -o MRN_3_defaced.mgz 'http://stash.osgconnect.net/+fsurf/MRN_3_defaced.mgz'

`MRN_3_defaced.mgz` is an MRI file that has already been defaced and anonymized. 


## Performing an Image Reconstruction 

A typical image reconstruction with FreeSurfer requires the execution of
autorecon1, autorecon2, and autorecon3 on MRI data.  All three steps are handled
by `fsurf`. 

Now we will create a workflow to process `MRN_3_defaced.mgz` using `fsurf`. In the
file `MRN_3_defaced.mgz`, the prefix `MRN_3` is the name of the subject. Note,
that `fsurf` expects the input file to be named `subject_defaced.mgz` where
`subject` is the name of the subject given by the `--subject` option. 

     $ ./fsurf submit --subject MRN_3 

`MRN_3_defaced.mgz` image is already deidentified and defaced, so say `y` to the
following questions. 

     Has the MRI data been deidentified (This is required) [y/n]? y 
     Has the MRI data been defaced (This is recommended) [y/n]? y

After typing `y` to the above two questions, `fsurf` creates and submits the
workflow 

     Creating and submitting workflow 
     Workflow 97 submitted for processing

The ID of your workflow is `97`. The ID is needed to check the status, remove
and get the output of the workflow. 

##  Listing Workflows

To get the status of this workflow, run the following command:

     $ ./fsurf list 
     Current workflows
     Subject    Workflow             Submit time          Cores          Status
     MRN_3       97                  01-19-2016 10:00      2             PROCESSING

The screen output shows that there is just one workflow in the list with the
subject name `MRN_3`. The status of the workflow is `PROCESSING` (same as
running). Two cores are being used for this workflow. The ID of the workflow is
`97`. 

A unique ID is assigned to each submitted workflow. The ID is useful to get the
output or remove the workflow from the list. 

A workflow can have the following status:

* UPLOADED - workflow has been created
* PROCESSING - workflow is being run 
* FAILED - an error occurred while the workflow was running
* COMPLETED  - workflow has successfully completed
* DELETE PENDING  - workflow will be deleted soon
* DELETED - workflow has been removed
* ERROR - an error occurred with the workflow

##  Getting Outputs

Depending on the computer resources available, a workflow will typically
requires 6-12 hours to complete.  Once a workflow has completed successfully,
the status of the workflow should be `COMPLETED` as below

     $ ./fsurf list
     Current workflows
     Subject    Workflow             Submit time          Cores           Status
     MRN_3       97                  01-19-2016 18.20      2               COMPLETED

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

For example, to remove a running worflow with an ID `56`, type

    $ ./fsurf remove --id 56
    Workflow removed

This will not affect the files you have downloaded already. Please note that
the results of a workflow will be removed after a certain period of time. However
you will be emailed a warning a few days before results are removed. 

## What's Next? 

See how to [process multiple scans with a shell script](https://support.opensciencegrid.org/support/solutions/articles/12000010122-submitting-multiple-scans-to-fsurf). 
If you want to check all the commands and options in `fsurf` [go here](https://support.opensciencegrid.org/support/solutions/articles/12000011119-fsurf-command-reference)

## Getting Help
For assistance or questions, please email the OSG User Support team  at
[user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or
visit the [help desk and community forums](http://support.opensciencegrid.org).


## Validation Information
A list of linux kernels on OSG  on which the FreeSurfer workflows have been
validated can be found
[here](https://support.opensciencegrid.org/support/solutions/articles/12000008494-freesurfer-validation-on-the-osg-).
