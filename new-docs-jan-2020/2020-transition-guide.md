[title]: - "Transitioning to a new login node"

[TOC]

## Summary

In January 2020, OSG Connect will transition to a new user management system, new login nodes, and new filesystem layout. The changes are detailed below, but in summary:

1. User have been assigned to a new login nodes
2. The filesystem layout is different on the new login nodes. $HOME is no longer a shared filesystem, /local-scratch no longer exists, and /public is a large shared space accessible via stashcp, http, and CVMFS.
3. New website, including user account management.


## Why are we transitioning?

There are two drivers for this transition. The first one the new user management system which should make OSG-Connect much easier to signup for and use. A second reason is to simplify data access and increase the performance of the submit nodes.


## What do users need to do?

Data and workloads should be migrated by **January 15**. After that day, no new jobs will be allowed to be submitted on the old login nodes, and after **March 31**, data will be deleted from the old submit nodes and the previous Stash data locations. Follow these steps to ensure you have your data and can continue to submit:

1. Find out your assigned login node by accessing https://osgconnect.net
2. Migrate the data from your old home directory to $HOME on the new assigned login node
3. Migrate any data from Stash to /public
4. Update any workloads for the new filesystem layout

It is important to understand the new filesystem layout, how the different filesystems should be used, and quotas. See docs [here]. In short, jobs should run from $HOME and can use /public for data access.


## No GlobusOnline access

There will be no GlobusOnline access.



## Special projects (XENON, SPT, VERITAS, ...) - are they affected?

Not at this time.

