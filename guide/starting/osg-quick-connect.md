[title]: - "OSG Quick Connect"

[TOC] 

The requirements to connect your cluster to the OSG using this method are minimal:

	1.  Create a normal user account for the OSG Connect service.
	2.  Provide ssh access to this account via public ssh key.
	3.  Add the OSG Connect user to the FUSE user group (this is to provide access to the network-based OSG software repository).
	4.  (Optional) Install a local http proxy service (Squid) providing about 1 TB of disk storage to cache software libraries locally at your site.
	5.  (Optional) Install a data cache service on a node providing 10-48 TB of local cache for data intensive workloads.

Usually a couple of phone calls between the technical administrators from both teams is needed to complete the task. We have successfully used this approach to connect to several campus based clusters, including those at Syracuse University (OrangeGrid), Clemson University (Palmetto). We have also applied this method for the [ATLAS Connect campus grid][atlas], which routes ATLAS Monte Carlo simulations of collisions at the CERN LHC to clusters at Indiana University (Karst), TACC (Stampede), Cal State Fresno (ATLAS Tier3 Center), University of Illinois (Illinois Campus Cluster), and Harvard University (Odyssey).

Drop us a note at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) if this option is of interest to you.

[atlas]: http://connect.usatlas.org

