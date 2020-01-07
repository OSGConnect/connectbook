[title]: - "TensorFlow"

[TOC] 

## About TensorFlow

[https://www.tensorflow.org/](https://www.tensorflow.org/) desribes TensorFlow as:

> TensorFlow is an open source software library for numerical
> computation using data flow graphs. Nodes in the graph represent
> mathematical operations, while the graph edges represent the
> multidimensional data arrays (tensors) communicated between them. The
> flexible architecture allows you to deploy computation to one or more
> CPUs or GPUs in a desktop, server, or mobile device with a single
> API. TensorFlow was originally developed by researchers and engineers
> working on the Google Brain Team within Google's Machine Intelligence
> research organization for the purposes of conducting machine learning
> and deep neural networks research, but the system is general enough to
> be applicable in a wide variety of other domains as well.


## TensorFlow on OSG

You can use TensorFlow on OSG by running your jobs through 
[Singularity containers](https://support.opensciencegrid.org/solution/articles/12000024676-singularity-containers) .  We currently offer two containers (both based on Ubuntu):

1. __/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow:latest__ is the
   CPU only version of TensorFlow. This runs slower, but OSG has many more CPU only
   resources available than GPU resources.
2. __/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow-gpu:latest__ is a
   modified TensorFlow-GPU image to be used on the GPUs available on OSG.

Note that there is still only a small number of GPUs available on OSG, so we 
recommend the first image, at least to get started with.

A sample job submit file for the CPU case is:


    # The UNIVERSE defines an execution environment. You will almost always use VANILLA.
    Universe = vanilla
    
    # These are good base requirements for your jobs on OSG. It is specific on OS and
    # OS version, core cound and memory, and wants to use the software modules. 
    Requirements = HAS_SINGULARITY == True
    request_cpus = 1
    request_memory = 2 GB
    request_disk = 4 GB
    
    # Singularity settings
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow:latest"
    
    # EXECUTABLE is the program your job will run It's often useful
    # to create a shell script to "wrap" your actual work.
    Executable = job-wrapper.sh
    Arguments = 
    
    # inputs/outputs
    transfer_input_files = test.py
    transfer_output_files = 
    
    # ERROR and OUTPUT are the error and output channels from your job
    # that HTCondor returns from the remote host.
    Error = $(Cluster).$(Process).error
    Output = $(Cluster).$(Process).output
    
    # The LOG file is where HTCondor places information about your
    # job's status, success, and resource consumption.
    Log = $(Cluster).$(Process).log
    
    # QUEUE is the "start button" - it launches any jobs that have been
    # specified thus far.
    Queue 1


This job is mapped to sites which support Singularity, and auto-loads the TensorFlow image. Your
job will start inside the container under /srv.

The submit file for GPU jobs is similar, but with _request_gpus = 1_ and _+SingularityImage_ 
set to the GPU image. Note that you might also need _CUDACapability_ in the requirements
to make sure you land on a GPU new enough to support the feature set TensorFlow requires.


    # The UNIVERSE defines an execution environment. You will almost always use VANILLA.
    Universe = vanilla
    
    # These are good base requirements for your jobs on OSG. It is specific on OS and
    # OS version, core cound and memory, and wants to use the software modules. 
    Requirements = HAS_SINGULARITY == True && CUDACapability >= 3
    request_cpus = 1
    request_gpus = 1
    request_memory = 2 GB
    request_disk = 4 GB
    
    # Singularity settings
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow-gpu:latest"
    
    # EXECUTABLE is the program your job will run It's often useful
    # to create a shell script to "wrap" your actual work.
    Executable = job-wrapper.sh
    Arguments = 
    
    # inputs/outputs
    transfer_input_files = test.py
    transfer_output_files = 
    
    # ERROR and OUTPUT are the error and output channels from your job
    # that HTCondor returns from the remote host.
    Error = $(Cluster).$(Process).error
    Output = $(Cluster).$(Process).output
    
    # The LOG file is where HTCondor places information about your
    # job's status, success, and resource consumption.
    Log = $(Cluster).$(Process).log
    
    # QUEUE is the "start button" - it launches any jobs that have been
    # specified thus far.
    Queue 1


When running on the GPU image, some extra control over the environment might be required.
We recommend a job wrapper like:


    #!/bin/bash

    set -e
   
    # your own code here 
    python test.py gpu 1500


