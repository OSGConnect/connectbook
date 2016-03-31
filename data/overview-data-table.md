
[title]: - "Guidelines for data managment in OSG - Storage and Transfer"

## Purpose

The following tables provide guidelines for data management in OSG. Check the web links for additional details. 


## Data storage options

|  Type | Recommended Limit| Purpose | Details|
|:------- |:----------------| :------|:------|
| **home**    |  < 5 GB      | Meant for quick data access and not for submitting jobs.| [Data Storage](https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|
| **stash**   |  < 500 GB      | Meant for large storage and I/O for your jobs. |[Data Storage](https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|
| **public**  |  < 500 GB    | Meant for sharing data and transfer input data via HTTP or staschcp|[Data Storage](https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|



## Transferring input data for a job

|    Protocol     | Data Size| command| Purpose | Details|
|:---------|:------|:-----|:----------|:------|
| **HTCondor**    | < 1 GB  | transfer_input_files| Input data from home, public or stash |[HTCondor Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787-transferring-data-with-htcondor)|
| **HTTP**        |  < 10 GB   | wget, curl or transfer_input_files  | Input data from ~/public |[HTTP Access](https://support.opensciencegrid.org/support/solutions/articles/5000639798-access-stash-remotely-using-http)|
| **StachCache**  |  < 50 GB    | Staschcp |Input data from ~/public| [StachCache](https://support.opensciencegrid.org/support/solutions/articles/5000639798-access-stash-remotely-using-http)|



## Transferring output data for a job
We recommend that the built-in HTCondor file transfer mechanism (transfer_output_files=... in your job submit file) to get back the output data from the remote worker machine to the submit node. More details are given in the article [Transferring data with HTCondor](https://support.opensciencegrid.org/support/solutions/articles/5000639787-transferring-data-with-htcondor). 


## External data transfer

  | Protocol | Data Size| Details|
 |:------------|:--------|:------|
|**Secured Copy Protocol (SCP)** | < 1 GB   | [SCP](https://support.opensciencegrid.org/support/solutions/articles/5000634376-using-scp-to-transfer-files) |
 |**Globus** |  > 1 GB  | [Globus](https://support.opensciencegrid.org/support/solutions/articles/5000632397-data-transfer-with-globus) |


## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).


