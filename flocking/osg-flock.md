[title]: - "Submit Node Flocking to OSG"

[TOC]

## Overview

If you have a HTCondor submit node on your campus, it can be configured
to spill over onto available resources on the Open Science Grid. In
HTCondor terms this is called
[flocking](https://research.cs.wisc.edu/htcondor/manual/latest/ConnectingHTCondorPoolswithFlocking.html)

If you are interested in this solution, please open a
[new ticket](https://support.opensciencegrid.org/helpdesk/tickets/new) with the hostname.

## Requirements

The requirements are:

* A public IP address, forward and reverse DNS
* Ability to open firewall ports
* HTCondor has to authenticate via pool password or GSI. For GSI, the submit host
   has to have a host certificate and a list of trusted CAs under */etc/grid-security/certificates/*
* Reporting to the OSG accounting system has to be enabled. This can
   be accomplished by installing and configuring the *gratia-probe-condor* and *gratia-probe-glideinwms* RPMs.
* Submitted jobs should have the *+ProjectName* attribute specified with
   a valid registered project name.

## Required Packages

Enable the [OSG Yum repository](http://opensciencegrid.github.io/docs/common/yum/).

Install the packages required:

    # yum install osg-flock

## Gratia Probe Configuration

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

Please remember to enable and start the probe:

    [root ~]$ systemctl enable gratia-probes-cron
    [root ~]$ systemctl start gratia-probes-cron

## Pool Password: HTCondor Configuration

The following is a starting point for the HTCondor configuration. Depending on other
site configuration, some changes might be required. Put this in for example
/etc/condor/config.d/80-osg-flocking.conf

    #--  With glideins, there is nothing shared
    CONDOR_HOST=$(FULL_HOSTNAME)
    UID_DOMAIN=$(FULL_HOSTNAME)
    FILESYSTEM_DOMAIN=$(FULL_HOSTNAME)
    
    #-- Authentication settings
    SEC_PASSWORD_FILE = /etc/condor/pool_password
    SEC_DEFAULT_AUTHENTICATION = REQUIRED
    SEC_DEFAULT_AUTHENTICATION_METHODS = FS,PASSWORD
    SEC_READ_AUTHENTICATION    = OPTIONAL
    SEC_CLIENT_AUTHENTICATION  = OPTIONAL
    SEC_ENABLE_MATCH_PASSWORD_AUTHENTICATION = TRUE
    DENY_WRITE         = anonymous@*
    DENY_ADMINISTRATOR = anonymous@*
    DENY_DAEMON        = anonymous@*
    DENY_NEGOTIATOR    = anonymous@*
    DENY_CLIENT        = anonymous@*
    
    #--  Privacy settings
    SEC_DEFAULT_ENCRYPTION = OPTIONAL
    SEC_DEFAULT_INTEGRITY = REQUIRED
    SEC_READ_INTEGRITY = OPTIONAL
    SEC_CLIENT_INTEGRITY = OPTIONAL
    SEC_READ_ENCRYPTION = OPTIONAL
    SEC_CLIENT_ENCRYPTION = OPTIONAL
    
    #-- With strong security, do not use IP based controls
    HOSTALLOW_WRITE = *
    
    # submitters/campus factories to flock to
    FLOCK_TO = flock.opensciencegrid.org
    


## GSI: HTCondor Configuration

The following is a starting point for the HTCondor configuration. Depending on other
site configuration, some changes might be required. Put this in for example
/etc/condor/config.d/80-osg-flocking.conf

    #--  With glideins, there is nothing shared
    CONDOR_HOST=$(FULL_HOSTNAME)
    UID_DOMAIN=$(FULL_HOSTNAME)
    FILESYSTEM_DOMAIN=$(FULL_HOSTNAME)
    
    #-- Authentication settings
    SEC_DEFAULT_AUTHENTICATION = REQUIRED
    SEC_DEFAULT_AUTHENTICATION_METHODS = FS,GSI
    SEC_READ_AUTHENTICATION    = OPTIONAL
    SEC_CLIENT_AUTHENTICATION  = OPTIONAL
    SEC_ENABLE_MATCH_PASSWORD_AUTHENTICATION = TRUE
    DENY_WRITE         = anonymous@*
    DENY_ADMINISTRATOR = anonymous@*
    DENY_DAEMON        = anonymous@*
    DENY_NEGOTIATOR    = anonymous@*
    DENY_CLIENT        = anonymous@*
    
    #--  Privacy settings
    SEC_DEFAULT_ENCRYPTION = OPTIONAL
    SEC_DEFAULT_INTEGRITY = REQUIRED
    SEC_READ_INTEGRITY = OPTIONAL
    SEC_CLIENT_INTEGRITY = OPTIONAL
    SEC_READ_ENCRYPTION = OPTIONAL
    SEC_CLIENT_ENCRYPTION = OPTIONAL
    
    #-- With strong security, do not use IP based controls
    HOSTALLOW_WRITE = *

    # OSG VO flocking host
    OSG_FLOCK = flock.opensciencegrid.org
    OSG_FLOCK_DN = /DC=org/DC=incommon/C=US/postalCode=53706/ST=WI/L=Madison/street=1210 West Dayton Street/O=University of Wisconsin-Madison/OU=OCIS/CN=flock.opensciencegrid.org

    # submitters/campus factories to flock to
    FLOCK_TO = $(FLOCK_TO) $(OSG_FLOCK)

    # Who to trust?  Inlucde the <VO>_DN to trust the submitter
    GSI_DAEMON_NAME = $(GSI_DAEMON_NAME), $(OSG_FLOCK_DN)

    # This host's certificates
    # These are needed if you are flocking to a glideinwms host
    GSI_DAEMON_CERT = /etc/grid-security/hostcert.pem
    GSI_DAEMON_KEY = /etc/grid-security/hostkey.pem

## GSI: Requesting a Host Certificate

A host certificate is used for authenticating your submit host to the OSG
infrastructure. If you do not already have a certificate, you can request one
using [these instructions](http://opensciencegrid.github.io/docs/security/host-certs/)

## Project Names

OSG will only run jobs tagged with a valid *ProjectName* - this is the main attribute
used for accounting. New projects should be registered in the
[OSG Topology Database](https://github.com/opensciencegrid/topology/blob/master/README.md).
Please open at ticket to register a new project.
Jobs should specify which project to be accounted against by adding
the *+ProhectNane* attribute. Note that the value is a string and hence
the double quotes are required.  Example:

    +ProjectName = "Some_Name_Here"

