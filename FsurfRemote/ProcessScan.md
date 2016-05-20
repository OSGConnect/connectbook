[title]: - "Analysis of a Brain MRI Scan"
[TOC]


## Overview

In this section, we see how to submit a FreeSurfer workflow from your laptop with Fsurf utility. 

**Important note on data privacy**:  `Fsurf` tool is *not* HIPPA compliant. (HIPPA, the Health Insurance Portability and Accountability Act, is a federal law written to protect personal medical information.) Therefore images must be anonymized and deidentified before they are uploaded to OSG servers as described in [the article on Anonymozing Images](https://support.opensciencegrid.org/support/solutions/articles/12000008493-anonymizing-images).

## Get a Sample MRI file

Type the following to get a sample MRI file, 

     curl -L -o MRN_3_defaced.mgz 'http://stash.osgconnect.net/+fsurf/MRN_3_defaced.mgz'

`MRN_3_defaced.mgz` is an MRI file that was already defaced and anonymoized. 


## Perfrom an Image Reconstruction 

A typical image reconstruction with Freesurfer requires the execution of autorecon1, autorecon2, and 
autorecon3 on MRI data.  All three steps are handled by `Fsurf`. 

Now we do the image reconstruction of  `MRN_3_defaced.mgz` with Fsurf. In the file `MRN_3_defaced.mgz`,  the prefix `MRN_3` is the name of the subject.

     $ ./fsurf  --user myuser --password mypassword submit --subject MRN_3 

`MRN_3_defaced.mgz` image is already deidentified and defaced, so say `y` to the following questions. 

     Has the MRI data been deidentified (This is required) [y/n]? y
     Has the MRI data been defaced (This is recommended) [y/n]? y

After typing `y` to the above two questions, `Fsurf` creates and submits the workflow 

     Creating and submitting workflow
     Workflow 97 submitted for processing

The ID of your workflow is `97`. The ID is needed to check the status, remove and get the output of the workflow. 

##  List Workflows

To get the status of workflows, run the following command:

     $ ./fsurf --user myuser --password mypassword list 
     Current workflows
     Subject    Workflow             Submit time          Cores          Status
     MRN_3       97                   10:00 01-19-2016     2             PROCESSING

The screen output shows that there is just one workflow in the list 
with the subject name `MRN_3`. The status of the workflow is `PROCESSING` (same as running). Two cores are 
being used for this workflow. The ID of the workflow is `97`. 

A unique ID is assigned to each submitted workflow. The ID is useful to get the output or 
remove the workflow from the list. 

## What's Next? 

See how to [get the output files back to the laptop](https://support.opensciencegrid.org/solution/articles/12000008491-managing-your-output-files).

## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).
