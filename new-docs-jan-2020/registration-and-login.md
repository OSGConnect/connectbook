[title]: - "Registration and Login for OSG Connect"

## Registration and Login for OSG Connect

The major steps to getting started on OSG Connect are creating an OSG
Connect account, requesting and/or joining a "project", and uploading
ssh keys to the OSG Connect website which will allow you to log in and
start submitting jobs. 

Authentication with the user management system is using your 
institutional credentials. For example, you can authenticate with your
own university account.

## Account Creation

### Sign in to or create an account

Start by creating an OSG Connect account. Visit the [OSG Connect web
site](<https://osgconnect.net/>), then select **Sign Up**.

The default first step is to sign in using an InCommon ID through the CILogon
service. This allows you to enroll using your existing campus identifier and
credentials, provided that your home institution is a member of the InCommon
Federation.

Click on **Proceed** to begin this process. You'll be directed to a discovery
service which asks you what your home institution is. (If you've used CILogon
before it may already know your home institution and skip this step.) Locate
your institution in the list, or type its name to find matches. If your
institution does not appear, it may not be an InCommon member; you'll need to
register using another provider such as Google.

After selecting your institution in the discovery service, you'll be taken to
your own institution's local sign-in screen. You've probably used it before,
and if it looks familiar that's because it's exactly the same web site.  Sign in
using your campus credentials. When done, you'll return automatically to the
OSG Connect portal and can carry on with signup.

## Generate and Add an SSH key

Once your account is created and you're approved, you 
can upload ssh keys to log in. 

Please visit this page: [Step by step instructions to generate and adding an SSH key][ssh-key]

## Join a Project

Congratulations! You're now signed up, and you have all the accounts that you'll
need. A critical step remains, though, before you can begin computing. You've
now joined the OSG Connect community, which gives you visibility of the various
projects associated with OSG Connect. To begin working in the facility, or using
the Stash service for file storage,  you'll need to join one (or more) of them.

See this guide: [Start or Join a Project in OSG Connect][projects]

## Ready?

Having stepped through these procedures and joined an `osg.*` project group, you
have all the roles and access that you need to continue working. There can be
some delay for project membership approval, but aside from that access rights
are generally implemented in the OSG Connect servers within minutes. 

## Overview of access procedure and accounting

For those interested in details, this section describes some of the background 
information behind projects. 

The Open Science Grid governs access to grid resources through an accounting
framework that assigns each user's *jobs* to an *accounting group* or *project*.
As a new user of the OSG, one of the first things to iron out is what
project or projects best describe your work.  This is more a matter of
accountability than of entitlement: it concerns how organizations report to
their sponsors and funding agencies on the utilization of resources placed under
their administration.

To assist in this, OSG Connect uses a group management tool that places users
into one or more groups with names such as *osg.RDCEP* or *osg.Extenci*. 
The *osg* portion of this name differentiates our groups from those of 
other organizations in the same group management facility. The latter portion 
identifies the specific project, each with a Principal Investigator or other 
administrator, that oversees access to resources. Within our web tools, these 
names are often in mixed case, though you may see them uppercased in some 
reporting/accounting software.

The first step in registration is to create a user account and *bind* it to
other identity information. After that you will enroll in a project group.

Once you've enrolled in a group, you'll have the requisite rights to log in to
the submit node for the OSG Connect job scheduler, or to transfer data in and
out of Stash. Submit node logins are typically via Secure Shell (SSH) using a
password or a public key. We'll discuss how to connect further on. Stash access
is possible from the submit node and through Globus transfer or using HTTP to a 
public space within your Stash.

[ssh-key]: 12000027675
[projects]: 5000634360

