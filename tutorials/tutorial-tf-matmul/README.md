[title]: - "Tensorflow - A simple matrix multiplication"
[TOC] 

## Overview

In this tutorial, we see how to submit a [tensorflow](https://www.tensorflow.org/) job on the OSG through [Singularity containers](https://support.opensciencegrid.org/solution/articles/12000024676-singularity-containers).  We currently offer CPU and GPU  containers for tensorflow (both based on Ubuntu). Here, we focus on CPU container.  

## Tutorial files

Let us utilize the `tutorial` command. In the command prompt, type

	 $ tutorial tf-matmul  (Copies input and script files to the directory tutorial-tf-matmul)
 
This will create a directory `tutorial-tf-matmul` with the following files
   
    tf_matmul.py            (Python program to multiply two matrices using tensorflow package)
    tf_matmul.submit        (HTCondor Job description file)
    tf_matmul_wrapper.sh    (Job wrapper shell script that executes the python program) 

## Matrix multiplication with tensorflow

The Python program `tf_matmul.py` uses tensorflow to perform the matrix multiplication of a `2x2` matrix. Indeed, this is not
the best use case of tensorflow. This example is just fine to see how to submit the tensorflow job on the OSG. 

## Executing the script inside the singularity container

Before running this job on the OSG, let us see how to execute the tensorflow example on the submit host. Execute the Python program in the shell prompt

    $ python tf_matmul.py 

    Traceback (most recent call last):
      File "tf_matmul.py", line 3, in <module>
        import tensorflow as tf
    ImportError: No module named tensorflow

The error message says that tensorflow is not available. 

We need to execute the program inside the tensorflow container. Singularity offers couple of ways to run an image. One of them is to execute a shell inside the image (See [Singularity documentation for more details](http://singularity.lbl.gov/user-guide)). 

    $ singularity shell /cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow:latest

This should drop you inside the container shell in few minutes. The tensorflow image `tensorflow:latest` is located 
at /cvmfs/singularity.opensciencegrid.org/opensciencegrid/ (more details about image file construction and distribution are [outlined here](https://support.opensciencegrid.org/solution/articles/12000024676-singularity-containers))

Now we run the program inside the container

    $ python tf_matmul.py
    result of matrix multiplication
    ===============================
    [[  1.00000000e+00   0.00000000e+00]
     [ -4.76837158e-07   1.00000024e+00]]
    ===============================

This is a `2x2` matrix multiplication and should be done in a minute or two. 

Now let us see how to run this Python program on the remote machine as a singularity containter job. 

Note: You may see the warning 

     2017-07-16 12:31:44.841458: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use SSE4.1 instructions, but these are available on your machine and could speed up CPU computations.

that is related to the optimization of tensorflow installation on specific architecture. 

## Job execution and submission files

We want to run the program on a remote worker machine on the OSG that supports the singularity container. So we set the requirement in our HTCondor description 

    Requirements = HAS_SINGULARITY == True

In addition, we also provide the full path of the image via the keyword `+SingularityImage`:

    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow:latest"

The image is distributed to the remote worker machines through `cvmfs`. Although there are multiple ways to aquire the 
image file for a job on the OSG machine, the image distributed through `cvmfs` is preferred. 
 
Let us take a look at the  condor job description file `tf_matmul.submit`: 

    # The UNIVERSE defines an execution environment. You will almost always use VANILLA.
    Universe = vanilla

    # These are good base requirements for your jobs on OSG. It is specific on OS and
    # OS version, cores, and memory.
    Requirements = HAS_SINGULARITY == True
    request_cpus = 1
    request_memory = 2 GB
    request_disk = 4 GB

    # Singularity settings
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow:latest"

    # EXECUTABLE is the program that your job will run. It's often useful
    # to create a shell script to "wrap" your actual work.
    Executable = tf-matmul-wrapper.sh
    Arguments =

    # inputs/outputs
    transfer_input_files = tf_matmul.py
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

The wrapper script `tf-matmul-wrapper.sh` is pretty normal one which executes the python program. 

    #!/bin/bash
    python tf_matmul.py > tf_matmul.output

## Job submmision 

We submit the job using `condor_submit` command as follows

	$ condor_submit tf_matmul.submit 

The job will look for a machine on OSG that has singularity installed, creates the singularity container with the 
image `/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow:latest` and executes the program `tf_matmul.py`. 


The present job should be finished quickly (less than an hour). You can check the status of the submitted job by using the `condor_q` command as follows

	$ condor_q username  # The status of the job is printed on the screen. Here, username is your login name.

The output of the job is available in the file `tf_matmul.output`. 

## Running on GPUs

You can also steer the job to run on GPUs, but note that the number of GPUs available on 
OSG is limited. Even though the job will execute faster, it might sit in the queue waiting
longer than a CPU-only job.

The submit file for a GPU jobs is `tf_matmul_gpu.submit` The only difference is
`request_gpus = 1` and specifying a GPU image:

    request_gpus = 1
    ...
    +SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/tensorflow-gpu:latest"

## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).



