[title]: - "Is High Throughput Computing for you?"


## Ideal Charateristics for Distributed High Throughput Computing (HTC)

-   Your science workflow involves computations that can be split into many
    independent jobs
-   Your workflow involves individual jobs be run on a single processor (as opposed to a single
    large-scale MPI job simultaneously utilizing many processors).
-   Your application software is “portable”. (We can help make applications portable and also provide pre-installed software modules)

&nbsp;

## Challenges to Distributed HTC

Your application may present additional challenges, but many of these have solutions on the OSG:

-   Computations that access or produce large datasets. 
-   Your computations need small scale parallelism (8-32 cores):
    -   OSG has sites that will allow your jobs to utilize 8 to 32 cores on a single 
        host at the same time. 
-   Your applications require large amounts of memory:
    -   OSG has resources that can provide jobs with more than 2GB of RAM per (logical) core, however
        these resources can't run many jobs at the same time so jobs will gain access to 
        these resources more slowly than jobs that require less than 2GB of RAM per core.

&nbsp;

## Applications Poorly Suited to Distributed HTC

Unfortunately high throughput computing is probably not a good fit for you if:

-   You need results immediately after submission.
    -   HTC computing is concerned more with processing over longer time scales
        (hours, days, weeks, ...) whereas applications requiring an immediate
        response are not well suited to distributed HTC. 
-   Your application needs large numbers of cores at the simultaneously
    -   OSG does not schedule MPI jobs 
-   Your application requires a shared filesystem. There is no shared filesystem across the OSG.

&nbsp;

As usual, you can direct any questions using the help desk, or just send email
to [user-support@opensciencegrid.org](mailto:support@opensciencegrid.org).
