[title]: - "Blast Similarity Search with Pegasus"
[TOC]

# Blast Search on a large database with Pegasus 

## Overview
Blast search against a large sequence data base is a challenging task. Because a large database requires large memory on a 
computing machine and the size of the sequence database grows every year. In this example, we split the reference database and 
peform the blast search. The current workflow is handled with Pegasus Workflow Manager. 

## tutorial files

In the command prompt, type

    $ tutorial                  # Without an argument, it shows the list of available tutorials.
    $ tutorial pegasus-blast    # The files to run the pegasus-blast tutorial are created under the directory tutorial-pegasus-blast
    $ cd tutorial-pegasus-blast  # Change to this directory

Let's take a look at the files inside the directory
`tutorial-pegasus-vina`.  The following are two input sequence files (just one is enough to run our demo).

    BRAC1.txt                  # Input sequence (example 1)
    HLA.txt                    # Input sequence (example 2, small sequeunce)

The following files are related to Pegasus workflow management:

    dax-generator-blast.py     # python script that generates dax.xml
    pegasusrc                  # pegasus config file
    sites-generator.bash       # bash script generates sites.xml file
    submit.bash                # Job submit script

The file `pegasusrc` contains the Pegasus configuration information. We
can simply keep this file in the current working directory without
worrying much about the details (if you would like to know the details,
please visit the Pegasus home page). The files `dax.xml` and `sites.xml`
contain the information about the work flow and data management.

The following is the blast executable file

    blast_exe.bash             # blast executable file

## Sequence Database

The sequence data base is around 15 GB which requires approximatly same amount of memory to process the files. Therefore we split the input database into smaller chunks. The chunks are stored in stash public storage. To see them 

    $ ls /stash/public/blast/database/nt.5-30-2014/*.gz

there are 19 files. This means a given input sequence is matched against these 19 chunks that results in 19 independent jobs. This orkflow is implemented with Pegasus. 

## Submit script

Let's review to few parts of the `submit.bash` script to understand
how the workflow is submitted.  Open the file `submit.bash` and take a
look:

	...
	line 9 ./dax-generator-blast.py ### Execution of "dax-generator-blast.py" script. Generates dax.xml.
	...
	line 14 ./sites-generator.bash   ### Execution of "sites-generator.bash" script. Generates sites.xml.
	...
	line 17 pegasus-plan \               ###  Executes the pegasus-plan with the following arguments
	line 18    --conf pegasusrc \             ###   pegasus configuration file
	line 19    --sites condorpool \           ###   jobs are executed in condorpool
	line 20    --dir $PWD/workflows \         ###   The path of the workflow directory
	line 21    --output-site local \          ###   Outputs are directed to the local site.
	line 22    --cluster horizontal \         ###   Cluster the jobs horizontally
	line 23    --dax dax.xml \                ###   Name of the dax file
	line 24    --submit                       ###   Type of action is submit


## sites-generator  

The purpose of `sites-generator.bash` script is to generate
the `sites.xml` file. There are several lines declared in the
`sites-generator.bash` script. We need to understand the lines defining
the scratch and output directories.

	...
	line 4 cat >sites.xml <<EOF  ### creates the file "sites.xml" and appends the following lines.
	...
	line 11 <file-server protocol="file" url="file://" mount-point="$PWD/scratch"/>   ###  Define the path of scratch directory
	line 12 <internal-mount-point mount-point="$PWD/scratch"/>                        ###  Define the path of scratch directory
	...
	line 17 <file-server protocol="file" url="file://" mount-point="$PWD/outputs"/>   ### Define the path of output directory
	line 18 <internal-mount-point mount-point="$PWD/outputs"/>                        ### Define the path of output directory
	...
	line 32 EOF   ### End of sites.xml file

The files `submit.bash` and `sites-generator.bash` will not change very
much for a new workflow.  We need to edit these two files, when we
change the name of the dax-generator and/or the path of outputs, scratch
and workflows.


## DAX generator 

The file `dax.xml` contains the workflow information, including the
description about the jobs and required input files. We could manually
write the dax.xml file but it is not very pleasant for the human eye
to deal with the xml format. Here, dax.xml is generated via the python
script `dax-generator-blast.py`.  Take a look at the python script,
it is self explanatory with lots of comments.  If you have difficulty to
understand the script, please feel free to send us an email. Here is the
brief description about dax-generator python script.

	...
    line 8 query_filename = "HLA.txt"                                  # Name of the input querry sequence file
    line 9 database_dir = "/stash/public/blast/database/nt.5-30-2014"  # Location of database chucks


For example, if you would like to match "BRAC1.txt" change `querry_filename` as follows

    line 8 query_filename = "BRAC1.txt"                                 # Provide name of the input querry sequence file


### To submit the job

To submit the job, run:

	$ ./submit

To check the status of the submitted job:

	$ pegasus-status

You can also check with the `condor_q` command.

	$ condor_q username   ###   username is your login ID

Pegasus creates the following directories:

    scratch/   ### Contains all the files (including input, parameter and execution) required to run the job are copied in this directory.
    workflows/   ###  Contains the workflow files including DAGMan, data transfer scripts and condor job files.
    outputs/   ###  Where the NAMD output files are stored at the end of each job.


## Key points

 - Pegasus requires `dax.xml`, `sites.xml` and `pegasusrc` files. These files
   contain the information about executable, input and output files and
   the relation between them while executing the jobs.
 - It is convenient to generate the XML files via scripts. In our
   example, `dax.xml` is generated via a Python script and `sites.xml` is
   generated via a bash script.
 - To implement a new workflow, edit the existing dax-generator,
   sites-generator and  submit scripts.  


## Getting Help
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).
