[title]: - "Introduction to Data Management on OSG"
[TOC]

## Overview

OSG Connect users have four different storage options available for their use: `home`, `local-scratch`, `stash`. `public`. Each storage offers certain advantages to the users. On the submit node (login.osgconnect.net), the storages are in the following locations,

    home: /home/username
    local-scratch: /local-scratch/username
    stash: /home/username/stash (or) /stash/user/username
    public: /home/username/public (or) /stash/user/username/public

Here, the `username` is your login name.. For convenience, the stash and public directories are accessed from home. Here, the `username` is your login name.

## Storage Options Quick Reference

### Data storage options

|   | **Default Limit**| **Purpose** | **Network mounted** | **Backed Up** | **Quota** | **Purge** |
|:------- |:----------------:|:------|:------:|:------:|:------:|:------:|:----------|
| **home**    |  < 20 GB      | Meant for quick data access and not for submitting jobs.| Yes | Yes | 20 GB | No |
| **local-scratch**   |  < 25 GB      | Meant for large temporary storage and I/O for your jobs. Files older than 30 days are automatically removed. | No | No | No | Yes, 30 days |
| **stash**   |  < 200 GB      | Meant for large storage and I/O for your jobs. | Yes | No | No | No |
| **public**  |  < 10 GB    | Meant for sharing data and transfer input data via HTTP or staschcp | Yes | No | No | No |


### Transferring input data for a job

|         | **Recommended Data Size**| **Command** | **Purpose** | **Details**|
|:---------|:------:|:-----|:----------|:------|
| **HTCondor**    | < 100 MB  | transfer_input_files | Input data from home, public or stash |[HTCondor Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **HTTP**        |  < 1 GB   | wget, curl or rsync  | Input data from ~/public |[HTTP Access](https://support.opensciencegrid.org/support/solutions/articles/5000639798)|
| **StashCache**  |  > 1 GB, < 50 GB    | stashcp |Input data from ~/public| [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775)|
| **GridFTP**  |  > 1 GB, < 50 GB    | gfal-copy |Input data from ~/stash| Experts with large work flows. Please contact us if you want to use this.|



### Transferring output data for a job
<!-- We recommend that the built-in HTCondor file transfer mechanism (transfer_output_files=... in your job submit file) to get back the output data from the remote worker machine to the submit node. More details are given in the article [Transferring data with HTCondor](https://support.opensciencegrid.org/support/solutions/articles/5000639787).  -->

|         | **Recommended Data Size**| **Command** | **Purpose** | **Details**|
|:---------|:------:|:-----|:----------|:------|
| **HTCondor**    | < 100 MB  | transfer_output_files | Transfer data to submit directory |[HTCondor Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **UNIX tools**        |  < 1 GB   | rsync, scp, etc. | Transfer data to home, local-scratch, stash, etc.| Please contact us if you want to use this. |
| **StashCache**        |  < 1 GB   | stashcp | Transfer data to stash|  [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775) |
| **GridFTP**  |  > 1 GB, < 50 GB    | gfal-copy | Output data to ~/stash| Experts with large work flows. Please contact us if you want to use this.|


### External data transfer

|  | **Data Size**| **Tools** |**Details**|
|:------------|:-------:|:------|:------| 
|**UNIX tools** | < 1 GB | rsync, scp, putty, WinSCP, gFTP, etc.  |[SCP](https://support.opensciencegrid.org/support/solutions/articles/5000634376) |
|**Globus** |  > 1 GB  | globus webservice or globus CLI | [Globus](https://support.opensciencegrid.org/support/solutions/articles/5000632397) |


## Storage Options
### home
Home is meant for storing files long-term. Usually, files such as source code, parameter files, scripts, etc. are kept in your `/home` directory. The disk quota on home is 20 GBs. When a user exceeds his quota, the system will send email notifications. If the notice is disregarded, eventually the user will lose the privilege to write on his home.

** Home filesystem is not suitable to run your HTCondor jobs. It is a good practice to run all your jobs under the `local-scratch` or `stash` directories. **

### local-scratch
`local-scratch` is meant for temporary storage, and is implemented as fast local disk for each submit node. It is a good practice to run your jobs on `local-scratch` and move the output data to a secondary local disk as soon as possible. NOTE: data on `local-scratch` is automatically removed after 30 days and is not backed up.

### stash
Stash provides medium term storage (less 6 months) for users. Stash is a distributed shared filesystem mounted on all our submit nodes, and is therefore slower than local-scratch. There is no disk quota imposed, nor a automatic purge, on stash. However, the data on stash is not backed up, so you should regularly transfer your data on stash to a long term archival system.  If you are transfering a large amount of data, please use the Globus transfer service.  For more details check the articles on [data transfer techniques](https://opensciencegrid.freshdesk.com/a/solutions/folders/12000013267).  

**Note: Files and directories that have not been accessed for over six months may be deleted.**

### public
Files placed in the '~public' directory are publicly accessible via WWW as `http://stash.osgconnect.net/+username`. The data on `~/public` is accessible to the jobs on remote worker machine via the wget command. Using the HTTP protocol (through `wget` or `curl`) is ideal for files less than 1 GB in size. Larger files will need to be placed in stash `stash` and accessed with the `stashcp` command. For more details of using public for condor input file transfer,  [click here](https://support.opensciencegrid.org/solution/articles/5000639798).


## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).



 

