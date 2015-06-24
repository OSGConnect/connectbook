[title]: - "Is high throughput computing for you?"

Consider the following to determine with high throughput computing (HTC) is
appropriate for your computing problem, and therefore a candidate to consume
cycles from the OSG:

-   Does your science workflow involve computations that can be split into many
    independent jobs?

    -   If yes, HTC is a good fit.

-   Can individual jobs be run on a single processor (as opposed to a single
    large-scale MPI job simultaneously utilizing many processors)?

    -   If yes, HTC is a good fit.

-   Can your applications be interrupted and restarted at a later time or on
    another processor or computing site?

    -   If yes, HTC is definitely a good fit.  If not, your application still
        might be adapted.  

-   Is your application software “portable”?

    -   If yes, HTC is a good fit.  Not sure what this means? Contact us.  

-   How does computing fit into your science workflow? Are results needed
    immediately after submission?

    -   HTC computing is concerned more with processing over longer time scales
        (hours, days, weeks, ...) whereas applications requiring an immediate
        response are not well suited to HTC. 

-   Do your computations require access to or produce huge amounts of data?

    -   In the OSG we have plenty of experience with very large (even extreme
        scale) data sets. 

As usual, you can direct any questions using the help desk, or just send email
to [user-support@opensciencegrid.org](mailto:support@opensciencegrid.org).
