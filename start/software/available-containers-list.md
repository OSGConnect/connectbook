[title]: - "Available Containers List"

[TOC]

This is list of commonly used containers in Open Science Grid. These can be used
directly in your jobs or as base images if you want to define your own. Please
see the pages on [container overview][container-intro] and [defining containers][container-howto]
for detailed instructions.

Also note that this list is not complete. There are many images under
`/cvmfs/singularity.opensciencegrid.org/` which are either project specific
or not described well enough to make this list.


## Base

| **Name** | **CVMFS Locations** | **Description** |
|:---------|:--------------------|:----------------|
| EL 7 | `/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7:latest` | Enterprise Linux (CentOS) 7 base image<br>[Project Website](https://www.centos.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-el7) |
| EL 8 | `/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el8:latest` | Enterprise Linux (CentOS) 8 base image<br>[Project Website](https://www.centos.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-el8) |

## Tool

| **Name** | **CVMFS Locations** | **Description** |
|:---------|:--------------------|:----------------|
| Quantum Espresso | `/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-quantum-espresso:6.6` | A suite for first-principles electronic-structure calculations and materials modeling<br>[Project Website](https://www.quantum-espresso.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-quantum-espresso) |


[container-intro]: 12000024676
[container-howto]: 12000058245

