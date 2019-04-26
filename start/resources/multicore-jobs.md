[title]: - "Multicore Jobs"

[TOC]

OSG has limited support for multicore jobs. These can be used for
threaded or OpenMP applications. To request a multicore slot, simply use 
the HTCondor *request_cpus* attribute in your submit file. Example:

    request_cpus = 8

Multicore jobs can currently request up to 8 cores. Please note that
you have to limit your code to the same number of cores. Do not use
core auto-detection as it might detect cores not assigned to your job.
If you request 8 cores from the scheduler, limit your code to 8
threads as well.

