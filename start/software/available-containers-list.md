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
| EL 7 CUDA 10 | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7-cuda10:10.1</span><br><span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7-cuda10:10.2</span><br><span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el7-cuda10:latest</span> | Enterprise Linux (CentOS) 7 base image, with CUDA 10<br>[Project Website](https://developer.nvidia.com/cuda-toolkit)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-el7-cuda10) |
| EL 8 | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el8:latest</span> | Enterprise Linux (CentOS) 8 base image<br>[Project Website](https://www.centos.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-el8) |
| Ubuntu 16.04 | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-ubuntu-xenial:latest</span> | Ubuntu 16.04 (Xenial) base image<br>[Project Website](https://www.ubuntu.com)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-ubuntu-xenial) |
| Ubuntu 18.04 | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-ubuntu-18.04:latest</span> | Ubuntu 18.04 (Bionic) base image<br>[Project Website](https://www.ubuntu.com)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-ubuntu-18.04) |
| Ubuntu 20.04 | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-ubuntu-20.04:latest</span> | Ubuntu 20.04 (Focal) base image<br>[Project Website](https://www.ubuntu.com)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-ubuntu-20.04) |

## Tools

| **Name** | **CVMFS Locations** | **Description** |
|:---------|:--------------------|:----------------|
| FreeSurfer | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-freesurfer:6.0.0</span><br><span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-freesurfer:6.0.1</span> | A software package for the analysis and visualization of structural and functional neuroimaging data from cross-sectional or longitudinal studies<br>[Project Website](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-freesurfer) |
| Quantum Espresso | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-quantum-espresso:6.6</span> | A suite for first-principles electronic-structure calculations and materials modeling<br>[Project Website](https://www.quantum-espresso.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-quantum-espresso) |
| TensorFlow | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow:2.3</span><br><span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow:latest</span> | TensorFlow image (CPU only)<br>[Project Website](https://www.tensorflow.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-tensorflow) |
| TensorFlow GPU | <span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow-gpu:2.2-cuda-10.1</span><br><span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow-gpu:2.3-cuda-10.1</span><br><span style="white-space: nowrap">/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow-gpu:latest</span> | TensorFlow image with GPU support<br>[Project Website](https://www.tensorflow.org/)<br>[Container Definition](https://github.com/opensciencegrid/osgvo-tensorflow-gpu) |


[container-intro]: 12000024676
[container-howto]: 12000058245

