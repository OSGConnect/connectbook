
[title]: - "Guidelines for data managment in OSG - Storage and Transfer"

## Purpose

The following tables provide guidelines for data management in OSG. Check the web links for additional details. 


## Data storage options

|   | **Recommended Limit**| **Purpose** | **Network mounted** | **Backed Up** | **Quota** | **Purge** | **Details**|
|:------- |:----------------:|:------|:------:|:------:|:------:|:------:|:----------|
| **home**    |  < 20 GB      | Meant for quick data access and not for submitting jobs.| Yes | Yes | 20 GB | No | [Data Storage](https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|
| **local-scratch**   |  < 25 GB      | Meant for large temporary storage and I/O for your jobs. Files older than 30 days are automatically removed. | No | No | No | Yes, 30 days | [Data Storage](https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|
| **stash**   |  < 200 GB      | Meant for large storage and I/O for your jobs. | Yes | No | No | no | [Data Storage](https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|
| **public**  |  < 10 GB    | Meant for sharing data and transfer input data via HTTP or staschcp | Yes | No | No | No | [Data Storage](https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|

For the data management of more than 200 GB, please email us at [user-support@opensciencegrid.org](mailto:usersupport@opensciencegrid.org)


## Transferring input data for a job

|         | **Data Size**| **Command** | **Purpose** | **Details**|
|:---------|:------:|:-----|:----------|:------|
| **HTCondor**    | < 2 GB  | transfer_input_files| Input data from home, public or stash |[HTCondor Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787-transferring-data-with-htcondor)|
| **HTTP**        |  < 10 GB   | wget, curl or transfer_input_files  | Input data from ~/public |[HTTP Access](https://support.opensciencegrid.org/support/solutions/articles/5000639798-access-stash-remotely-using-http)|
| **StachCache**  |  < 50 GB    | Staschcp |Input data from ~/public| [StachCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775-transferring-data-with-stashcache)|



## Transferring output data for a job
We recommend that the built-in HTCondor file transfer mechanism (transfer_output_files=... in your job submit file) to get back the output data from the remote worker machine to the submit node. More details are given in the article [Transferring data with HTCondor](https://support.opensciencegrid.org/support/solutions/articles/5000639787-transferring-data-with-htcondor). 


## External data transfer

|  | **Data Size**| **Tools** |**Details**|
|:------------|:-------:|:------|:------| 
|**Secured Copy Protocol (SCP)** | < 1 GB | scp, puty, WinSCP, gFTP, etc.  |[SCP](https://support.opensciencegrid.org/support/solutions/articles/5000634376-using-scp-to-transfer-files) |
|**Globus** |  > 1 GB  | globus webservice or globus CLI | [Globus](https://support.opensciencegrid.org/support/solutions/articles/5000632397-data-transfer-with-globus) |


## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).


