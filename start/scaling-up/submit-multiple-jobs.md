[title]: - "Easily Submit Multiple Jobs"
[TOC]

# Easily Submit Multiple Jobs Using HTCondor

## Overview

HTCondor has several convenient features for streamlining high-throughput 
job submission. This guide provides several examples 
of how to leverage these features to submit multiple jobs with a 
single submit file.

*Why submit multiple jobs with a single submit file?*

[Policies for using an OSG Connect submit server](https://support.opensciencegrid.org/support/solutions/articles/12000074852) 
state that users should submit multiple jobs using a single submit file, or where applicable, as few 
separate submit files as needed. Using HTCondor multi-job submission features is more 
efficient for users and will help ensure reliable operation of the the login nodes.

Many options exist for streamlining your submission of multiple jobs, 
and this guide only covers a few such options of what is truly possible with 
HTCondor. If you are interested in a particular approach that isn't listed here, 
please contact [OSG Connect support](mailto:chtc@cs.wisc.edu) and we will 
work with you to identify options to meet the needs of your work.

## Submit Multiple Jobs Using *queue*

All HTCondor submit files require a `queue` statement (which must also be 
the last line of the submit file). By default, `queue` will submit one job, but 
users can also configure the `queue` statement to behave like a for loop 
that will submit multiple jobs, with each job varying as predefined the user.

Below are the two ways to \"queue\" multiple jobs and, where applicable, 
how to indicate differences between each job with user-defined variables. 
Additional examples and use cases are also provided:

1.  **[`condor_q <N>`**](#process) - will submit *<N>* number of jobs. Examples 
    include performing replications, where the same job must be repeat some number 
    of times, looping through files named with numbers, and looping through 
    a table or matrix where each job uses information from a specific row.
2.  **[`condor_q <var> from (<list>)](#foreach)** - will loop through a 
    list of values, file names, etc. written as a space-delimited list 
    writen directly in the submit file. This `queue` option is very flexible 
    and provides users with many options for submitting multiple jobs.
3.  **[Organizing Jobs Into Individual Directories](#initialdir)** -
    another option that can be helpful in organizing job submissions.

These options are also described in the following video from HTCondor Week 2020: 
* [Submitting Multiple Jobs Using HTCondor](https://www.youtube.com/watch?v=m7dQChJH5LU)

What makes these `queue` options powerful is the ability to use user-defined 
variables to specify details about your jobs in the HTCondor submit file. The 
examples below will include the use of `$(variable_name)` to specify details 
like input file names, file locations (aka paths), etc. **When selecting a 
variable name, user must avoid bespoke HTCondor submit file variables 
such as `Cluster`, `Process`, `output`, and `input`, `arguments`, etc.**

<a name="process"></a>

**1. Use `queue <N>` in you HTCondor submit files**

When using `queue <N>`, HTCondor will submit a total of `<N>` 
jobs, counting from `0` to `<N> - 1` and each job will be assigned 
a unique `Process` id number spanning this range of values. 

More generally, for \"queue *N*\" in the submit file, the \$(Process)
variable will start with \"0\" and end with *N*-1, such that you can use
\$(Process) to indicate unique filenames and filepaths.

The most straightforward example of using `queue <N>` is to submit 
`<N>` number of identical jobs. You can use the below example if you 
wish to assign the HTCondor `error`, `output`, and `log` files unique names 
for each job in the batch:

	# 100jobs.submit
	# submit 100 identifcal jobs

	log = job_$(Cluster)_$(Process).log
	error = job_$(Cluster)_$(Process).err
	output = job_$(Cluster)_$(Process).out

	... remaining submit details ...

	queue 100

For each job, the appropriate number, `0, 1, 2, ... 99` will replace `$(Process)` 
and `$(Cluster)` will be a unique number assigned to the entire 100 job batch. Each 
time you submit a batch of jobs using `condor_submit`, you will be provided 
with the `Cluster` number which you will also see in the output produced by 
the command `condor_q`.

If a uniquely named results file needs to be returned by each job, 
`$(Process)` and `$(Cluster)` can also be used as `arguments`, and anywhere 
else as needed, in the submit file:

	arguments = $(Cluster)_$(Process).results
	queue 100

Be sure to properly format the `arguments` statement according to the 
executable used by the job. (links to more info??)

**What if my jobs are not identical?** `queue <N>` may still be a great 
option! Additional examples for using this option include:

**1. Use integer numbered input files**

	[user@login]$ ls *.data
	0.data   1.data   2.data   3.data
	...      97.data  98.data  99.data

In the submit file, use:

	transfer_input_files = $(Process).data
	queue 100

**2. Specify a row or column number for each job**

$(Process) can be used to specify a unique row or column of information in a 
matrix to be used by each job in the batch. This is especially convenient because 
the same matrix can be transferred with each job as input instead of splitting up 
the matrix into individual files. For exmaple:

	transfer_input_files = matrix.csv
	arguments = $(Process)
	queue 100

The above exmaples assumes that your job is set up to use an argument to 
specify the row or column to be used by your software.

**3. Need ***N*** to start at 1**

If your input files are numbered 1 - 100 instead of 0 - 99, or your matrix 
row starts with 1 instead of 0, you can perform basic arithmetic in the submit 
file:

	plusone = $(Process) + 1
	NewProcess = $INT(plusone, %d)
	queue 100

Then use `$(NewProcess)` anywhere in the submit file that you would
have otherwise used `$(Process)`. Note that there is nothing special about the 
names `plusone` and `NewProcess` - you can use any names you want as variables.

<a name="foreach"></a>

**2. Submit multiple jobs with one or more distinct variables per job**

Think about what's different between each job that you want to submit. 
Will each of your jobs use a distinct input file or set of software parameters? Do 
some of your jobs need more cpus or more disk? Do you want to use a different 
software or script with a set of input files? Using `queue <var> from <list>` 
in your submit files can make that possible! `<var>` can be a single user-defined 
variable or comma-separated list of variables that are defined in a plain text 
file that is specified in `<list>`.

Suppose you need to run a program called `compare_states` that will run on 
on the following set of input files: `illinois.data`, `nebraska.data`, and 
`wisconsin.data` and each input file can analyzed as a separate job.

To create a submit file that will submit that will submit all three jobs, 
first, create a text file that lists each `.data` file (one file per line). 
This step can be performed directly on the login node, for example:

	[user@state-analysis]$ ls *.data > states.txt
	[user@state-analysis]$ cat states.txt
	illinois.data
	nebraska.data
	wisconsin.data
	[user@state-analysis]$ 

Then, in the submit file, following the pattern `queue <var> from <list>`,
replace `<var>` with a variable name like `state` and replace `<list>` 
with the list of `.data` files saved in `states.txt`:

	queue state from states.txt

For each line in `states.txt`, HTCondor will submit a job and the variable 
`$(state)` can be used anywhere in the submit file to represent the name of the `.data` file 
to be used by that job. For the first job, `$(state)` will be `illinois.data`, for the 
second job `$(state)` will be `nebraska.data`, and so on. For example:

	transfer_input_files = $(state)
	arguments = $(state)

**What if more than one variable needs to be different between jobs?**

Let's imagine that each our the state `.data` files contains data for several 
different years and that each job needs to analyze a specific year of data. Then 
the states.txt file can be modified to specify this information:

	[user@state-analysis]$ more states.txt
	illinois.data, 1995
	illinois.data, 2005
	nebraska.data, 1999
	nebraska.data, 2005
	wisconsin.data, 2000
	wisconsin.data, 2015

Then modify the `queue` statement to define two `<var>`:

	queue state,year from states.txt

Then the variables `$(state)` and `$(year)` can be used in the submit file:

	arguments = $(state) $(year)
	transfer_input_files = $(state)

Other Ways of Listing Files
---------------------------

There are two other ways to provide a list, where you would like each
item in the list to create its own job. In the examples below, we are
assuming the same program and files as above.

<a name="matching"></a>

**a. Create jobs \"matching\" a file pattern**

This method of submission creates a job for each file or directory that
matches the pattern provided in your submit file.

``` {.sub}
# Submit File
executable = compare_states
transfer_input_files = $(state),united-states.data
out = $(state).out

queue state matching *.data
```

In this case, we have generated a list by using the pattern `*.data`; a
job will be created for each file that ends with the \"data\" suffix.


<a name="in"></a>

 **b. Create jobs from a list written into the submit file**

In this final example, the list of desired items is written directly
into the submit file using the syntax \"queue \... in ( \... )\"

``` {.sub}
# Submit File
executable = compare_states
transfer_input_files = $(state),united-states.data
out = $(state).out

queue state in (iowa.data 
                missouri.data 
                wisconsin.data)
```

<a name="discussion"></a>

**3. Customizing Multiple Job Submissions**

If your code doesn\'t require unique input files to run multiple jobs,
keep reading to find other ways to provide many jobs with a different
value: either an argument or combination of values.

**3. Dividing Jobs Into Multiple Directories**

One way to organize jobs is to assign each job to its own directory,
instead of putting files in the same directory with unique names. To
continue our \"compare\_states\" example, suppose there\'s a directory
for each state you want to analyze, and each of those directories has
its own input file, like so:

``` 
[alice@submit]$ ls -F
compare_states  iowa/  missouri/  united-states.data  wisconsin/

[alice@submit]$ ls -F wisconsin/
input.data

[alice@submit]$ ls -F missouri/
input.data

[alice@submit]$ ls -F iowa/
input.data
```
{:.term}

We will use two features to submit jobs. First, like we have done for
the previous examples, create a list of the items that are changing for
each job. In this case, it will be each directory.

**`states_list.txt`**

``` 
iowa
missouri
wisconsin
```
{:.file}

There will be a \"queue \... from\" statement to create a job for each
directory in the list. However, we will add another item to the submit
file called \"initialdir\" that will submit each job out of its own
directory:

``` {.sub}
# Submit File
executable = compare_states
initialdir = $(state)
transfer_input_files = input.data, ../united-states.data
out = job.out

queue state from states_list.txt
```

Here, HTCondor will create a job for each state in the list and use that
state\'s directory as the \"initialdir\" - the directory where the job
will actually be submitted. Therefore, in `transfer_input_files`, we can
use `input.data` without using the directory name in the path, and to
use the `united-states.data` file, we need to indicate it is in the
directory above the state directory. The output file will also go into
the state directory.

After the job runs, the job directories would look like this:

``` 
[alice@submit]$ ls -F
compare_states  iowa/  missouri/  united-states.data  wisconsin/

[alice@submit]$ ls -F wisconsin/
input.data  job.out

[alice@submit]$ ls -F missouri/
input.data  job.out

[alice@submit]$ ls -F iowa/
input.data  job.out
```
{:.term}



3.  **[Variations Beyond Input Files](#discussion)**  
    A.  **[Varying arguments](#args)** - assumes that each job needs a
        different set of input arguments  
    B.  **[Supplying multiple variables per job](#multiple-args)** -
        assumes that multiple items (input files, arguments,
        directories) are changing for each job
