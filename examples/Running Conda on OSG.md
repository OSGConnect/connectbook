[title]: - "Running Conda on OSG"

[TOC]

The Anaconda/Miniconda distribution of Python is a common tool for installing and managing Python-based software and other tools. 

# Overview
When should you use Miniconda as an installation method in OSG?
* Your software has specific conda-centric installation instructions.
* The above is true and the software has a lot of dependencies.
* You mainly use Python to do your work.

Notes on terminology:

* **conda** is a Python package manager and package ecosystem that exists in parallel with **pip** and [PyPI](https://pypi.org/).
* **Miniconda** is a slim Python distribution, containing the minimum amount of packages necessary for a Python installation that can use conda.
* **Anaconda** is a pre-built scientific Python distribution based on Miniconda that has many useful scientific packages pre-installed.

To create the smallest, most portable Python installation possible, we recommend starting with Miniconda and installing only the packages you actually require.

There are two ways to create a Miniconda installation on OSG. The first is to create your installation environment on the submit server and send a zipped version to your jobs. The other option is to install Miniconda inside each job. The first option is more efficient, especially for complex installations, but there may be rare situations where installing with each job is better. We recommend trying the pre-installation option first. If it doesn’t work, discuss the second option with a facilitator.

* Recommended: [Option 1: Pre-Install Miniconda and Transfer to Jobs](#option-1-pre-install-miniconda-and-transfer-to-jobs)
* Alternative: [Option 2: Install Miniconda Inside Each Job](#option-2-install-miniconda-inside-each-job)
This guide also discusses how to [“pin” your conda environment](#specifying-exact-dependency-versions) to create a more consistent and reproducible environment with specified versions of packages.

# OPTION 1: PRE-INSTALL MINICONDA AND TRANSFER TO JOBS
In this approach, we will create an entire software installation inside Miniconda and then use a tool called **conda pack** to package it up for running jobs.

## 1. CREATE A MINICONDA INSTALLATION
On the submit server, download the latest Linux [miniconda installer](https://docs.conda.io/en/latest/miniconda.html) and run it.

      [alice@login05]$ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
      [alice@login05]$ sh Miniconda3-latest-Linux-x86_64.sh
      
Accept the license agreement and default options. At the end, you can choose whether or not to “initialize Miniconda3 by running conda init?” The default is no; you would then run the **eval** command listed by the installer to “activate” Miniconda. If you choose “no” you’ll want to save this command so that you can reactivate the Miniconda installation when needed in the future.

## 2. CREATE A CONDA “ENVIRONMENT” WITH YOUR SOFTWARE
(If you are using an **environment.yml** file as described [later](#specifying-exact-dependency-versions), you should instead create the environment from your **environment.yml** file. If you don’t have an **environment.yml** file to work with, follow the install instructions in this section. We recommend switching to the **environment.yml** method of creating environments once you understand the “manual” method presented here.)

Make sure that you’ve activated the base Miniconda environment if you haven’t already. Your prompt should look like this:

      (base)[alice@login05]$ 
To create an environment, use the **conda create** command and then activate the environment:

      (base)[alice@login05]$ conda create -n env-name
      (base)[alice@login05]$ conda activate env-name
Then, run the **conda install** command to install the different packages and software you want to include in the installation. How this should look is often listed in the installation examples for software (e.g. [Qiime2](https://docs.qiime2.org/2020.2/install/native/#install-qiime-2-within-a-conda-environment), [Pytorch](https://pytorch.org/get-started/locally/)).

      (env-name)[alice@login05]$ conda install pkg1 pkg2
Some Conda packages are only available via specific Conda channels which serve as repositories for hosting and managing packages. If Conda is unable to locate the requested packages using the example above, you may need to have Conda search other channels. More detail are available at [https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/channels.html.](https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/channels.html)

Packages may also be installed via **pip**, but you should only do this when there is no **conda** package available.

Once everything is installed, deactivate the environment to go back to the Miniconda “base” environment.

      (env-name)[alice@login05]$ conda deactivate
For example, if you wanted to create an installation with **pandas** and **matplotlib** and call the environment **py-data-sci**, you would use this sequence of commands:

      (base)[alice@login05]$ conda create -n py-data-sci
      (base)[alice@login05]$ conda activate py-data-sci
      (py-data-sci)[alice@login05]$ conda install pandas matplotlib
      (py-data-sci)[alice@login05]$ conda deactivate
      (base)[alice@login05]$ 
MORE ABOUT MINICONDA
See the [official conda documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) for more information on creating and managing environments with **conda**.

## 3. CREATE SOFTWARE PACKAGE
Make sure that your job’s Miniconda environment is created, but deactivated, so that you’re in the “base” Miniconda environment:

      (base)[alice@login05]$ 
Then, run this command to install the **conda pack** tool:

      (base)[alice@login05]$ conda install -c conda-forge conda-pack
Enter **y** when it asks you to install.

Finally, use **conda pack** to create a zipped tar.gz file of your environment (substitute the name of your conda environment where you see **env-name**), set the proper permissions for this file using **chmod**, and check the size of the final tarball:

      (base)[alice@login05]$ conda pack -n env-name
      (base)[alice@login05]$ chmod 644 env-name.tar.gz
      (base)[alice@login05]$ ls -sh env-name.tar.gz
When this step finishes, you should see a file in your current directory named **env-name.tar.gz**

## 4. CHECK SIZE OF CONDA ENVIRONMENT TAR ARCHIVE
The tar archive, **env-name.tar.gz**, created in the previous step will be used as input for subsequent job submission. As with all job input files, you should check the size of this Conda environment file. **If >100MB in size, you should NOT transfer the tar ball using transfer_input_files**. Instead, you should plan to use either OSG’s web proxy, SQUID or large data filesystem Staging. Please contact a research computing facilitators at support@opensciencegrid.org to determine the best option for your jobs.

More information is available at [File Availability with Squid Web Proxy](https://support.opensciencegrid.org/support/solutions/articles/5000633467-steer-your-jobs-with-htcondor-job-requirements) and [Managing Large Data in HTC Jobs](https://support.opensciencegrid.org/support/solutions/articles/12000002985-overview-data-staging-and-transfer-to-jobs).

## 5. CREATE A JOB EXECUTABLE
The job will need to go through a few steps to use this “packed” conda environment; first, setting the **PATH**, then unzipping the environment, then activating it, and finally running whatever program you like. The script below is an example of what is needed (customize as indicated to match your choices above).

      #!/bin/bash

      # have job exit if any command returns with non-zero exit status (aka failure)
      set -e

      # replace env-name on the right hand side of this line with the name of your conda environment
      ENVNAME=env-name

      # if you need the environment directory to be named something other than the environment name, change this line
      ENVDIR=$ENVNAME

      # these lines handle setting up the environment; you shouldn't have to modify them
      export PATH
      mkdir $ENVDIR
      tar -xzf $ENVNAME.tar.gz -C $ENVDIR
      . $ENVDIR/bin/activate

      # modify this line to run your desired Python script and any other work you need to do
      python3 hello.py
## 6. SUBMIT JOBS
In your submit file, make sure to have the following:

* Your executable should be the the bash script you created in [step 5](#5-create-a-job-executable).
* Remember to transfer your Python script and the environment **tar.gz** file via **transfer_input_files**. Since the **tar.gz** file will almost certainly be larger than 100MB, please email us about different tools for delivering the installation to your jobs, likely our SQUID web proxy.
# OPTION 2: INSTALL MINICONDA INSIDE EACH JOB
In this approach, rather than copying the Miniconda installation with each job, we will copy the Miniconda installer and install a new copy of Miniconda with each job.

Do not use this installation method unless directed to do by a facilitator!

## 1. DOWNLOAD THE MINICONDA INSTALLER AND TEST INSTALLATION
If you haven’t already, download the latest Miniconda installer for Linux from the [Miniconda website](https://docs.conda.io/en/latest/miniconda.html#linux-installers) and place it in your home directory.

We strongly recommend testing the installation steps for your particular program or packages - either on your own computer or similar to the [directions above](#1-create-a-miniconda-installation) - before trying to submit the installation as part of a job to OSG.

## 2. CREATE AN EXECUTABLE SCRIPT
Our plan here is to run the Miniconda installer inside the job, build an environment with needed packages, and then run our desired script or program. The following script should work verbatim except for changing the **conda install** step to the packages you need or the instructions for your program. See [below](#specifying-exact-dependency-versions) for instructions on using an **environment.yml** environment specification instead of “manually” listing packages in your job script.

      #!/bin/bash

      set -e

      #installation steps for Miniconda
      export HOME=$PWD
      export PATH
      sh [installer] -b -p $PWD/miniconda3
      export PATH=$PWD/miniconda3/bin:$PATH

      # install packages
      conda install numpy matplotlib

      # modify this line to run your desired Python script
      python3 hello.py
      
## 3. SUBMIT FILE
In your submit file, include the executable you wrote (as described above) and in **transfer_input_files** include the Miniconda installer and any other scripts or data files you want to include with the job:

      executable = run_with_conda.sh
      arguments = myscript.py

      transfer_input_files = Miniconda3-latest-Linux-x86_64.sh, script.py, other_input.file
      
# SPECIFYING EXACT DEPENDENCY VERSIONS
An important part of improving reproducibility and consistency between runs is to ensure that you use the correct/expected versions of your dependencies.

When you run a command like **conda install numpy**, **conda** tries to install the most recent version of **numpy**. For example, **numpy** version **1.22.3** was released on Mar 7, 2022. To install exactly this version of numpy, you would run **conda install numpy=1.22.3** (the same works for **pip**, if you replace **=** with **==**). We recommend installing with an explicit version to make sure you have exactly the version of a package that you want. This is often called “pinning” or “locking” the version of the package.

If you want a record of what is installed in your environment, or want to reproduce your environment on another computer, conda can create a file, usually called **environment.yml**, that describes the exact versions of all of the packages you have installed in an environment. This file can be re-used by a different conda command to recreate that exact environment on another computer.

To create an **environment.yml** file from your currently-activated environment, run

      [alice@login05]$ conda env export > environment.yml
This **environment.yml** will pin the exact version of every dependency in your environment. This can sometimes be problematic if you are moving between platforms because a package version may not be available on some other platform, causing an “unsatisfiable dependency” or “inconsistent environment” error. A much less strict pinning is

      [alice@login05]$ conda env export --from-history > environment.yml
which only lists packages that you installed manually, and **does not pin their versions unless you yourself pinned them during installation**. If you need an intermediate solution, it is also possible to manually edit **environment.yml** files; see the [conda environment documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#) for more details about the format and what is possible. In general, exact environment specifications are simply not guaranteed to be transferable between platforms (e.g., between Windows and Linux). **We strongly recommend using the strictest possible pinning available to you**.

To create an environment from an **environment.yml** file, run

      [alice@login05]$ conda env create -f environment.yml
By default, the name of the environment will be whatever the name of the source environment was; you can change the name by adding a **-n \<name>** option to the **conda env create** command.

If you use a source control system like **git**, we recommend checking your **environment.yml** file into source control and making sure to recreate it when you make changes to your environment. Putting your environment under source control gives you a way to track how it changes along with your own code.

If you are developing software on your local computer for eventual use on the Open Science pool, your workflow might look like this:

1. Set up a conda environment for local development and install packages as desired (e.g., **conda create -n science; conda activate science; conda install numpy**).
2. Once you are ready to run on the Open Science pool, create an **environment.yml** file from your local environment (e.g., **conda env export > environment.yml**).
3. Move your **environment.yml** file from your local computer to the submit machine and create an environment from it (e.g., **conda env create -f environment.yml**), then pack it for use in your jobs, as per [Create Software Package](#3-create-software-package).
More information on conda environments can be found in [their documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#).

