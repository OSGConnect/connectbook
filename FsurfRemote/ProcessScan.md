[title]: - "Process a Scan"
[TOC]

In this section, we see how to submit the FreeSurfer workflow from your laptop with Fsurf utility. 
**Important note on data privacy**: The `fsurf` tool is *not* HIPPA compliant. (HIPPA, the Health Insurance Portability and Accountability Act, is a federal law written to protect personal medical information.) Therefore images must be anonymized and deidentified before they are uploaded to OSG servers as we discussed in the section ------

## Sample defaced MRI file


Get a sample MRI file by running

     curl -L -o MRN_3_defaced.mgz 'http://stash.osgconnect.net/+fsurf/MRN_3_defaced.mgz'

the file `MRN_3_defaced.mgz` is the defaced sample file. 

Images must be anonymized and deidentified before they are uploaded to OSG servers as we discussed in the section ------

## Image reconstruction of the sample MRI file

A typical Freesurfer analysis runs autorecon1, autorecon2, and autorecon3 sequentially on MRI data.  All three steps are handled by `fsurf`. 

Now we do the image reconstruction of  `MRN_3_defaced.mgz` with Fsurf. In the file `MRN_3_defaced.mgz` the prefix `MRN_3` is the name of the subject.


     $ ./fsurf  --submit --subject MRN_3 --user myuser --password mypassword

The `FreeSurfer` requires that the MRI file to be deidentified and defaced. The `MRN_3_defaced.mgz` image is already deidentified and defaced, so say `y` to the following questions. 

     Has the MRI data been deidentified (This is required) [y/n]? y
     Has the MRI data been defaced (This is recommended) [y/n]? y

After typing `y` to the above two questions, `fsurf` creates and submits the workflow 

     Creating and submitting workflow
     Workflow submitted with an id of 20160119T100055-0600

The id of your workflow is `20160119T100055-0600`. The id is needed to check the status, remove and get the output of the workflow. 

##  List Workflows

Run the command below to get a list of workflows that you have submitted and their status:

     $ ./fsurf --list --user myuser --password mypassword
     Current workflows
     Subject    Workflow             Submit time          Cores          Status
     test       97                   10:00 01-19-2016     2               Running

## What next? 

See how to get the output files back to the laptop once the workflow finished. 

## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).
