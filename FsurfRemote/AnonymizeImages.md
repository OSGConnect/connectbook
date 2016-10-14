[title]: - "Anonymizing Scans"
 
In order to protect the privacy of your participants’ scans, we request that you
submit only defaced and fully deidentified scans for processing by `fsurf`. Scans
can be anonymized and deidentified before they are uploaded to OSG servers as
described in this article.

You should use a [local FreeSurfer
installation](http://freesurfer.net/fswiki/DownloadAndInstall) to prepare your
scans. First, on your local machine import your scan into FreeSurfer by running

      $ recon-all -subject SUBJECT -i PATH_TO_MGZ_INPUT_FILE

Here, `recon-all` is the `FreeSurfer` command line tool, the argument `SUBJECT`
is the name of the subject, and the argument `PATH_TO_MGZ_INPUT_FILE` is the
full path to the input file. The above command produces a single compressed
image file `001.mgz` under the directory `subjects/SUBJECT/mri/orig`. Now use 
`mri_deface` to deface the image as follows,

      $ cd  ${FREESURFER_HOME}/average
      $ mri_deface ../subjects/SUBJECT/mri/orig/001.mgz  \
                   talairach_mixed_with_skull.gca  face.gca \
                   ${FREESURFER_HOME}/subjects/SUBJECT/mri/orig/SUBJECT_defaced.mgz

If the `mri_deface` program cannot find the needed `*.gca` files (the standard
FreeSurfer parameter files), fetch and unzip them:

     $ cd ${FREESURFER_HOME}/average
     $ wget "http://stash.osgconnect.net/+fsurf/face.gca"
     $ wget "http://stash.osgconnect.net/+fsurf/talairach_mixed_with_skull.gca"
