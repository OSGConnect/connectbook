[title]: - "Introduction to Fsurf and FreeSurfer"



## Overview

[FreeSurfer](http://freesurfer.net/) is a software package to analyze MRI scans of human brains. The Open Science Grid (OSG) has developed a command line utility, Fsurf, that simplifies running a FreeSurfer 5.3 workflow on the OSG.  

## Prerequisites
In order to use the fsurf utility, you'll need a few things:

* A computer with Freesurfer installed (for anonymizing scans)
* A computer with python 2.6+ (this can be the same as the computer above) - Most linux/unix systems released in the last several years already support this and Mac OS X versions released after 2012 also provide this
* A ethernet or fast wireless connection if you are processing multiple scans at once

## Privacy and confidentiality
In order to protect the privacy of your participants’ scans, we request that you submit only defaced and fully deidentified scans for processing by fsurf. Images can be anonymized and deidentified before they are uploaded to OSG servers as described in the article on [anonymizing images](https://support.opensciencegrid.org/solution/articles/12000008493-anonymizing-images).

## Using Fsurf

To use Fsurf, you need an account. Follow the instructions outlined [here to obtain an account](https://support.opensciencegrid.org/support/solutions/articles/12000008487-request-a-fsurf-account-).

These pages describe the process for:

* [Obtaining an Fsurf account](https://support.opensciencegrid.org/support/solutions/articles/12000008487-request-a-fsurf-account-)
* [Setting up Fsurf](https://support.opensciencegrid.org/support/solutions/articles/12000008488-set-up-fsurf-on-your-laptop)
* [Analyzing images](https://support.opensciencegrid.org/support/solutions/articles/12000008490-anlysis-of-a-brain-mri-scan)
* [Transferring output back to your computer](https://support.opensciencegrid.org/support/solutions/articles/12000008491-managing-your-output-files)
* [Anonymizing images](https://support.opensciencegrid.org/solution/articles/12000008493-anonymizing-images)

Fsurf is easy to install and use from any computer. All it requires is a machine with a network connection and Python installed.  It takes only a few minutes to set up and run an image analysis job on the OSG.  

<img src="https://raw.githubusercontent.com/OSGConnect/connectbook/master/FsurfRemote/Figs/FsurfTool.png" width="450px" height="300px" />

## What's Next?
If you don't have an Fsurf account, 
[get an account](https://support.opensciencegrid.org/solution/articles/12000008487-requesting-an-fsurf-account). 
Otherwise, [set up Fsurf](https://support.opensciencegrid.org/solution/articles/12000008488-set-up-fsurf-on-your-laptop). 

## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).

## Validation Information
A list of linux kernels on OSG  on which the Freesurfer workflows have been validated can be found [here](https://support.opensciencegrid.org/support/solutions/articles/12000008494-freesurfer-validation-on-the-osg-)


