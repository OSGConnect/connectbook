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
[https://support.opensciencegrid.org/solution/articles/12000024676-singularity-containers](Singularity containers).
We currently offer two containers (both based on Ubuntu):

1. __/cvmfs/singularity.opensciencegrid.org/tensorflow/tensorflow:latest__ is the
   standard CPU-only Docker image published by the TensorFlow project
2. __/cvmfs/singularity.opensciencegrid.org/rynge/osg-tensorflow-gpu:latest__ is a
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
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/tensorflow/tensorflow:latest"
    
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
    
    # Send the job to Held state on failure. 
    on_exit_hold = (ExitBySignal == True) || (ExitCode != 0)
    
    # Periodically retry the jobs every 1 hour, up to a maximum of 5 retries.
    periodic_release =  (NumJobStarts < 5) && ((CurrentTime - EnteredCurrentStatus) > 60*60)
    
    # QUEUE is the "start button" - it launches any jobs that have been
    # specified thus far.
    Queue 1


This job is mapped to sites which support Singularity, and auto-loads the TensorFlow image. Your
job will start inside the container under /srv.

The submit file for GPU jobs is similar, but with _request_gpus = 1_ and _+SingularityImage_ 
set to the GPU image.


    # The UNIVERSE defines an execution environment. You will almost always use VANILLA.
    Universe = vanilla
    
    # These are good base requirements for your jobs on OSG. It is specific on OS and
    # OS version, core cound and memory, and wants to use the software modules. 
    Requirements = HAS_SINGULARITY == True
    request_cpus = 1
    request_gpus = 1
    request_memory = 2 GB
    request_disk = 4 GB
    
    # Singularity settings
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/rynge/osg-tensorflow-gpu:latest"
    
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
    
    # Send the job to Held state on failure. 
    on_exit_hold = (ExitBySignal == True) || (ExitCode != 0)
    
    # Periodically retry the jobs every 1 hour, up to a maximum of 5 retries.
    periodic_release =  (NumJobStarts < 5) && ((CurrentTime - EnteredCurrentStatus) > 60*60)
    
    # QUEUE is the "start button" - it launches any jobs that have been
    # specified thus far.
    Queue 1


When running on the GPU image, some extra environment settings are required. We recommend a 
job wrapper like:


    #!/bin/bash

    set -e
    
    export PATH=/usr/local/cuda-8.0/bin:/usr/loca/bin:/usr/bin:/bin
    export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64
    
    echo
    nvidia-smi
    echo
    
    echo
    nvcc --version 
    echo
   
    # your own code here 
    python test.py gpu 1500


