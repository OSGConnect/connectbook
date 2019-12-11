[title]: - "Registration and Login for OSG Connect"

## Registration and Login for OSG Connect

(An [abbreviated version of these signup
instructions](<https://osgconnect.net/signup>) is provided when you
choose [signup](<https://osgconnect.net/signup>) from the [OSG Connect main
site](<https://osgconnect.net/>). This section of the Help Desk provides more
comprehensive information about the registration process, but the shortened
step-by-step guide is perhaps easier to follow.)

The major steps to getting started on OSG Connect are creating an OSG Connect account (which is 
created under the `osg` project group), creating and/or joining a "project" (a subgroup of 
the parent `osg` group) with your account, and uploading ssh keys to the OSG Connect 
website which will allow you to log in and start submitting jobs. 

## Account Creation

### Sign in to or create an account

Start by creating an OSG Connect identity / account. Visit the [OSG Connect web
site](<https://osgconnect.net/>), then select **Sign In/Sign Up ▸ Sign up as a
new user**. There are a few paths forward from here, but all end up with linking
your OSG Connect identity with a Globus identity. This not only provides
integrated identity service, it also enables you to begin performing data
transfers to OSG Connect very early on, with a minimal fuss, using Globus 
transfer.

**Note: You sill need to register using a GlobusID (@globusid.org) not your institutional login. You can 
link your institutional account to the GlobusID if desired, but your OSG Connect application 
cannot be processed without a GlobusID login.**

<!-- ### InCommon Registration

The default first step is to sign in using an InCommon ID through the CILogon
service. This allows you to enroll using your existing campus identifier and
credentials, provided that your home institution is a member of the InCommon
Federation.

Click on **Proceed** to begin this process. You'll be directed to a discovery
service which asks you what your home institution is. (If you've used CILogon
before it may already know your home institution and skip this step.) Locate
your institution in the list, or type its name to find matches. If your
institution does not appear, it may not be an InCommon member; you'll need to
register using another approach described below.

After selecting your institution in the discovery service, you'll be taken to
your own institution's local sign-in screen. You've probably used it before,
and if it looks familiar that's because it's exactly the same web site.  Sign in
using your campus credentials. When done, you'll return automatically to the
OSG Connect portal and can carry on with signup. -->

### Globus Registration

<!--If your institution is not linked to CILogon, you can sign in with a Globus identity 
instead. -->
Click on **Sign Up with Globus**. If you already have
a Globus account, click **Already a member? Sign In** to sign in now. Otherwise,
provide your name, email address, and a username and password to register a new
account. Your OSG Connect identity will piggyback from here.

<!-- | **Using InCommon/CILogon**                     | **Using Globus ID (existing)**                             | **Using Globus  (new)**                |
|------------------------------------------------|-------------------------------------------------------------------|----------------------------------------------|
| Click **Proceed**.                             | Click **Sign Up with Globus**, then **Already a member? Sign In** | Click **Sign Up with Globus**.               |
| Select your institution from the CILogon site. | Enter Globus username and password.                               | Enter Name, Email, Username, Password.       |
| Perform authentication at your institution.    | ↓                                                                 | Await validation email, use link to confirm. |
| Go to the **Link accounts **workflow.          | Go to the **Join group **workflow.                                | Go to the **Join group **workflow.           | -->


| **Using Globus ID (existing)**                                    | **Using Globus  (new)**                      |
|-------------------------------------------------------------------|----------------------------------------------|
| Click **Sign Up with Globus**, then **Already a member? Sign In** | Click **Sign Up with Globus**.               |
| Enter Globus username and password.                               | Enter Name, Email, Username, Password.       |
| ↓                                                                 | Await validation email, use link to confirm. |
| Go to the **Join group **workflow.                                | Go to the **Join group **workflow.           |


### Join group

To complete the registration process, submit an application to join the `osg` group.

## Generate and Add an SSH key

Once your account is created and you're approved to join the `osg` group, you 
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
