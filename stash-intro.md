[title]: - "Introduction to Stash"

Overview
--------

Stash (http://stash.osgconnect.net/) is a temporary data storage solution for your data workflow to accelerate access to cycles.  Use Stash to pre-stage job input datasets or write output files when they in aggregate they exceed more than what can be comfortably handled out of your home directory (e.g. on the login01.osgconnect.net host).   This will vary depending on the job type, but typically this occurs in the range of a few hundred megabytes to gigabytes. You can retrieve your job output from Stash at a later time, transferring the data wherever you store your precious datasets.

Usage
-----
If you have datasets on your campus' storage system, by far the easiest method is to use Globus Online as the file transfer service.  

Stash is mounted on all OSG Connect submit nodes (login.osgconnect.net) at /data, and is visible to workers via Parrot/Chirp. The portion of your Stash designated public is also available directly on the WWW as http://stash.osgconnect.net/+yourusername.

Projects have stashes, too!  A project's public stash can be found athttp://stash.osgconnect.net/@projectname.

Policy 
------
At present, the storage service is offered as a free scratch-like storage service and there are no user quotas.  When space on the system becomes tight, files will be removed on a simple least-recently-used basis.  
