[title]: - "GPU Jobs"

[TOC]

OSG has limited support for GPU jobs. To request a GPU slot, simply use 
the HTCondor *request_gpus* attribute in your submit file, as well
as *request_cpus* and *request_memory*. Example:

    request_gpus = 1
    request_cpus = 1
    request_memory = 4 GB

Currently, a job can only use 1 GPU at the time.

Just like CPUs, GPUs are shared with the OSG community only when the
resource is idle. Therefore, we do not know exactly what resources are
available at what time. When requesting a GPU job, you might land on one
of the following types of GPUs:

  * Tesla M2070
  * Tesla K20
  * Tesla K40
  * Tesla P100
  * GeForce GTX 1080

It is currently not possible to specify which type of GPU you want.

A good example on how create a software stack for GPU use is our
TensorFlow example:

  * [TensorFlow Documentation](https://support.opensciencegrid.org/solution/articles/12000028940-tensorflow)
  * [Singularity Custom Images](https://support.opensciencegrid.org/solution/articles/12000024676-singularity-containers)
  * [TensorFlow GPU Image Definition](https://github.com/opensciencegrid/osgvo-tensorflow-gpu/blob/master/Dockerfile)

