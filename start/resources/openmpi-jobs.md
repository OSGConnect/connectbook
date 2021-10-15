[title]: - "OpenMPI Jobs"

[TOC]

Even though the Open Science Pool is a high throughput computing system, sometimes
there is a need to run small OpenMPI based jobs. OSG has limited support for
this, as long as the core count is small (4 is known to work well, 8 and 16 
becomes more difficult due to the limited number of resources).


To get started, first compile your code using the OpenMPI in the modules
system. For example:

    $ module load openmpi
    $ mpicc -o hello hello.c 


You can test the executable locally using `mpiexec`:

    $ mpiexec -n 4 hello
    Hello world from process 1 of 4
    Hello world from process 3 of 4
    Hello world from process 0 of 4
    Hello world from process 2 of 4


To run your code as a job on the Open Science Pool, first create a `wrapper.sh`. Example:

    #!/bin/bash
    
    set -e
    
    module load openmpi
    
    mpiexec -n 4 hello


Then, a job submit file:

    Requirements = OSGVO_OS_STRING == "RHEL 7" && TARGET.Arch == "X86_64" && HAS_MODULES == True 
    request_cpus = 4
    request_memory = 4 GB

    executable = wrapper.sh

    transfer_input_files = hello

    output = job.out.$(Cluster).$(Process)
    error = job.error.$(Cluster).$(Process)
    log = job.log.$(Cluster).$(Process)

    queue 1


Note how the executable is the `wrapper.sh` script, and that the real executable `hello` is
transferred using the `transfer_input_files` mechanism.

Please make sure that the number of cores specified in the submit file via
`request_cpus` match the `-n` argument in the `wrapper.sh` file.

