[title]: - "HTCondor Compute Element"

[TOC]

# What is a Compute Element?

An OSG Compute Element (CE) is the entry point for the OSG to your local resources: a layer of software 
that you install on a machine that can submit jobs into your local batch system. At the heart of the CE is the 
job gateway software, which is responsible for handling incoming jobs, authorizing them, and delegating them to 
your batch system for execution. Historically, the OSG only had one option for a job gateway solution, Globus 
Toolkit’s GRAM-based gatekeeper, but now offers the HTCondor CE as an alternative.

Today in OSG, most jobs that arrive at a CE (called grid jobs) are not end-user jobs, but rather pilot jobs 
submitted from factories. Successful pilot jobs create and make available an environment for actual end-user jobs 
to match and ultimately run within the pilot job container. Eventually pilot jobs remove themselves, typically 
after a period of inactivity.

# What is HTCondor CE?

HTCondor CE is a special configuration of the HTCondor software designed to be a job gateway solution for the 
OSG. It is configured to use the JobRouter daemonto delegate jobs by transforming and submitting them to the site’s 
batch system.
