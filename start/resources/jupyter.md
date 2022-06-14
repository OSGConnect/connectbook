[title]: - "Launching a JupyterLab Instance"

[TOC]


*Note: Using JupyterLab is a new feature available only to users of accesspoint7.ospool.osg-htc.org. We appreciate any feedback sent to support@opensciencegrid.org.*


# Objective

This guide describes how to request an account to access JupyterLab, launch a JupyterLab instance, and how to send jobs from JupyterLab to an execution point dedicated to your JupyterLab instance. 


# What is JupyterLab?

JupyterLab is a web-based interface for [Project Jupyter](https://jupyter.org). It is an interactive environment that supports a variety of computational activities and workflows through features such as notebooks, terminals, text editors, etc.

More information about the JupyterLab interface can be found in the [JupyterLab manual](https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html). 

JupyterLab can be a helpful resource for teaching and for running small batches of HTCondor jobs for testing and/or troubleshooting purposes. JupyterLab jobs also have the option of running post-processing or other analyses on the access point, as opposed to needing to run these steps on an execution point via an HTCondor job.  


# Steps to Accessing and Working in JupyterLab

The steps necessary for working in JupyterLab are: 

- Request an account to access JupyterLab
- Meet with a Research Computing Facilitator for a short introduction to working with JupyterLab and to activate your account.
- Launch a JupyterLab instance.


# Request Access to a JupyterLab Access Point

## Request an Account 

To request access to JupyterLab, submit an application using the following steps:

(1) Go to the [registration website](https://registry.cilogon.org/registry/co_petitions/start/coef:261). You will be redirected to the CILogon sign in page. Select your institution and use your institutional credentials to login. 

If you have issues signing in using your institutional credentials, contact us at support@opensciencegrid.org.

(2) Once you sign in, you will be redirected to the "JupyterLab User Enrollment for New Users" page. Click "Begin" and enter your name and email address on the following page. In many cases, this information will be automatically populated. If desired, it is possible to manually edit any information automatically filled in. Once you have entered your information, click "SUBMIT". 

(3) After submitting your application, you will receive an email from registry@cilogon.org to verify your email address. Click the link listed in the email to be redirected to a page confirm your invitation details. Click the "ACCEPT" button to complete this step. 


## Meet with a Research Computing Facilitator

Once OSG staff receive your email verification, a Research Computing Facilitator will contact you within one business day to arrange a short consultation and introduction to the JupterLab resources. During this meeting, our staff will provide personalized start-up guidance per your specific computational research goals and activate your account.

Following the meeting, the Facilitator will approve your account, add your profile to any relevant JupyterLab ‘project’ names, and ensure that you have access to the JupyterLab. (You will receive automated emails for some of these actions, which you can otherwise ignore.)


# How to launch a JupyterLab Instance

To launch a JupyterLab instance, go to [https://notebook.ospool.osg-htc.org](https://notebook.ospool.osg-htc.org) using an internet browser. 

You will be prompted to "Sign in" using your institution CILogin credentials.

Once logged in, you will be automatically redirected to the "Server Options" page. Several server options are listed, supporting a variety of programming environment and scientific workflows. To request a specific server configuration, [contact a Research Computing Facilitator](support@osgconnect.net). 

Select your desired server option and click "Start" to launch your instance. This process usually takes several minutes to complete. You will be redirected automatically to JupyterLab when your instance is ready.


# Working with your JupyterLab Instance

Working in JupyterLab, you will be able to interact with files in your `/home` directory, execute code, and save files. 

Each user has a *total* of 8 CPUs and 16 GB memory available to their JupyterLab instance and HTCondor jobs submitted from the notebook. 


# Sending jobs to HTCondor from JupyterLab

To send jobs from JupyterLab to HTCondor, the following information must be added to the HTCondor submit file with one modification: 

```
# The `requirements =` and `+FromJupyterLab` lines tell HTCondor to assign all jobs to run on the dedicated execute point server assigned to your instance upon launch. It is not necessary to edit these lines. 
requirements = Machine == "CHTC-Jupyter-User-EP-$ENV(HOSTNAME)"
+FromJupyterLab = true

# Sets a Project Name for this job submission 
+ProjectName = "ProjectNameinCOManage"
```

The only modification that needs to be made to these submit file attributes is to replace "ProjectNameinCOManage" with the project name you were assigned when you met with a Research Computing Facilitator. 

Therefore, an example HTCondor submit file for a JupyterLab job may look like: 

```
# hello-world.sub

executable = hello-world.sh
# arguments = 

log = hello-world.log
output = hello-world.out
error = hello-world.err

# transfer_input_files = file1, /path/to/file2

request_cpus = 1
request_memory = 1 GB
request_disk = 2 GB

requirements = Machine == "CHTC-Jupyter-User-EP-$ENV(HOSTNAME)"
+ProjectName = "ProjectNameinCOManage"
+FromJupyterLab = true

queue
```


# Log Out of JupyterLab Session

To log out of your session, go to the top left corner of the JupyterLab interface and click the "File" tab. Under this tab, click "Log Out". 


# Get Help

For questions or to receive help with launching JupyterLab, [contact a Research Computing Facilitator](support@osgconnect.net)
