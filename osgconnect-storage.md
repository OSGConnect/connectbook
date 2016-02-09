[title]: - "Storage Solutions on OSG: Home, Stash, and Public"


Overview
--------

`HOME`, `STASH`, and `PUBLIC` are the data storage options for the OSG users.  Each offers certain advantages to the users.

Location:

    HOME: /home/username
    STASH: /home/username/stash
    PUBLIC: /home/username/public

HOME
----
Home is meant for storing programs, parameter files, etc., Although home usage does not have any quota restrictions, we recommend
the usage of home to less than 10 GB. Home filesystem is not suitable to run your condor jobs. It is a good practice to run your jobs under the STASH directory.

STASH
-----
Stash provides a large temporary storage. Stash is the place you run your jobs. Like home, there is no quota imposed on stash. However, the data on stash is not backed-up, so copy the files on a regular basis.  For data transfer of more than 10 GB, use the globus transfer service.   More details here:


PUBLIC
------
Anybody could read the files under `~/public`. If you want to share some files with your collaborators (including those don't have any account on OSG), keep the files under `~/public`. The `~public` is available via WWW as `http://stash.osgconnect.net/+username`.

 

