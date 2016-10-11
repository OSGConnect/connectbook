[title]: - "What's New in Fsurf 2.0"


## Overview
This document describes the new features in Fsurf 2.0 and 
the differences from the 1.x versions.

## What's New

Fsurf 2.0 adds a few new features:

* [Support for running the recon-all workflow using multiple scans of the same subject](https://support.opensciencegrid.org/support/solutions/articles/12000008490-an-example-of-processing-a-scan#combining-multiple-scans-of-a-subject-for-a-single-reconstruction).  This allows for FreeSurfer to apply correct for errors in the scans due to subject movement. 
* [Support for running the recon-all workflow using a custom set of options](https://support.opensciencegrid.org/support/solutions/articles/12000008490-an-example-of-processing-a-scan#running-recon-all-with-custom-options).  This allows users to run the recon-all workflow step by step using a specific options for each step.
* Better indications of workflow progress and information on completed  workflows.

## Differences from Fsurf 1.x
### Inputs for submission 

Fsurf 2.0 changed how inputs are specified.  When submitting a workflow, the inputs
must be specified using --input-file or --subject-dir .  Previously, Fsurf required 
that the input files have `[subject]_defaced.mri` as their name.  This is no longer
the case but this change means that the input file must be given.

### Output 

Fsurf 2.x and Fsurf 1.x also vary slightly in the output generated.  The only
place where this varies significantly is when displaying information about
workflows.  Fsurf 1.x does not show the number of total tasks and completed tasks
when the `list` command is used.  In addition, Fsurf 1.x only gives the workflow
status when the `status` command is used.  Fsurf 2.x provides a more complete
summary of the workflow status and some details about resources that the
workflow used.

### Workflow status

Fsurf 1.x also used slightly differnt terms to indicate the status of a workflow.
Fsurf 1.x uses `UPLOADED` when a workflow has been created instead of `QUEUED`.
Similarly, Fsurf 1.x uses `PROCESSING` instead of `RUNNING` when a workflow has
been started.

