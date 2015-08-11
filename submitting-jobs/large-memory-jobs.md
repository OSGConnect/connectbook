[title]: - "Large Memory Jobs"

[TOC]

OSG has limited support for large memory jobs. By default, 2 GB of RAM is assigned to a job. To request more
memory, simply use the HTCondor *request_memory* attribute in your submit file. The unit is MB. For example,
the following will request 12 GB:

    request_memory = 12000

Note that there is only a small number of resources available for large memory jobs, so longer than average
queue times can be expected for these jobs.

