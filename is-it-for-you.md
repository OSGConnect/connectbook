[title]: - "Is High Throughput Computing for you?"


## Ideal Charateristics for Distributed High Throughput Computing (HTC)

-   Your science workflow involves computations that can be split into many
    independent jobs
-   Your workflow involves individual jobs be run on a single processor (as opposed to a single
    large-scale MPI job simultaneously utilizing many processors).
-   Your application software is “portable”. (We can help make applications portable and also provide pre-installed software modules)



## Challenges to Distributed HTC

Your application may present additional challenges, but many of these have solutions on the OSG:

-   Computations that access or produce large datasets. 
-   Your computations need small scale parallelism (8-32 cores):
    -   OSG has sites that will allow your jobs to utilize 8 to 32 cores on a single 
        host at the same time. 
-   Your application requires large amounts of memory:
    -   Most computing sites provide 2 GB/core, however some offer up to 4.5 GB/core, and requests for multi-core job slots come with additional memory.
    

## Applications Poorly Suited to Distributed HTC

Unfortunately high throughput computing is probably not a good fit for you if:

-   You need results immediately after submission (i.e. an interactive environment).
    -   Distributed HTC resources are accessed through a batch system and therefore suited for longer processing times, with job durations typically measured in hours. 
-   Your application needs large numbers of cores simultaneously.
    -   OSG does not schedule MPI jobs. 
-   Your application requires a shared filesystem. 
    - There is no shared filesystem across the many computing sites of the OSG. We can help assess if your app has this constraint, and if it can be practically removed.

&nbsp;

As usual, you can direct any questions using the help desk or by sending email 
to [user-support@opensciencegrid.org](mailto:support@opensciencegrid.org).
