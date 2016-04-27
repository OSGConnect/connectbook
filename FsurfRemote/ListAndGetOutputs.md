[title]: - "Managing your  output files"
[TOC]
 

##  List Workflows

Run the command below to get a list of workflows that you have submitted and their status:

     $ ./fsurf --list --user myuser --password mypassword
     Current workflows
     Subject    Workflow             Submit time          Cores          Status
     test       97                   10:00 01-19-2016     2               Running   


##  Getting Outputs

Once a workflow is completed successfully, the status of the workflow should be `COMPLETED` as below

     $ ./fsurf --list --user myuser --password mypassword
     Current workflows
     Subject    Workflow             Submit time          Cores           Status    
     test       97                   10:00 01-19-2016     2               COMPLETED   

Run the command below to get the output of the completed workflow `20160119T100055-0600`:
 
     $ ./fsurf --output --id 97 --user myuser --password mypassword

Depending on the computer resources available, a workflow will typically require 6-12 hours to complete.  The output will be saved as an archive in the current working directory: `test_output.tar.bz2` where test will be replaced by the subject name . You can extract all the files in the archive using: 

    $ tar -jxvf test_output.tar.bz2
 
 Similarly, you get the output of any completed  workflow with id `WorkflowID` 
 
     $ ./fsurf --output --id WorkflowID
     $ tar -jxvf <SubjectName>_output.tar.bz2

##  Remove Workflows

Run the following to remove an existing workflow:
   
    $ ./fsurf --remove --id WorkflowID

For example, to remove a running worflow with an id `56`, type

    $ ./fsurf --remove --id 56
    Workflow removed

This will not effect the files you have downloaded already.

## Getting Help 
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).



