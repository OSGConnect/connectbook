[title]: - "Storage Solutions on OSG: home, stash, and public"


## Overview

`home`, `stash`, and `public` are the data storage options for the OSG users.  Each offers certain advantages to the users.

Location:

    home: /home/username
    stash: /home/username/stash
    public: /home/username/public

For convenience, the stash and public directories are accessed from your home directory. Here, the `username` is your login ID for your computing account on OSG. 

## home
Home is meant for storing programs, parameter files, etc., Although no quota imposed on home usage,  we recommend the usage of less than 10 GB. Home filesystem is not suitable to run your condor jobs. It is a good practice to run all your jobs under the STASH directory.

## stash
Stash provides a large temporary storage. Stash is the place you run all your condor jobs. Like home, there is no disk quota imposed on stash. However, the data on stash is not backed-up, so transfer the data to a secondary local disk (such as your local desktop, laptop, etc.,) on a regular basis.  For data transfer of more than 10 GB, use the globus transfer service.  For more details check the articles on [data transfer techniques](https://support.opensciencegrid.org/solution/folders/5000260918)


## public
Anybody could read the files under `~/public`. If you want to share some files with your collaborators, including those don't have any account on OSG, keep the files under `~/public`. The `~public` is available via WWW as `http://stash.osgconnect.net/+username`. The data on `~/public` is accessible to the jobs on remote worker machine via the wget command. For more details of using public for condor input file transfer,  [click here](https://support.opensciencegrid.org/solution/articles/5000639798-access-stash-remotely-using-http)

## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).



 

