
[title]: - "Processing Multiple Subjects Using Fsurf"
[TOC]


## Overview

This document shows how to process multiple subjects quickly using a shell script.  

**Important note on data privacy**:  In order to protect the privacy of your
participants’ scans, we request that you submit only defaced and fully
deidentified scans for processing by `fsurf`.  Images can be anonymized and
deidentified before they are uploaded to OSG servers as described in [the
article on anonymizing
images](https://support.opensciencegrid.org/support/solutions/articles/12000008493-anonymizing-images).


## Preparing to submit scans

There are a few things that will be needed before you can start:

* Terminal access on a computer with the following:
  * Bash installed
  * Wired internet access (preferable) or very fast wireless access 
* A directory with anonymized and defaced MRI brain scans 
* Knowledge of using a text editor within a terminal (e.g. vi, nano, emacs, etc.)

## Running `fsurf` non-interactively

By default, `fsurf` asks if an image has defaced and anonymized when it is
submitted for processing.  However, if `fsurf` is given `--defaced` and
`--deidentified` as options, these prompts will not appear.

## Scripting `fsurf` submissions

The basic approach we will take is to first generate a text file with scan and
subject information.  Then we'll use a script that will read this text file to
submit each subject for processing on the OSG. 

### Generating the text file

First, we'll generate a list of subjects.  Assuming, the scans that we'd like to
process are at `~/scans`, run:

    $ for i in `ls ~/scans`; do; python -c 'import os,sys;print(os.path.realpath(sys.argv[1]))' $i; done > scan_list
    
This will generate a file with each scan on a separate line.  Now edit the
file using a text editor and add the subject for each scan file.  After you're
done, the file should look something like this:

     /home/user/scans/subject_1_defaced.mgz subject_1
     /home/user/scans/MRN_1_defaced.mgz MRN_1
     /home/user/scans/MRN_3_defaced.mgz MRN_3

Each line should have the filename for the scan, a space, and then the name of 
the subject.

### Submission script

Now that we have a file that has information on the scans that should be
submitted, let's write a script that will use that to call `fsurf` with the
proper options.

Open a file called `submit_multiple.sh` in your text editor and cut and paste
the following in it :

     #/bin/bash
     
     for line in `cat $1`;
     do
       input_file=`echo $line | cut -f 1 -d' '`
       subject=`echo $line | cut -f 2 -d' '`
       ./fsurf submit --input=$2 --subject=$subject --defaced --deidentified
     done
     
Now make the script executable and run it:

     $ chmod a+x submit_multiple.sh
     $ ./submit_multiple.sh scan_list ~/scans

The script may take a while to complete if you have a slow connection or if you
are processing a lot of scans.  If you're processing many scans, it's best that
you run this on a computer that's connected to the internet using a wired
connection.
