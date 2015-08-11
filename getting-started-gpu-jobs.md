[title]: - "GPU Jobs"

[TOC]

OSG has limited support for GPU jobs. To request a GPU slot, simply use 
the HTCondor *request_gpus* attribute in your submit file, as well
as *request_cpus* and *request_memory*. Example:


```
request_gpus = 1

request_cpus = 8

request_memory = 16000
```


Currently, a job can only use 1 GPU.

