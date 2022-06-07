[title]: - "Multicore Jobs"

[TOC]

Please note, the OSG has limited support for multicore jobs. Multicore jobs
can be submitted for threaded or OpenMP applications. To request multiple cores
(aka cpus) use the HTCondor *request_cpus* attribute in your submit file. 

Example:

    +has_mpi = true 
    request_cpus = 8

The submit file line `+has_mpi = true` is important for making sure MPI jobs are run on execute points that support MPI work. For multicore jobs, we recommend requesting a maximum of 8 cpus, which can be requested using `request_cpus =`. 

**Important considerations**    
When submitting multicore jobs please note that you will also have to tell 
your code or application to use the number of cpus requested in your submit 
file. Do not use core auto-detection as it might detect more cores than what 
were actually assigned to your job.

