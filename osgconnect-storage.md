[title]: - "Storage Solutions on OSG Connect"


Overview
--------

`HOME`, `STASH`, and `PUBLIC` are the data storage options for the OSG users.  Each offers certain advantages to the users.

Location:

    HOME: /home/username
    STASH: /home/username/stash
    PUBLIC: /home/username/public

HOME
----
The storage on home is meant for storing programs, parameter files, etc., Although there is no quota set for home, we recommend
the usage of home to less than 10 GB. Running jobs under home directory is not recommended. It is a good practice to run your jobs under
the STASH directory.

STASH
-----
Submit the jobs from stash since it provides a large temporary storage. Like home, there is no quota imposed on stash. However, the data on stash is not backed-up, so copy the files on a regular basis.  For data transfer of more than 10 GB, use the globus transfer service.   More details here:


PUBLIC
------
Anybody could read the files under `~/public`. If you want to share some files with your collaborators (including those don't have any account on OSG), 
keep the files under `~/public`. The `~public` is available via WWW as `http://stash.osgconnect.net/+username`.

 

