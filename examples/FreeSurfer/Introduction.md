[title]: - "Introduction to FreeSurfer on the OSPool"
[TOC]

## Overview

[FreeSurfer](http://freesurfer.net/) is a software package to analyze MRI scans
of human brains. The OSG Connect service used to support a tool called
Fsurf, which has been discontinued for security reasons. Today, we support the official 
FreeSurfer container image and workflow. Please see:

* [https://github.com/pegasus-isi/freesurfer-osg-workflow](https://github.com/pegasus-isi/freesurfer-osg-workflow) - scroll down to see the documentation on this page.
* Container image: `/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-freesurfer:latest` and defined at [https://github.com/opensciencegrid/osgvo-freesurfer](https://github.com/opensciencegrid/osgvo-freesurfer)

## Prerequisites

To use the FreeSurfer Pegasus workflow on the OSPool, you need:

* Your own FreeSurfer license file (see: [https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall#License](https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall#License))
* A regular OSG Connect account.

## Privacy and Confidentiality of Subjects

In order to protect the privacy of your participants’ scans, users should only run
only defaced and fully deidentified scans for processing. The OSG Connect service has no support for HIPPA or other 'private' data requirements.

## Getting Help

For assistance or questions, please email the OSG Research Facilitation team  at
[support@opensciencegrid.org](mailto:support@opensciencegrid.org) or
visit the [help desk and community forums](http://support.opensciencegrid.org).
