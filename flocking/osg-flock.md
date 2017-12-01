[title]: - "Submit Node Flocking to OSG"

[TOC] 


## Overview


If you have a HTCondor submit node on your campus, it can be configured 
to spill over onto available resources on the Open Science Grid. In
HTCondor terms this is called 
[flocking](https://research.cs.wisc.edu/htcondor/manual/latest/5_2Connecting_HTCondor.html)


If you are interested in this solution, please open a 
[new ticket](https://support.opensciencegrid.org/helpdesk/tickets/new) with the hostname
and DN of the host certificate.


## Requirements

The requirements are:

 * HTCondor has to authenticate via GSI. At the minimum, the submit host
   has to have a host certificate and a list of trusted CAs under
   */etc/grid-security/certificates/*
 * Reporting to the OSG accounting system has to be enabled. This can
   be accomplished by installing and configuring the 
   *gratia-probe-condor* RPM.
 * Submitted jobs should have the *+ProjectName* attribute specified with
   a valid registered project name.


## Required Packages

Enable the [OSG Yum repository](http://opensciencegrid.github.io/docs/common/yum/).

Install the packages required for GSI authentication and Gratia job data:

    # yum install gratia-probe-condor osg-ca-certs osg-pki-tools


## Requesting a Host Certificate

A host certificate is used for authenticating your submit host to the OSG
infrastructure. If you do not already have a certificate, you can request one
using [these instructions](http://opensciencegrid.github.io/docs/security/host-certs/)


## Configuration


Edit the */etc/gratia/condor/ProbeConfig* file. Change the probe section to be:


    ProbeName="condor:YOUR_HOSTNAME_HERE" 
    SiteName="YOUR_SITE_HERE"
    Grid="OSG"
    SuppressUnknownVORecords="0"
    SuppressNoDNRecords="0"
    SuppressGridLocalRecords="1"
    QuarantineUnknownVORecords="1"
    EnableProbe="1"

    MapUnknownToGroup="1"
    MapGroupToRole="1"
    VOOverride="osg"


Please remember to enable the probe:


    [root@client ~]$ service gratia-probes-cron start


The following is a starting point for the HTCondor configuration. Depending on other
site configuration, some changes might be required. Put this in for example
/etc/condor/config.d/80-osg-flocking.conf


    # OSG VO flocking host
    OSG_FLOCK = osg-flock.grid.iu.edu
    OSG_FLOCK_DN = /DC=org/DC=opensciencegrid/O=Open Science Grid/OU=Services/CN=osg-flock.grid.iu.edu
    
    # submitters/campus factories to flock to
    FLOCK_TO = $(FLOCK_TO) $(OSG_FLOCK)
    
    # Who to trust?  Inlucde the <VO>_DN to trust the submitter
    GSI_DAEMON_NAME = $(GSI_DAEMON_NAME), $(OSG_FLOCK_DN)
    
    # This host's certificates
    # These are needed if you are flocking to a glideinwms host
    GSI_DAEMON_CERT = /etc/grid-security/hostcert.pem
    GSI_DAEMON_KEY = /etc/grid-security/hostkey.pem
    
    # Enable authentication from tne Negotiator
    SEC_ENABLE_MATCH_PASSWORD_AUTHENTICATION = TRUE
    
    # Enable gsi authentication
    SEC_DEFAULT_AUTHENTICATION_METHODS = FS,GSI, $(SEC_DEFAULT_AUTHENTICATION_METHODS)


## Project Names

OSG will only run jobs tagged with a valid *ProjectName* - this is the main attribute
used for accounting. New projects should be registered in the
[OSG OIM project database](https://oim.grid.iu.edu/oim/project). Jobs should specify
which project to be accounted against by adding the *+ProhectNane* attribute. Note
that the value is a string and hence the double quotes are required.  Example:



    +ProjectName = "Some_Name_Here"




