[title]: - "Storage Solutions on OSG: home, local-scratch, stash, and public"


## Overview

`home`, `local-scratch`, `stash`, and `public` are the data storage options for OSG Connect users.  Each storage offers certain advantages to the users. On the submit node (login.osgconnect.net), the storages are in the following locations,

    home: /home/username
    local-scratch: /local-scratch/username
    stash: /home/username/stash (or) /stash/user/username
    public: /home/username/public (or) /stash/user/username/public

Here, the `username` is your login name.. For convenience, the stash and public directories are accessed from home. Here, the `username` is your login name.

## home
Home is meant for storing files for quick access. Usually, files such as program files, parameter files, scripts, etc. are kept in your `/home` directory. Soft and hard disk quota are imposed on home for each user. The soft disk quota is 20 GB and the hard disk quota is 100 GB.  When a user exceeds his soft quota, the system sends email notification. When a user exceeds his hard quota, he will loose the privilege to write on home system. 

Home filesystem is not suitable to run your HTCondor jobs. It is a good practice to run all your jobs under the `stash` or the `local-scratch` directory.

## local-scratch
`local-scratch` is meant for temporary storage. It is a good practice to run your jobs on `local-scratch` and move the output data to a secondary local disk as soon as possible.  The data on `local-scratch` is removed after 30 days and is not backed up.

## stash
Stash provides medium term storage for users. Like home, there is no disk quota imposed on stash. However, the data on stash is not backed up, so you should regularly transfer your data on stash to a long term archival system.  If you are transfering more than 10GB, please use the Globus transfer service.  For more details check the articles on [data transfer techniques](https://support.opensciencegrid.org/solution/folders/5000260918).


## public
Files placed in the '~public' directory are publicly accessible via WWW as `http://stash.osgconnect.net/+username`. The data on `~/public` is accessible to the jobs on remote worker machine via the wget command. For more details of using public for condor input file transfer,  [click here](https://support.opensciencegrid.org/solution/articles/5000639798-access-stash-remotely-using-http).

## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).



 

