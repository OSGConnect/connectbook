[title]: - "Introduction to Data Management on OSG Connect"

## Overview

OSG Connect provides two locations for uploading files (data and software) that are 
needed for running jobs: 

    home: /home/<username>
    public: /public/<username>

Each is controlled with a quota (see our notes below about how to request a quota change) and should be treated as temporary storage for _active_ job execution. OSG Connect has no routine backup of data in these locations, and users should remove old data after jobs complete, in part, to make room for future submissions. In general, OSG Connect users are
 responsible for managing data in these folders and for using appropriate mechanisms 
 for delivering data to/from jobs, as detailed below. 

For additional data information, see also the "Data Storage and Transfer" section of 
our [FAQ](5000634384#data-storage-and-transfer). 

**Note: OSG Connect staff reserve the right to remove data without notice to the user IF doing so is necessary to quickly fix a performance issue.**

## Storage of Data for Jobs

### Data Locations and Quotas

Here is a summary of the two main data locations available on OSG Connect, with more 
details following. 

|   |  **Purpose** | **Network mounted** | **Backed Up** | **Initial Quota\*** |
|:--------:|:----------------|:------|:------:|:------:|:------:|
|  `home`  | Storage of submit files, input files <100MB each, and per-job output up to a 1GB.  Jobs should be submitted from this folder. | No | No | 50 GB |
|  `/public`  | Staging large input files (100MB-50GB, each) for publicly-accessible download into jobs (using HTTP or stashcp, see below) and large output files (1-10GB) | Yes | No | 500 GB |

You can see your quota status in the login node login message: 

```
Disk utilization for alice:
/public   : [                        ] 0% (0/500000 MB)
/home     : [ #                      ] 4% (2147/53687 MB)
```

> ### \*Contact [support@osgconnect.net](mailto:support@osgconnect.net) if you think you 
> need a quota increase! We can support very large amounts of data; the listed quotas 
> are an initial value for getting started. 

### More Information About `/home`

User directories within `/home` are meant for general-use storage of various files necessary for job submission. The initial disk quota on home is 50 GBs. 

All jobs should be submitted from within `/home`. If you're 
unable to submit jobs or have them complete because you've 
reached your `/home` quota, please 
contact [support@osgconnect.net](mailto:support@osgconnect.net) about a quota increase. 

### More Information About `/public`

User directories within `/public` are meant for staging job files too large for 
HTCondor and file transfer (input greater than 100MB, output greater than 1GB). The initial disk quota on home is 500 GBs. Again, contact [support@osgconnect.net](mailto:support@osgconnect.net) if you 
will need an increase for concurrently running work.

Files placed within a user's '/public' directory **are publicly accessible**, 
discoverable and readable by anyone. Data is made public over http/https, stashcp and mirrored to `/cvmfs/stash.osgstorage.org/osgconnect/public/` which is mounted on a large number of systems around the world.

Jobs should **not** be submitted from the `/public folder`. Instead, jobs should be 
submitted from `/home` and files in `/public` can be accessed by a job using the 
tools described [below](transferring-input-data-to-jobs). 

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

**Given that users should not be storing long-term data (like submit files, software, etc.) in `/public/`, files and directories that have not been accessed for over six months may be deleted by OSG Connect staff with or without notifying the user.**


## Transferring Data to/from Jobs
### Transferring input data to jobs

|         | **Recommended Files Sizes**| **Command** | **Purpose** | **Details**|
|:--------:|:------|:-----|:----------|:------|
| **HTCondor File Transfer** | < 100 MB input, <1GB output  | `transfer_input_files` | General-use transfer of job input from within `/home`. |[HTCondor File Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **HTTP** |  < 1 GB   | `wget`, `curl`, or `rsync`  | For large input files from within `/public`. |[HTTP Access](https://support.opensciencegrid.org/support/solutions/articles/5000639798)|
| **OSG's StashCache** |  > 1 GB, < 50 GB    | `stashcp` | for large input files from within `/public`| [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775)|
| **GridFTP** |  > 1 GB    | `gfal-copy` | input staged in /public | Typically used by experts with large work flows. Please contact us if you're interested. |


### Transferring output data from jobs

|         | **Recommended File Sizes**| **Command** | **Purpose** | **Details**|
|:---------|:------:|:-----|:----------|:------|
| **HTCondor**    | < 1 GB  | HTCondor default output transfer (or `transfer_output_files`) | General-use transfer of job output data back to the submission directory (in `/home`). |[HTCondor Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **StashCache**        |  < 10 GB   | `stashcp` | Transfer large output into `/public`|  [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775) |
| **GridFTP or UNIX tools**        |  < 50 GB   | `gfal-copy`, `rsync`, `scp`, etc. | Typically used by experts with large work flows. Please contact us if you're interested.|


### External data transfer

|  | **Data Size**| **Tools** |**Details**|
|:------------|:-------:|:------|:------| 
|**UNIX tools** | < 1 GB | `rsync`, `scp`, Putty, WinSCP, `gFTP`, etc.  |[SCP](https://support.opensciencegrid.org/support/solutions/articles/5000634376) |


## Get Help
For assistance or questions, please email the OSG User Support team  at [support@osgconnect.net](mailto:support@osgconnect.net) or visit the [help desk and community forums](http://support.opensciencegrid.org).



 

