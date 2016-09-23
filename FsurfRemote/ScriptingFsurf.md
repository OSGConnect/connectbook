
[title]: - "Submitting multiple scans to Fsurf"
[TOC]


## Overview

> Note: this page covers Fsurf rev 0 and Fsurf rev 2, places where the two versions differ
> are indicated through blockquotes like this or using inline text. Fsurf rev 0 is the current 
> production script and rev 2 is currently in beta testing.


This document shows how to process multiple scans with a shell script.  

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

The basic approach is that we'll generate a text file that contains the scan and
subject on each line.  Then we'll use a script that will read this text file to
submit each subject for processing on the OSG. 

### Generating the text file

First, we'll generate a list of subjects.  Assuming, the scans that we'd like to
process are at `~/scans`, run:

    $ for i in `ls ~/scans`; do; readlink -f $i; done > scan_list
    

> Fsurf rev 0: 
> <pre><code>$ ls ~/scans > scan_list</code></pre>

This will generate a file listing each scan on a separate line.  Now edit the
file using a text editor and add the subject for each scan file.  After you're
done, the file should look something like this:

     /home/user/scans/subject_1_defaced.mgz subject_1
     /home/user/scans/MRN_1_defaced.mgz MRN_1
     /home/user/scans/MRN_3_defaced.mgz MRN_3

Each line should have the filename for the scan, a space, and then the name of 
the subject.

### Submission script

Now that we have a file that has information on the scans that should be
submitted, let's write a script that will use that to submit the scans
to `fsurf` for processing.

Open a file called `submit_multiple.sh` in your text editor and cut and paste
the following in it :

     #/bin/bash
     
     for line in `cat $1`;
     do
       input_file=`echo $line | cut -f 1 -d' '`
       subject=`echo $line | cut -f 2 -d' '`
       ./fsurf submit --input $2 --subject $subject --defaced --deidentified
     done
     

> Fsurf rev0:
> <pre><code>
     #/bin/bash
     
     for line in `cat $1`;
     do
       input_file=`echo $line | cut -f 1 -d' '`
       subject=`echo $line | cut -f 2 -d' '`
       ./fsurf submit --dir $2 --subject $subject --defaced --deidentified
     done
     </code></pre>

Now make the script executable and run it:

     $ chmod a+x submit_multiple.sh
     $ ./submit_multiple.sh scan_list ~/scans

The script may take a while to complete if you have a slow connection or if you
have a lot of scans to submit.  If you're submitting many scans, it's best that
you run this on a computer that's connected to the internet using a wired
connection.

## Getting Help
For assistance or questions, please email the OSG User Support team  at
[user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or
visit the [help desk and community forums](http://support.opensciencegrid.org).


## Validation Information
A list of linux kernels on OSG  on which the FreeSurfer workflows have been
validated can be found
[here](https://support.opensciencegrid.org/support/solutions/articles/12000008494-freesurfer-validation-on-the-osg-).
