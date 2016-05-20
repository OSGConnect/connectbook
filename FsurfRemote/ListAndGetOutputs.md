[title]: - "Managing your workflows and output files"
[TOC]

##  Listing Workflows

Run the command below to get a list of workflows that you have submitted and their status:

     $ ./fsurf --user myuser --password mypassword list 
     Current workflows
     Subject    Workflow             Submit time          Cores          Status
     MRN_3       97                   10:00 01-19-2016     2              PROCESSING

The status of the workflow is `PROCESSING` which means the workflow is not completed yet.  The 
ID of the workflow is `97`.  The ID is required to get the output of a completed workflow or remove it from 
the list of workflows. 

##  Getting Outputs

Depending on the computer resources available, a workflow will typically require 6-12 hours to complete. 
Once a workflow has completed successfully, the status of the workflow should be `COMPLETED` as below

     $ ./fsurf --user myuser --password mypassword list
     Current workflows
     Subject    Workflow             Submit time          Cores           Status    
     MRN_3       97                   10:00 01-19-2016     2               COMPLETED   

Run the command below to get the output of the completed workflow by using its ID:
 
     $ ./fsurf --user myuser --password mypassword output --id 97 

The output files are compressed as a single file `MRN_3_output.tar.bz2` in the current work 
directory. You can extract all the files in the archive using: 

    $ tar -jxvf MRN_3_output.tar.bz2
 
 Similarly, you get the Freesurfer logs of any completed  workflow with ID `WorkflowID` 
 
     $ ./fsurf --user myuser --password mypassword output --id WorkflowID  --log-only


##  Removing Workflows

Make sure you have downloaded the output of a workflow before you remove it.  Run the following to remove an 
existing workflow:
   
    $ ./fsurf --user myuser --password mypassword remove --id WorkflowID 

For example, to remove a running worflow with an ID `56`, type

    $ ./fsurf --user myuser --password mypassword remove --id 56 
    Workflow removed

This will not affect the files you have downloaded already. 

## Getting Help 
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).


## Validation Information
A list of linux kernels on OSG  on which the Freesurfer workflows have been validated can be found [here](https://support.opensciencegrid.org/support/solutions/articles/12000008494-freesurfer-validation-on-the-osg-)


