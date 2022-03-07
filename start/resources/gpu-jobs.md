[title]: - "Using GPUs on the OSPool"

[TOC]

The Open Science Pool has an increasing number of GPUs available to 
run jobs. 

# Requesting GPUs

To request a GPU for your HTCondor job, you can use the 
HTCondor *request_gpus* attribute in your submit file (along 
with the usual *request_cpus*, *request_memory*, and *request_disk*
attributes). For example:

    request_gpus = 1
    request_cpus = 1
    request_memory = 4 GB
    request_disk = 2 GB

Currently, a job can only use 1 GPU at the time.

You should only request a GPU if your software has been written to use a GPU. It is 
also worth running test jobs on a GPU versus CPUs-only, to observe the amount of 
speed up. 

## Specific GPU Requests

HTCondor records different GPU attributes that can be used to select 
specific types of GPU devices. A few attributes that may be useful: 

* `CUDACapability`: this is NOT the CUDA library, but rather a measure of the GPU's "Compute Capability"
* `CUDADriverVersion`: maximum version of the CUDA libraries that can be supported on the GPU
* `CUDAGlobalMemoryMb`: amount of GPU memory available on the GPU device

Any of the attributes above can be used in the submit file's `requirements` line to 
select a specific kind of GPU. For 
example, to request a GPU with more than 8GB of GPU memory, one could use: 

    requirements = (CUDAGlobalMemoryMb >= 8192)
    
If you want a certain type or family of GPUs, we usually recommend using the GPU's 
'Compute Capability', known as the `CUDACapability` by HTCondor. An A100 GPU has a 
Compute Capability of 8.0, so if you wanted to run on an A100 GPU specifically, 
the submit file requirement would be: 

    requirements = (CUDACapability == 8.0)

**Note that the more requirements you include, the fewer resources will be available 
to you! It's always better to set the minimal possible requirements (ideally, none!) 
in order to access the greatest amount of computing capacity.**

# Available GPUs

Just like CPUs, GPUs are shared with the OSG community only when the
resource is idle. Therefore, we do not know exactly what resources are
available at what time. When requesting a GPU job, you might land on one
of the following types of GPUs:

* Tesla K20m, K40m (CUDACapability: 3.5)
* GTX 1080 Ti (CUDACapability: 6.1)
* V100 (CUDACapability: 7.0)
* Quadro RTX 6000 (CUDACapability: 7.5)
* A100 (CUDACapability: 8.0)
* A40 (CUDACapability: 8.6)

# Software and Data Considerations

## Software for GPUs

For GPU-enabled machine learning libraries, we recommend using 
containers to set up your software for jobs: 

  * [Using Containers on the OSPool](https://support.opensciencegrid.org/solution/articles/12000024676-singularity-containers)
  * [Sample TensorFlow GPU Container Image Definition](https://github.com/opensciencegrid/osgvo-tensorflow-gpu/blob/master/Dockerfile)
  * [TensorFlow Example Job](https://support.opensciencegrid.org/solution/articles/12000028940-tensorflow)

## Data Needs for GPU Jobs

As with any kind of job submission, check your data sizes (per job) before submitting 
jobs and choose the appropriate file transfer method for your data. 

See our [Data Staging and Transfer guide](https://support.opensciencegrid.org/support/solutions/articles/12000002985-overview-data-staging-and-transfer-to-jobs#transferring-data-tofrom-jobs) for
details and contact the Research Computing Facilitation team with questions. 
