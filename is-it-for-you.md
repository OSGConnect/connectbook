[title]: - "Is High Throughput Computing for you?"


## Ideal Charateristics for Distributed High Throughput Computing (HTC)

-   Your science workflow can be split into independent jobs.
-   These jobs can be run on a single processor or compute node.
-   Your application software is “portable”. (We can help make applications portable and also provide pre-installed software modules)



## Challenges to Distributed HTC

Your application may present additional challenges, but many of these have solutions on the OSG:

-   Computations that access or produce large datasets. 
-   Your computations need small scale parallelism:
    -   OSG has sites that offer queues with job slots having up to 32 cores.
-   Your application requires large amounts of memory:
    -   Most computing sites provide 2 GB/core, however some offer up to 4.5 GB/core, and requests for multi-core queues therefore come with additional memory/job.
    

## Applications Poorly Suited to Distributed HTC

Unfortunately high throughput computing is probably not a good fit for your job if:

-   You need results immediately after submission (i.e. an interactive environment).
    -   Distributed HTC resources are accessed through a batch system and therefore suited for longer processing times, with job durations typically measured in hours. 
-   Your application needs large numbers of cores simultaneously.
    -   OSG does not schedule MPI jobs. 
-   Your application requires a shared filesystem. 
    - There is no shared filesystem across the many computing sites of the OSG. We can help assess if your app has this constraint, and if it can be practically removed.

&nbsp;

As usual, you can direct any questions using the help desk or by sending email 
to [user-support@opensciencegrid.org](mailto:support@opensciencegrid.org).
