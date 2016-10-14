[title]: - "What's New in Fsurf 2.0"


## Overview
This document describes the new features in Fsurf 2.0 and 
the differences from the 1.x versions.

## What's New

Fsurf 2.0 adds a few new features:

* [Support for running the recon-all workflow using multiple scans of the same subject](https://support.opensciencegrid.org/support/solutions/articles/12000008490-an-example-of-processing-a-scan#combining-multiple-scans-of-a-subject-for-a-single-reconstruction).  This allows FreeSurfer to correct errors in the scans due to subject movement. 
* [Support for running the recon-all workflow using a custom set of options](https://support.opensciencegrid.org/support/solutions/articles/12000008490-an-example-of-processing-a-scan#running-recon-all-with-custom-options).  This allows users to run the recon-all workflow step by step using a specific options for each step.
* Better indications of workflow progress and information on completed  workflows.

## Differences from Fsurf 1.x
### Inputs for submission 

Fsurf 2.0 changed how inputs are specified.  When submitting a workflow, the inputs
must be specified using `--input-file` or `--subject-dir`.  Previously, Fsurf required 
that the input files have `[subject]_defaced.mri` as their name.  This is no longer
the case. 

### Output 

Fsurf 2.x and Fsurf 1.x also vary slightly in how workflow information is 
displayed. Fsurf 2.x now shows the workflow progress when listing workflows.  
Also when displaying information about a particular workflow (using the `status` 
command), Fsurf 2.x now gives information about workflow type, the parameters
used for that workflow, and resources used by that workflow.

### Workflow status

Fsurf 2.x also chnages a few of the terms to indicate the status of a workflow.
It uses `QUEUED` instead of `UPLOADED` when a workflow has been submitted. 
Likewise, it uses `RUNNING` instead of `PROCESSING` to indicate a workflow that
is currently being run.
