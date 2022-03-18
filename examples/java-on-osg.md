[title]: - "Using Java in Jobs"

[TOC]

## Overview

If your code uses Java via a `.jar` file, it is easy to bring along your 
own copy of the Java Development Kit (JDK) which allows you to run 
your `.jar` file anywhere on the Open Science Pool. 

## Steps to Use Java in Jobs

1. **Get a copy of Java/JDK.** You can access the the Java Development Kit (JDK) from 
the [JDK website](https://jdk.java.net/). First select the link to the 
JDK that is listed as "Ready for Use" and then download the Linux/x64 
version of the tar.gz file using a Unix command such as `wget` from your `/home` directory. 
For example, 

		$ wget https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_linux-x64_bin.tar.gz

The downloaded file should end up in your 
home directory on the OSG Connect access point. 

2. **Include Java in Input Files.**  Add the downloaded tar file to the `transfer_input_files` line of your
submit file, along with the `.jar` file and any other input files the job needs:

	    transfer_input_files = openjdk-17.0.1_linux-x64_bin.tar.gz, program.jar, other_input

3. **Setup Java inside the job.** Write a script that unpacks the JDK tar file, sets 
the environment to
find the java software, and then runs your program. This script will be
your job\'s executable. See this example for what the script should look
like:

		#!/bin/bash
	
		# unzip the JDK
		tar -xzf openjdk-17.0.1_linux-x64_bin.tar.gz
		# Add the unzipped JDK folder to the environment
		export PATH=$PWD/jdk-17.0.1/bin:$PATH
		export JAVA_HOME=$PWD/jdk-17.0.1
		# set TMPDIR variable
		TMPDIR=$_CONDOR_SCRATCH_DIR
	
		# run your .jar file
		java -jar program.jar

	**Note that the exact name of the unzipped JDK folder and the JDK tar.gz file will 
	vary depending on the version you downloaded.** You should unzip the JDK tar.gz 
	file in your home directory to find out the correct directory name to add to 
	the script. 