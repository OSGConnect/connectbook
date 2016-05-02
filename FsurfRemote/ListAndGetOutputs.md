[title]: - "Managing your workflows and output files"
[TOC]
 

##  List Workflows

Run the command below to get a list of workflows that you have submitted and their status:

     $ ./fsurf --list --user myuser --password mypassword
     Current workflows
     Subject    Workflow             Submit time          Cores          Status
     MRN_3       97                   10:00 01-19-2016     2              PROCESSING

The above screen output shows that there is just one workflow in the list. The status of the workflow 
is `PROCESSING` which means the workflow is not completed yet.  The id of the workflow is `97` which is 
required to get the output or remove the workflow. 

##  Getting Outputs

Depending on the computer resources available, a workflow will typically require 6-12 hours to complete. 
Once a workflow completed successfully, the status of the workflow should be `COMPLETED` as below

     $ ./fsurf --list --user myuser --password mypassword
     Current workflows
     Subject    Workflow             Submit time          Cores           Status    
     MRN_3       97                   10:00 01-19-2016     2               COMPLETED   

Run the command below to get the output of the completed workflow by referring it's id:
 
     $ ./fsurf --output --id 97 --user myuser --password mypassword

The output files are compressed as a single file `MRN_3_output.tar.bz2` in the current work 
directory. You can extract all the files in the archive using: 

    $ tar -jxvf MRN_3_output.tar.bz2
 
 Similarly, you get the output of any completed  workflow with id `WorkflowID` 
 
     $ ./fsurf --output --id WorkflowID  --user myuser --password mypassword
     $ tar -jxvf <SubjectName>_output.tar.bz2

##  Remove Workflows

Make sure you got the output of an workflow before you remove it.  Run the following to remove an 
existing workflow:
   
    $ ./fsurf --remove --id WorkflowID --user myuser --password mypassword

For example, to remove a running worflow with an id `56`, type

    $ ./fsurf --remove --id 56 --user myuser --password mypassword
    Workflow removed

This will not effect the files you have downloaded already. 

## Getting Help 
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).



