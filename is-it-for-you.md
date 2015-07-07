[title]: - "Is high throughput computing for you?"

Consider the following to determine with high throughput computing (HTC) is
appropriate for your computing problem, and therefore a candidate to consume
cycles from the OSG.  High throughput computing is an excellent fit for you if:

-   Your science workflow involves computations that can be split into many
    independent jobs
-   Your workflow involves individual jobs be run on a single processor (as opposed to a single
    large-scale MPI job simultaneously utilizing many processors).
-   Your applications can be interrupted and restarted at a later time or on
    another processor or computing site?
    -   If not, your application might still be able to be adapted to run as under a HTC model
-   Your application software is “portable”?
    -   Not sure what this means? Contact us.  

High throughput computing may still be a good fit for you if:
-   Your computations require access to or produce huge amounts of data
    -   In the OSG we have plenty of experience with very large (even extreme
        scale) data sets.
-   Your computations need small scale parallelism (8-32 cores):
    -   OSG has some sites that will allow your jobs to utilize 8 to 32 cores on a single 
        host at the same time.  However, gaining access to these resources is slower than 
        gaining access to single core job slots.
-   Your applications require large amounts of memory
    -   OSG has a few resources that can provide jobs with more than 2GB of RAM, however
        these resources can't run many jobs at the same time so jobs will gain access to 
        these resources more slowly than jobs that require less than 2GB of RAM.

Unfortunately high throughput computing is probably not a good fit for you if:
-   You need results immediately after submission.
    -   HTC computing is concerned more with processing over longer time scales
        (hours, days, weeks, ...) whereas applications requiring an immediate
        response are not well suited to HTC. 
-   Your application needs large number of cores at the same time
    -   OSG doesn't provide resources that are appropriate for MPI type jobs.  



As usual, you can direct any questions using the help desk, or just send email
to [user-support@opensciencegrid.org](mailto:support@opensciencegrid.org).
