[title]: - "GPU Jobs"

[TOC]

OSG has limited support for GPU jobs. To request a GPU slot, simply use 
the HTCondor *request_gpus* attribute in your submit file:

```
request_gpus = 1
```

Currently, a job can only use 1 GPU.

