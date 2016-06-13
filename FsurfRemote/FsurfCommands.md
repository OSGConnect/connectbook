[title]: - "Fsurf Command Reference"
[TOC]


## Overview

This page gives an overview of the commands and options that are supported by
the `fsurf` utility .  You can get general help by running `./fsurf --help` and
help on a specific command by running `./fsurf [command] --help`.  E.g. to get
help on the submit command, you can run `./fsurf submit --help`.  

`fsurf` takes a single command (see below) followed by options for the command in
any order.  The commands that `fsurf` accepts are:

| Command | Operation |
| ------- | --------- |
| submit  | Submits MRI scans for processing | 
| list    | Lists current and past workflows |
| status  | Gives the status of a specified workflow | 
| output  | Downloads results or logs for a workflow |
| remove  | Removes an existing workflow | 
| change-password | Changes an user password | 


## Command and Option summary

|     Command     | Function                           | Required Options | Other Options |
|:---------------:|------------------------------------|--------------------------|-----------------------------------------|
| submit          | Upload and process scan            | --subject [subject name] | <ul><li>--help</li> <li>--user</li><li>--dir </li><li>--dualcore</li><li>--defaced</li><li> --deidentified</li></ul> |
| list            | List workflows submitted           | | <ul><li>--help</li> <li>--user</li><li>--all-workflows</li></ul> |
| status          | List status of a given workflow    | --id | <ul><li>--help</li> <li>--user</li></ul>  |
| output          | Get output from completed workflow | --id | <ul><li>--help</li> <li>--user</li>--log-only</li></ul> |
| remove          | Remove specified workflow          | --id |<ul><li>--help</li> <li>--user</li></ul> |
| change-password | Change account password            |  | <ul><li>--help</li> <li>--user</li></ul> |


## Submit Options

**Important note on data privacy**:  In order to protect the privacy of your
participants’ scans, we request that you submit only defaced and fully
deidentified scans for processing by `fsurf`.  Images can be anonymized and
deidentified before they are uploaded to OSG servers as described in [the
article on anonymizing
images](https://support.opensciencegrid.org/support/solutions/articles/12000008493-anonymizing-images).

The submit command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the FSurf service |
| --help | Display help for command |
| --subject | Name of subject to process.  | 
| --dir | Directory containing MRI scans for subject.  `fsurf` expects the input file to be named `subject_defaced.mgz` where `subject` is the subject name given by the `--subject` option. |
| --dualcore | Use 2 cores rather than 8 for per hemisphere processing.  This allow the processing to complete when 8 core systems are not available |
| --defaced | Indicates that the scan is defaced |
| --deidentified | Indicates that the scan is deidentified |

## List Options

The list command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the FSurf service |
| --help | Display help for command |
| --all-workflows | List all workflows submitted rather than the workflows submitted in the last month | 

## Status Options

The status command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the FSurf service |
| --help | Display help for command |
| --id   | ID of workflow to display |

## Output Options

The output command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the FSurf service |
| --help | Display help for command |
| --id   | ID of workflow to display |
| --log-only | Only download log files for workflow  |

## Remove Options

The remove command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the FSurf service |
| --help | Display help for command |
| --id   | ID of workflow to display |


## Change-password Options

The change-password command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the FSurf service |
| --help | Display help for command |

## Getting Help
For assistance or questions, please email the OSG User Support team  at
[user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or
visit the [help desk and community forums](http://support.opensciencegrid.org).


## Validation Information
A list of linux kernels on OSG  on which the FreeSurfer workflows have been
validated can be found
[here](https://support.opensciencegrid.org/support/solutions/articles/12000008494-freesurfer-validation-on-the-osg-).
