[title]: - "Introduction to Data Management on OSG"

## Overview

OSG Connect users are responsible for managing data in their user directories within `home` (general job files), and `public` (large job files) locations and for using appropriate mechanisms for delivering data to/from jobs. User-accessible storage locations supported by OSG Connect (and accessible from the login nodes) include:

    home: /home/<username>
    public: /public/<username>

Each is controlled with initial quotas and should be treated as temporary storage for _active_ job execution. OSG Connect has no routine backup of data in these locations, and users should remove old data after jobs complete, in part, to make room for future submissions. *If you think you'll need more space for a set of concurrently-queued jobs, even after cleaning up old data, please send a request to [support@osgconnect.net]!*

**Note: OSG Connect staff reserve the right to remove data without notice to the user IF doing so is necessary to quickly fix a performance issue.**

## Storage of Data for Jobs

### Data Locations

|   | **Default Limit**| **Purpose** | **Network mounted** | **Backed Up** | **Initial Quota\*** |
|:-------- |:----------------:|:------|:------:|:------:|:------:|:------:|:----------|
| **home**    |  50 GB     | Storage of submit files, input files <100MB each, and per-job output up to a 1GB.| No | No | 50 GB | No |
| **public**  |  500 GB    | Staging large input files (100MB-50GB, each) for publicly-accessible download into jobs (using HTTP or stashcp, see below) and large output files (1-10GB) | Yes | No | 500 GB | Occasional |

### \*Contact [support@osgconnect.net](mailto:support@osgconnect.net) if you think you need a quota increase! We can suppport very large amounts of data, and quotas are a starting point.

### home
User directories within `/home` are meant for general-use storage of various files necessary for job submission. The initial disk quota on home is 50 GBs. When a user exceeds their quota, the system will send email notifications. If the notice is disregarded, eventually the user and their jobs will be unable to write to `/home`.

**All jobs should be submitted from within `/home`, and NOT from within `/public`. Contact [support@osgconnect.net](mailto:support@osgconnect.net) if you think you'll need a quota increase for a set of concurrently-running jobs.**

### public
Files placed within a user's '/public' directory are publicly accessible on the web via `http://stash.osgconnect.net/+<username>` and can be accessed by jobs running on remote worker machines via command-line download tools. Using the HTTP protocol (through `wget` or `curl`) is ideal for files less than 1 GB in size. Larger files will need to be accessed using the `stashcp` command. The `/public` location is a distributed shared filesystem mounted on all our submit nodes, and is therefore slower than `/home`. If you are transfering a large amount of data to or from `/public`, please use the Globus transfer service.  For more details check the articles on [data transfer techniques](https://opensciencegrid.freshdesk.com/a/solutions/folders/12000013267).  

**All jobs should be submitted from within `/home`, and NOT from within `/public`. Contact [support@osgconnect.net](mailto:support@osgconnect.net) if you think you'll need a quota increase for a set of concurrently-running jobs. Given that users should not be storing long-term data (like submit files, software, etc.) in `/public/`, files and directories that have not been accessed for over six months may be deleted by OSG Connect staff with or without notifying the user.**

## Transferring Data to/from Jobs
### Transferring input data to jobs

|         | **Recommended Files Sizes**| **Command** | **Purpose** | **Details**|
|:--------|:------:|:-----|:----------|:------|
| **HTCondor File Transfer** | < 100 MB input, <1GB output  | `transfer_input_files` | General-use transfer of job input from within `/home`. |[HTCondor File Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **HTTP** |  < 1 GB   | `wget`, `curl`, or `rsync`  | For large input files from within `/public`. |[HTTP Access](https://support.opensciencegrid.org/support/solutions/articles/5000639798)|
| **OSG's StashCache** |  > 1 GB, < 50 GB    | `stashcp` | for large input files from within `/public`| [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775)|
| **GridFTP** |  > 1 GB    | `gfal-copy` | input staged in /public | Typically used by experts with large work flows. Please contact us if you're interested. |


### Transferring output data from jobs

|         | **Recommended File Sizes**| **Command** | **Purpose** | **Details**|
|:---------|:------:|:-----|:----------|:------|
| **HTCondor**    | < 1 GB  | HTCondor default output transfer (or `transfer_output_files`) | General-use transfer of job output data back to the submission directory (in `/home`). |[HTCondor Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **StashCache**        |  < 10 GB   | `stashcp` | Transfer large output into `/public`|  [StashCache](https://support.opensciencegrid.org/support/solutions/articles/12000002775) |
| **GridFTP or UNIX tools**        |  < 50 GB   | `gfal-copy`, `rsync`, `scp`, etc. | Typically used by experts with large work flows. Please contact us if you want to use this.|


### External data transfer

|  | **Data Size**| **Tools** |**Details**|
|:------------|:-------:|:------|:------| 
|**UNIX tools** | < 1 GB | `rsync`, `scp`, Putty, WinSCP, `gFTP`, etc.  |[SCP](https://support.opensciencegrid.org/support/solutions/articles/5000634376) |
|**Globus** |  > 1 GB  | globus webservice or globus CLI | [Globus](https://support.opensciencegrid.org/support/solutions/articles/5000632397) |


## Get Help
For assistance or questions, please email the OSG User Support team  at [support@osgconnect.net](mailto:support@osgconnect.net) or visit the [help desk and community forums](http://support.opensciencegrid.org).



 

