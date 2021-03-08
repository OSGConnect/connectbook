[title]: - "Transitioning to a New Login Node"

[TOC]

## Summary

In January 2020, OSG Connect will transition to a new user management system, new login nodes, and new filesystem layout. The changes are detailed below, but in summary:

1. **New Website** The OSG Connect website, where you log in to manage your account details will look 
different and present information in a clearer way. 
1. **New Login Node** Instead of using a generic login node name (`login.osgconnect.net`), you will be assigned a 
specific, numbered login node to use, which will appear on your OSG Connect website profile. We’ve given you time to transition to the new login nodes, and recommend migrating workloads and data as soon as possible in light of the deadlines listed further below.
1. **New Filesystem** The filesystem layout is different on the new login nodes. `$HOME` is no longer a shared filesystem, `/local-scratch` no longer exists (use `$HOME` instead, for all job submission), and /public is a large shared space for larger job data that will need to be to be accessible to jobs via stashcp, http, and CVMFS.

## Deadlines

Access to the previous login nodes (`login02`, `login03`) will still be possible, however, we 
recommend migrating workloads and data as soon as possible in light of the following 
deadlines: 

* **January 9, 2020**: stashcp will no longer be able to access files in the old /stash folder, files must be in /public
* **January 22, 2020**: Submission of new jobs will be disabled on the old login nodes (login, login02, login03) to encourage users to transition to the new login nodes. (Already-submitted jobs and DAGs will be able to continue and complete up until March 31.)
* **March 31, 2020**: Data will be deleted from the old login nodes and the previous Stash data locations. 
* **After March 31, the existing login nodes and all data in their /home, /local-scratch, and previous Stash locations will be removed.** Because it may take time to move your data, it is important to begin transitioning as soon as possible!

## Action Items

Follow these steps to ensure you have your data and can continue to submit jobs:

1. Log into https://osgconnect.net. Confirm that your information is still correct, 
and find the name of the login node that you've been assigned. The login node 
information can be seen on your profile here: 
![Identify Login Node](https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/find_osgconnect_login_node.png "OSG Connect Profile")

	> **IMPORTANT** If you log into the OSG Connect website with your institutional credentials 
	and it asks you to sign up for OSG / create a profile, do NOT create a new profile. Instead, do the following: 
	> * close the OSG Connect page and go to http://globus.org. 
	> * Log in with your Globus ID and go to "Account" on the left-hand menu.
	> * If your institutional identity is already listed on that Account page, [email the OSG Connect support team](mailto:support@opensciencegrid.org)
	> * If your institutional identity is NOT listed on the account page, select "Link Another Identity" on the 
	> right and add your institutional identity. Then go back to the OSG Connect website and try to 
	> log in again. 

1. Log into the new login node and set your primary project. Follow the instructions 
at the bottom of the OSG project guide: [Join and Use a Project in OSG Connect](5000634360)

        $ connect project

1. Retrieve all the data from your old home directory. Migrate any files that you are still using to run jobs to your `/home` directory on the new assigned login node. Any other (older) files can be transferred back to your own personal computer / storage. The old $HOME directory is available under `/old-home/$USERNAME/`. For example:
   
        $ mv /old-home/$USERNAME/example-data $HOME/

1. Similarly, retrieve your data from Stash on the old login nodes. Note that the Stash equivalent on the new login nodes, `/public`, is all publicly readable - files can be downloaded from that folder by any person who has the correct link. For example, moving data from the old stash to the new public directory:
   
        $ mv /stash/user/$USERNAME/example-data /public/$USERNAME/
   
    This is a good time to clean up! Please use `mv` when moving the data from the old stash location and `rm` do remove any data you no longer need. If you leave data in the old stash location, we might contact you in the future to have it cleaned up.

1. Update your workloads for the new filesystem layout. Due to the change in paths (no 
more `/stash`, no `/local-scratch`), you may need to modify submit files and scripts 
to work correctly on the new log in nodes. If you are using stashcp, paths will need to be updated. Please read our updated guide on the new filesystem layout, how the different filesystems should be used, and quotas.
   
      * [New Data Management Guide](12000002985)
   
    In short, jobs should run from `$HOME` and can use `/public` for data access. 

## Other Questions

### Will there be GlobusOnline access? 

There will be no GlobusOnline access in the new set up. 

### Special projects (XENON, SPT, VERITAS, ...) - are they affected?

Not at this time.

### Why are we transitioning?

There are two drivers for this transition. The first one the new user management system which should make it much easier to sign up for OSG Connect and use it. A second reason is to simplify data access and increase the performance of the submit nodes.

 
