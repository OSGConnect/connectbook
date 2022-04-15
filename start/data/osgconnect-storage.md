[title]: - "Overview: Data Staging and Transfer to Jobs"

[TOC]

# Overview

OSG Connect provides two locations for uploading files (data and software) that are 
needed for running jobs: 

    home: /home/<username>          (general storage from which ALL jobs should be submitted)
    public: /public/<username>      (only for large job input and output using stash links (input) and stashcp (output))

In general, OSG Connect users are responsible for managing data in 
these folders and for using appropriate mechanisms for delivering 
data to/from jobs, as detailed below. Each is controlled with a 
quota and should be treated as temporary storage for _active_ 
job execution. OSG Connect has no routine backup of data in these 
locations, and users should remove old data after jobs complete, 
in part, to make room for future submissions. **If you think you'll 
need more space for a set of concurrently-queued jobs, even after 
cleaning up old data, please send a request to 
[support@opensciencegrid.org](mailto:support@opensciencegrid.org)!**

For additional data information, see also the "Data Storage and Transfer" section of 
our [FAQ](5000634384#data-storage-and-transfer). 

**Note: OSG Connect staff reserve the right to monitor and/or remove 
data without notice to the user IF doing so is necessary for ensuring 
proper use or to quickly fix a performance or security issue.**

# Data Locations and Quotas

Your OSG Connect account includes access to two data storage locations: 
`/home` and `/public`. **Where you store your files and how your files 
are made accessible to your jobs depends on the size of the file and how 
much data is needed or produced by your jobs.**   

|  **Location**  |  **Storage Needs**         | **Network mounted** | **Backed Up?** | **Initial Quota** |
|     :-----:    |    :------:          |       :------:      |   :------:    |      :------:      |
|     `/home`    | Storage of submit files, input files <100MB each, and per-job output<br>up to a 1GB.  Jobs should ONLY be submitted from this folder.   |   No   |   No   |  50 GB  |
|  `/public`     | Staging ONLY for large input files (100MB-50GB, each) for publicly-accessible<br>download into jobs (using `stash:///` links or `stashcp` see below) and large output files (1-10GB). | Yes | No | 500 GB |
    
<br>

Your quota status will be displayed when you connect to your OSG Connect login node: 

    Disk utilization for username:
    /public   : [                        ] 0% (0/500000 MB)
    /home     : [ #                      ] 4% (2147/53687 MB)

You can also display your quota usage at any time using the command 
`quota` while connected to your login node.

**Don't hesitate to contact us at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) if you 
think you need a quota increase! We can support very large amounts of data.**

## `/home` Usage And Policies

User directories within `/home` are meant for general-use storage of your files 
needed for job submission. The initial quota per user is 50 GBs, and can be increased by request
to support@opensciencegrid.org when a user needs more space for appropriately-sized files.

**ALL JOBS MUST BE SUBMITTED FROM WITHIN `/home`**. Users are also prohibited 
from making their `/home` directory world-readable due to security concerns. See 
[Policies for Using OSG via OSG Connect Submit Servers](https://support.opensciencegrid.org/support/solutions/articles/12000074852) for more details. 

If you're unable to submit jobs or your jobs are going on hold because you've 
reached your `/home` quota, please contact us at 
[support@opensciencegrid.org](mailto:support@opensciencegrid.org) about a quota increase.

## `/public` Usage and Policies

User directories within `/public` are meant **ONLY** for staging job files too large for regular 
HTCondor file transfer (per-job input greater than 100MB, or per-job output greater than 1GB), and should only OSG caching 
mechanisms (see tables for input and output, further below).

**JOBS MUST NEVER BE SUBMITTED FROM WITHIN `/public`**, and should not list `/public` files in the 
`transfer_input_files` or other lines of a submit file, unless as a `stash:///` address (see tables further below). 
Files placed in `/public` should only be accessed by jobs using the below tools (see 
[Transferring Data To/From Jobs](#transferring-data-tofrom-jobs)). Users violating these policies may 
lose the ability to submit jobs until their submissions are corrected.

The initial disk quota of `/public` is 500 GBs. Contact [support@opensciencegrid.org](mailto:support@opensciencegrid.org) 
if you will need an increase for concurrently running work, after cleaning up all 
data from past jobs. **Given that users should not be storing long-term data (like submit files, 
software, etc.) in `/public`, files and directories that have not been accessed for over six 
months may be deleted by OSG Connect staff with or without notifying the user.**

Files placed within a user's `/public` directory **are publicly accessible**, 
discoverable and readable by anyone. Data is made public via the `stash` transfer mechanisms (which also make data public via http/https), and mirrored 
to a shared data repository which is available on a large number of systems around the world.

### Is there any support for private data?

If you do not want your data to be downloadable by anyone, and it's small enough for
HTCondor file transfer, then it should be staged in your `/home` directory and 
transferred to jobs with HTCondor file transfer (`transfer_input_files` in the submit 
file). If it cannot be public (cannot use http or stash for job delivery), and is too
large for HTCondor file transfer, then it's not a good fit for the open environment of 
the Open Science Pool, and another resource will likely be more appropriate. As a 
reminder, if the data is not being used for active computing work on OSG Connect, it 
should not be stored on OSG Connect systems, and our data storage locations are not 
backed up or suitable for project-duration storage.

## External Data Transfer to/from OSG Connect Login Nodes

In general, common Unix tools such as `rsync`, `scp`, Putty, WinSCP, `gFTP`, etc. can be used to upload data from your computer to the OSG Connect login node, or to download files from the OSG Connect login node. 
         
<br>

# Transferring Data To/From Jobs

## Transferring Input Data to Jobs

This table summarizes the options for sending input files from the OSG Connect 
login node to the execution node where a job is running. This assumes that you 
have already uploaded these input files from your own computer to your OSG Connect login node. 

|  **Transfer Method** | **File Sizes**| **File Location** | **Command** | **More Info** |
|      :--------:     |    :------:   |       :-----:     |    :-----:  |   :--------:   |
| **regular HTCondor<br>file transfer** | <100 MB;<br><500 MB total per job | `/home` | `transfer_input_files` | [HTCondor File Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
| **OSG's<br> transfer tools** | >1GB;<br><10 GB per job | `/public` | `stash` address in `transfer_input_files` | [Stash Transfer](https://support.opensciencegrid.org/support/solutions/articles/12000002775)|
| **HTTP** |  <1GB | non-OSG web server | `http` address in `transfer_input_files`  |[HTTP Access](https://support.opensciencegrid.org/support/solutions/articles/5000639798)|
| **GridFTP** |  > 10 GB | `/public` or non-OSG data server | `gfal-copy` | [contact us](mailto:support@opensciencegrid.org) |
    
<br>

## Transferring Output Data from Jobs

This table summarizes a job's options for returning output files generated by the job back to the OSG Connect login node. 

|  **Transfer Method**  |   **File Sizes**     |  **Transfer To**  |    **Command**     |   **More Info**  |
|      :---------:       |        :------:      |       :-----:     |     :--------:     |     :------:     |
|      **regular HTCondor file transfer**      |         < 1 GB       |      `/home`      |  HTCondor default output transfer or `transfer_output_files` | [HTCondor Transfer](https://support.opensciencegrid.org/support/solutions/articles/5000639787)|
|     **OSG's transfer tools**     |  >1GB and<br>< 10 GB |      `/public`    |      `stashcp` in job executable    |   [stashcp](https://support.opensciencegrid.org/support/solutions/articles/12000002775) |
|       **GridFTP**      |        > 10 GB       |      `/public`    |     `gfal-copy`    | [contact us](mailto:support@opensciencegrid.org) |
    
<br>

**Watch this video from the 2021 OSG Virtual School** for more information about Handling Data on OSG:

[<img src="https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/Handling_Data_Video_Thumbnail.png" width="500">](https://www.youtube.com/embed/YBGWycYZRD4)

# Get Help
For assistance or questions, please email the OSG Research Facilitation team  at [support@opensciencegrid.org](mailto:support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).
