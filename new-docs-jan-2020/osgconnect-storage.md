[title]: - "Introduction to Data Management on OSG"

## Overview

OSG Connect users have two different storage options available for their use: `home`, and `public`. Each storage offers certain advantages to the users. On the submit node (login.osgconnect.net), the storages are in the following locations,

    home: /home/<username>
    public: /public/<username>

Here, the `username` is your login name.

## Storage options quick reference

### Data storage options

|   | **Default Limit**| **Purpose** | **Network mounted** | **Backed Up** | **Initial Quota\*** | **Purge** |
|:-------- |:----------------:|:------|:------:|:------:|:------:|:------:|:----------|
| **home**    |  50 GB     | Storage of submit files, input files <100MB each, and per-job output up to a 1GB.| No | No | 50 GB | No |
| **public**  |  500 GB    | Staging large input files (100MB-50GB, each) for publicly-accessible download into jobs (using HTTP or stashcp, see below) and large output files (1-10GB) | Yes | No | 500 GB | No |

####*Contact support@osgconnect.net if you'd think you need a quota increase! We can suppport very large amounts of data, and quotas are a starting point.*


### Transferring input data for a job

|         | **Recommended Files Sizes**| **Command** | **Purpose** | **Details**|
|:--------|:------:|:-----|:----------|:------|
| **HTCondor File Transfer** | < 100 MB input, <1GB output  | transfer_input_files | General-use transfer of job input from within /home. |[HTCondor File Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **HTTP** |  < 1 GB   | wget, curl or rsync  | For large input files from within /public. |[HTTP Access](https://support.opensciencegrid.org/support/solutions/articles/5000639798)|
| **OSG's StashCache** |  > 1 GB, < 50 GB    | stashcp | for large input files from within /public| [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775)|
| **GridFTP** |  > 1 GB    | gfal-copy | input staged in /public | Typically used by experts with large work flows. Please contact us if you're interested. |


### Transferring output data for a job
<!-- We recommend that the built-in HTCondor file transfer mechanism (transfer_output_files=... in your job submit file) to get back the output data from the remote worker machine to the submit node. More details are given in the article [Transferring data with HTCondor](https://support.opensciencegrid.org/support/solutions/articles/5000639787).  -->

|         | **Recommended File Sizes**| **Command** | **Purpose** | **Details**|
|:---------|:------:|:-----|:----------|:------|
| **HTCondor**    | < 1 GB  | HTCondor default output transfer (or transfer_output_files) | General-use transfer of job output data into to the submission directory (in /home). |[HTCondor Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **StashCache**        |  < 10 GB   | stashcp | Transfer large output into /public|  [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775) |
| **GridFTP or UNIX tools**        |  < 50 GB   | gfal-copy, rsync, scp, etc. | Typically used by experts with large work flows. Please contact us if you want to use this.|


### External data transfer

|  | **Data Size**| **Tools** |**Details**|
|:------------|:-------:|:------|:------| 
|**UNIX tools** | < 1 GB | rsync, scp, putty, WinSCP, gFTP, etc.  |[SCP](https://support.opensciencegrid.org/support/solutions/articles/5000634376) |
|**Globus** |  > 1 GB  | globus webservice or globus CLI | [Globus](https://support.opensciencegrid.org/support/solutions/articles/5000632397) |


## Storage options
### home
Home is meant for general use storage of various data necessary for job submission. The initial disk quota on home is 50 GBs. When a user exceeds his quota, the system will send email notifications. If the notice is disregarded, eventually the user will lose the privilege to write on his home.

** Home filesystem is not suitable to run your HTCondor jobs. It is a good practice to run all your jobs under the `local-scratch` or `stash` directories. **

### local-scratch
`local-scratch` is meant for temporary storage, and is implemented as fast local disk for each submit node. It is a good practice to run your jobs on `local-scratch` and move the output data to a secondary local disk as soon as possible. NOTE: data on `local-scratch` is automatically removed after 30 days and is not backed up.

### stash
Stash is a distributed shared filesystem mounted on all our submit nodes, and is therefore slower than local-scratch. There is no disk quota imposed, nor a automatic purge, on stash. However, the data on stash is not backed up, so you should regularly transfer your data on stash to a long term archival system.  If you are transfering a large amount of data, please use the Globus transfer service.  For more details check the articles on [data transfer techniques](https://opensciencegrid.freshdesk.com/a/solutions/folders/12000013267).  

**Note: Files and directories that have not been accessed for over six months may be deleted.**

### public
Files placed in the '~public' directory are publicly accessible via WWW as `http://stash.osgconnect.net/+username`. The data on `~/public` is accessible to the jobs on remote worker machine via the wget command. Using the HTTP protocol (through `wget` or `curl`) is ideal for files less than 1 GB in size. Larger files will need to be placed in stash `stash` and accessed with the `stashcp` command. For more details of using public for condor input file transfer,  [click here](https://support.opensciencegrid.org/solution/articles/5000639798).


## Getting Help
For assistance or questions, please email the OSG User Support team  at [support@osgconnect.net](mailto:support@osgconnect.net) or visit the [help desk and community forums](http://support.opensciencegrid.org).



 

