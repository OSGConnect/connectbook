Large Memory Jobs 
====================================

[TOC]

By default, 2 GB of RAM (aka memory) will be assigned to your jobs. However, some jobs will require 
additional memory to complete successfully. To request more memory, use the HTCondor *request_memory* 
attribute in your submit file. The default unit is MB. For example, the following will request 12 GB:

    request_memory = 12228

You might be wondering why the above is requesting 12228 MB for 12 GB. That's because byte units don't 
actually scale by 1000 (10^10) like the metric system, but instead scale by 1024 (2^10) due to the binary 
nature of bytes.

Alternatively, you can define a memory request using standard units

	request_memory = 12GB

We recommend always explictly defining the byte units in your *request_memory* statement.

Please note that the OSG has limited resources available for large memory jobs. Requesting jobs with 
higher memory needs will results in longer than average queue times for these jobs.

