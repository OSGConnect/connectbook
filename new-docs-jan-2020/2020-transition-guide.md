[title]: - "Transitioning to a New Login Node"

[TOC]

## Summary

In January 2020, OSG Connect will transition to a new user management system, new login nodes, and new filesystem layout. The changes are detailed below, but in summary:

1. **New Website** The OSG Connect website, where you log in to manage your account details will look 
different and present information in a clearer way. 
1. **New Login Node** Instead of using a generic login node name (`login.osgconnect.net`), you will be assigned a 
specific, numbered login node to use, which will appear on your OSG Connect website profile. 
1. **New Filesystem** The filesystem layout is different on the new login nodes. `$HOME` is no longer a shared filesystem, `/local-scratch` no longer exists, and `/public` is a large shared space accessible via stashcp, http, and CVMFS.

## Deadlines

You should have access to your newly assigned login node by December 26, 2019. Access to 
the previous login nodes (`login02`, `login03`) will still be possible, however, we 
recommend migrating workloads and data as soon as possible in light of the following 
deadlines: 

* **January 15, 2020**: Job submission on the old login nodes (`login02`, `login03`) will be disabled. 
* **March 31, 2020**: Data will be deleted from the old login nodes and the previous Stash data locations. 

## Action Items

Follow these steps to ensure you have your data and can continue to submit jobs:

1. Log into https://osgconnect.net. Confirm that your information is still correct, 
and find the name of the login node that you've been assigned. The login node 
information can be seen on your profile here: 

![Identify Login Node](https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/find_osgconnect_login_node.png "OSG Connect Profile")

1. Log into the new login node and set your primary project. Follow the instructions 
at the bottom of the OSG project guide: [Join and Use a Project in OSG Connect](12000065615)

1. Retrieve all the data from your old home directory. Migrate any files that you are 
still using to run jobs to your `/home` directory on the new assigned login node. Any other (older) files can be transferred back to your own personal computer / storage. 

1. Similarly, retrieve your data from Stash on the old login nodes. Note that the Stash 
equivalent on the new login nodes, `/public`, 
 is all publicly readable - files can be downloaded from that folder 
by any person who has the correct link. 

1. Update your workloads for the new filesystem layout. Due to the change in paths (no 
more `/stash`, no `/local-scratch`), you may need to modify submit files and scripts 
to work correctly on the new log in nodes. Please read our updated guide on the new filesystem layout, how the different filesystems should be used, and quotas. 
    * [New Data Management Guide](12000065613)
In short, jobs should run from `$HOME` and can use `/public` for data access.

## Other Questions

### Will there be GlobusOnline access? 

There will be no GlobusOnline access in the new set up. 

### Special projects (XENON, SPT, VERITAS, ...) - are they affected?

Not at this time.

### Why are we transitioning?

There are two drivers for this transition. The first one the new user management system which should make it much easier to sign up for OSG Connect and use it. A second reason is to simplify data access and increase the performance of the submit nodes.


