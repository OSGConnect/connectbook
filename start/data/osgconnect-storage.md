[title]: - "Introduction to Data Management on OSG Connect"

## Overview

OSG Connect provides two locations for uploading files (data and software) that are 
needed for running jobs: 

    home: /home/<username>          (general storage from which ALL jobs should be submitted)
    public: /public/<username>      (only for large job input and output using `http` or `stashcp`)

In general, OSG Connect users are responsible for managing data in these folders and for using appropriate mechanisms for delivering data to/from jobs, as detailed below. Each is controlled with a quota and should be treated as temporary storage for _active_ job execution. OSG Connect has no routine backup of data in these locations, and users should remove old data after jobs complete, in part, to make room for future submissions. **If you think you'll need more space for a set of concurrently-queued jobs, even after cleaning up old data, please send a request to [support@osgconnect.net](mailto:support@osgconnect.net)!**

For additional data information, see also the "Data Storage and Transfer" section of 
our [FAQ](5000634384#data-storage-and-transfer). 

**Note: OSG Connect staff reserve the right to monitor and/or remove data without notice to the user IF doing so is necessary for ensuring proper use or to quickly fix a performance or security issue.**

## Storage of Data for Jobs

### Data Locations and Quotas

Here is a summary of the two main data locations available on OSG Connect, with more 
details following. 

|   |  **Purpose** | **Network mounted** | **Backed Up** | **Initial Quota\*** |
|:--------:|:------|:------:|:------:|:------:|
|  `/home`  | Storage of submit files, input files <100MB each, and per-job output up to a 1GB.  Jobs should ONLY be submitted from this folder. | No | No | 50 GB |
|  `/public`  | Staging ONLY for large input files (100MB-50GB, each) for publicly-accessible download into jobs (using HTTP or stashcp, see below) and large output files (1-10GB). | Yes | No | 500 GB |

You can see your quota status in the login node login message: 

    Disk utilization for alice:
    /public   : [                        ] 0% (0/500000 MB)
    /home     : [ #                      ] 4% (2147/53687 MB)

> ### \*Contact [support@osgconnect.net](mailto:support@osgconnect.net) if you think you need a quota increase! We can support very large amounts of data; the listed quotas are an initial value for getting started. 

### More Information About `/home` and Usage Policies

User directories within `/home` are meant for general-use storage of various files necessary for job submission. The initial quota per user is 50 GBs. 

**ALL JOBS SHOULD BE SUBMITTED FROM WITHIN `/home`**. If you're 
unable to submit jobs or have them complete because you've 
reached your `/home` quota, please 
contact [support@osgconnect.net](mailto:support@osgconnect.net) about a quota increase.

Note that making your `/home` directory world-readable may expose your SSH key files or any other security 'secrets' you have stored in OSG Connect (thereby violating the Acceptable Use Policy you agreed to when requesting an OSG Connect account).

### More Information About `/public` and Usage Policies

User directories within `/public` are meant **ONLY** for staging job files too large for 
HTCondor file transfer (input greater than 100MB, output greater than 1GB). 

**USERS SHOULD NEVER SUBMIT JOBS FROM WITHIN `/public`**, and should not list `/public` files in the 'transfer_input_files` line of a submit file, unless as an HTTP address (see more details below). Files place in `/public` should only be accessed by jobs using the below tools (see "Transferring Data To/From Jobs). Users violating these policies may lose the ability to submit jobs until their submissions are corrected.

The initial disk quota of `/public` is 500 GBs. Contact [support@osgconnect.net](mailto:support@osgconnect.net) if you 
will need an increase for concurrently running work, after cleaning up all data from past jobs. 
**Given that users should not be storing long-term data (like submit files, software, etc.) in `/public`, files and directories that have not been accessed for over six months may be deleted by OSG Connect staff with or without notifying the user.**

Files placed within a user's `/public` directory **are publicly accessible**, 
discoverable and readable by anyone. Data is made public over http/https, stashcp and mirrored to `/cvmfs/stash.osgstorage.org/osgconnect/public` which is mounted on a large number of systems around the world.

> ### Is there any support for private data?
> 
> If you do not want your data to be downloadable by anyone, and it’s small enough for
> HTCondor file transfer, then it should be staged in your `/home` directory and 
> transferred to jobs with HTCondor file transfer (transfer_input_files, in the submit 
> file). If it cannot be public (cannot use http or stashcp for job delivery), and is too
> large for HTCondor file transfer, then it’s not a good fit for the “open” environment of 
> the Open Science Grid, and another resource will likely be more appropriate. As a 
> reminder, if the data is not being used for active computing work on OSG Connect, it 
> should not be stored on OSG Connect systems, and our data storage locations are not 
> backed up or suitable for project-duration storage.

## External Data Transfer to/from OSG Connect Login Nodes

The following tools should be used to upload data from your computer to the OSG Connect login node, or to download files from the OSG Connect login node. 

|  | **Data Size**| **Tools** |**Details**|
|:------------|:-------:|:------|:------| 
|**UNIX tools** | < 1 GB | `rsync`, `scp`, Putty, WinSCP, `gFTP`, etc.  |[SCP](https://support.opensciencegrid.org/support/solutions/articles/5000634376) |

## Transferring Data To/From Jobs

### Transferring Input Data to Jobs

This table summarizes the options for sending input files from the OSG Connect login node to the execution node where a job is running. This assumes that you have already uploaded these input files from your own computer to your OSG Connect login node. 

|         | **Recommended File Sizes**| **Where Data is Placed** | **Command** | **Purpose** | **Details**|
|:--------:|:------|:-----|:-----|:----------|:------|
| **HTCondor File Transfer** | <100 MB per file; <500 MB per job | `/home` | `transfer_input_files` | General-use transfer of job input from within `/home`. |[HTCondor File Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **HTTP** |  <1 GB per file | `/public` or non-OSG web server | http address in `transfer_input_files`  | For input files 100MB-1GB, if shared across many jobs. |[HTTP Access](https://support.opensciencegrid.org/support/solutions/articles/5000639798)|
| **OSG's StashCache** | >1 GB per file; <10 GB per job | `/public` | `stashcp` | For the largest input files, staged within `/public`| [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775)|
| **GridFTP** |  > 10 GB | `/public` | `gfal-copy` | input staged in /public | Typically used by experts with large work flows. Please contact us if you're interested. |


### Transferring Output Data from Jobs

This table summarizes a job's options for returning output files generated by the job back to the OSG Connect login node. 

|         | **Recommended File Sizes**| **Command** | **Purpose** | **Details**|
|:---------|:------:|:-----|:----------|:------|
| **HTCondor**    | < 1 GB  | HTCondor default output transfer (or `transfer_output_files`) | General-use transfer of job output data back to the submission directory (in `/home`). |[HTCondor Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **StashCache**        |  < 10 GB   | `stashcp` | Transfer large output to show up in `/public`|  [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775) |
| **GridFTP**        |  > 10 GB   | `gfal-copy` | Staging against /public | Typically used by experts with large work flows. Please contact us if you're interested.|


## Get Help
For assistance or questions, please email the OSG User Support team  at [support@osgconnect.net](mailto:support@osgconnect.net) or visit the [help desk and community forums](http://support.opensciencegrid.org).

