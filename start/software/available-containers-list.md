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
| EL 6 | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el6:latest</span> | Enterprise Linux (CentOS) 6 base image<br>[Project Website](https://www.centos.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-el6) |
| EL 7 | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7:latest</span> | Enterprise Linux (CentOS) 7 base image<br>[Project Website](https://www.centos.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-el7) |
| EL 7 CUDA 10 | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7-cuda10:10.2</span><br><span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7-cuda10:latest</span> | Enterprise Linux (CentOS) 7 base image, with CUDA 10<br>[Project Website](https://developer.nvidia.com/cuda-toolkit)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-el7-cuda10) |
| EL 8 | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el8:latest</span> | Enterprise Linux (CentOS) 8 base image<br>[Project Website](https://www.centos.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-el8) |

## Tool

| **Name** | **CVMFS Locations** | **Description** |
|:---------|:--------------------|:----------------|
| Quantum Espresso | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-quantum-espresso:6.6</span> | A suite for first-principles electronic-structure calculations and materials modeling<br>[Project Website](https://www.quantum-espresso.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-quantum-espresso) |

## Tools

| **Name** | **CVMFS Locations** | **Description** |
|:---------|:--------------------|:----------------|
| TensorFlow GPU | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow-gpu:2.3-cuda-10.1</span> | TensorFlow image with GPU support<br>[Project Website](https://www.tensorflow.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-tensorflow-gpu) |


[container-intro]: 12000024676
[container-howto]: 12000058245

