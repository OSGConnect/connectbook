[title]: - "Fsurf Command Reference"
[TOC]


## Overview

> Note: this page covers Fsurf version 1.x and Fsurf version 2.x, places where
> the two versions differ are indicated through blockquotes like this or using
> inline text. Fsurf v1.x is the current production version and v2.x is
> currently in beta testing.

This page gives an overview of the commands and options that are supported by
the `fsurf` utility.  You can get general help by running `./fsurf --help` and
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


<br/>

## Command and Option summary

| Command   | Function    | Required Switches | Optional Switches |
| --------- | ----------- | ---------------   | ------------  |
| submit          | Upload and process scan            | --subject [subject name] | <ul><li>--help</li> <li>--user [user name]</li><li>--input-file [path] (Fsurf v2.x)</li><li>--subject-dir [file path] (Fsurf v2.x)</li><li>--options="[options]" (Fsurf v2.x)</li><li>--dir [directory path] <b>(Fsurf v1.x)</b></li><li>--defaced</li><li>--deidentified</li><li>--dualcore</li></ul> |
| list            | List workflows submitted           | | <ul><li>--help</li> <li>--user [user name]</li><li>--all-workflows</li></ul> |
| status          | List status of a given workflow    | --id [workflow id] | <ul><li>--help</li> <li>--user [user name]</li></ul>  |
| output          | Get output from completed workflow | --id [workflow id] | <ul><li>--help</li> <li>--user [user name]</li>--log-only</li></ul> |
| remove          | Remove specified workflow          | --id [workflow id] |<ul><li>--help</li> <li>--user [user name]</li></ul> |
| change-password | Change account password            |  | <ul><li>--help</li> <li>--user [user name]</li></ul> |


<br/>
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
| --user | Username to use when logging into the Fsurf service |
| --help | Display help for command |
| --subject | Name of subject to process.  | 
| --dir | (Fsurf v1.x) Directory containing MRI scans for subject.  `fsurf` expects the input file to be named `subject_defaced.mgz` where `subject` is the subject name given by the `--subject` option. |
| --input-file | (Fsurf v2.x) Path to mgz file containing MRI scans for subject. |
| --subject-dir | (Fsurf v2.x) Path to zip file containing subject directory.  Used in conjunction with --option argument. |
| --option | (Fsurf v2.x) Options to pass to FreeSurfer. Arguments must be in quotes and be specifed as --options="-option1 -option2." Must be used in conjunction with --subject-dir. |
| --dualcore | Use 2 cores rather than 8 for per hemisphere processing.  This allow the processing to complete when 8 core systems are not available |
| --defaced | Indicates that the scan is defaced |
| --deidentified | Indicates that the scan is deidentified |

<br />
## List Options

The list command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the Fsurf service |
| --help | Display help for command |
| --all-workflows | List all workflows submitted rather than the workflows submitted in the last month | 

<br />
## Status Options

The status command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the Fsurf service |
| --help | Display help for command |
| --id   | ID of workflow to display |

<br />
## Output Options

The output command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the Fsurf service |
| --help | Display help for command |
| --id   | ID of workflow to display |
| --log-only | Only download log files for workflow  |

<br />
## Remove Options

The remove command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the Fsurf service |
| --help | Display help for command |
| --id   | ID of workflow to display |

<br />
## Change-password Options

The change-password command accepts the following options:

| Option | Description |
| ------ | ----------- |
| --user | Username to use when logging into the Fsurf service |
| --help | Display help for command |

<br />
