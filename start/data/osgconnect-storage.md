[title]: - "Storage Solutions on OSG: home, local-scratch, stash, and public"


## Overview

`home`, `local-scratch`, `stash`, and `public` are the data storage options for OSG Connect users.  Each storage offers certain advantages to the users. On the submit node (login.osgconnect.net), the storages are in the following locations,

    home: /home/username
    local-scratch: /local-scratch/username
    stash: /home/username/stash (or) /stash/user/username
    public: /home/username/public (or) /stash/user/username/public

Here, the `username` is your login name.. For convenience, the stash and public directories are accessed from home. Here, the `username` is your login name.

## home
Home is meant for storing files long-term. Usually, files such as source code, parameter files, scripts, etc. are kept in your `/home` directory. The disk quota on home is 20 GBs. When a user exceeds his quota, the system will send email notifications. Eventually the user will loose the privilege to write on his home.

Home filesystem is not suitable to run your HTCondor jobs. It is a good practice to run all your jobs under the `local-scratch` or `stash` directories.

## local-scratch
`local-scratch` is meant for temporary storage, and is implemented as fast local disk for each submit node. It is a good practice to run your jobs on `local-scratch` and move the output data to a secondary local disk as soon as possible. NOTE: data on `local-scratch` is automatically removed after 30 days and is not backed up.

## stash
Stash provides medium term storage (less 6 months) for users. Stash is a distributed shared filesystem mounted on all our submit nodes, and is therefore slower than local-scratch. There is no disk quota imposed, nor a automatic purge, on stash. However, the data on stash is not backed up, so you should regularly transfer your data on stash to a long term archival system.  If you are transfering a large amount of data, please use the Globus transfer service.  For more details check the articles on [data transfer techniques](https://support.opensciencegrid.org/solution/folders/5000260918).  

**Note: Files and directories that have not been accessed for over six months may be deleted.**

## public
Files placed in the '~public' directory are publicly accessible via WWW as `http://stash.osgconnect.net/+username`. The data on `~/public` is accessible to the jobs on remote worker machine via the wget command. For more details of using public for condor input file transfer,  [click here](https://support.opensciencegrid.org/solution/articles/5000639798-access-stash-remotely-using-http).

## Getting Help
For assistance or questions, please email the OSG User Support team  at [support@osgconnect.net](mailto:support@osgconnect.net) or visit the [help desk and community forums](http://support.opensciencegrid.org).



 

