[title]: - "Registration and Login for OSG Connect"

[TOC]

## Registration and Login for OSG Connect

The major steps to getting started on OSG Connect are: 

* apply for an OSG Connect account
* meet with an OSG Connect staff member for an short consultation and orientation. 
* join and set your default "project"
* upload `.ssh` keys to the OSG Connect website

Each of these is detailed in the guide below. 

Once you've gone through these steps, you should be able to login to the OSG Connect
submit node.  

## Account Creation

### Sign in to or create an account

Start by creating an account profile on the OSG Connect website. Visit the [OSG Connect web
site](<https://osgconnect.net/>), then click on the **Sign Up** button. You 
will need to agree to our Acceptable Use Policy in order to get to the 
main log in screen. 

The main log in screen will prompt you to sign in via your primary institutional 
affiliation. You'll be directed to a discovery
service which asks you what your home institution is. (If you've used CILogon
before it may already know your home institution and skip this step.) Locate
your institution in the list, or type its name to find matches. 

> **No Institutional Identity?**
> 
> If you don't have an institutional identity or can't find your institution 
> on the provided list, either (separately) sign up for a Globus ID and follow 
> the link for that option on this page, or contact the OSG Connect support 
> team for guidance at support@osg-htc.org

Note that this is the identity that will get linked to your OSG Connect profile, 
so be sure to pick the institution (if you have multiple affiliations) that 
you would like to associate with your OSG Connect account. 

After selecting your institution in the discovery service, you'll be taken to
your own institution's local sign-in screen. You've probably used it before,
and if it looks familiar that's because it's exactly the same web site.  Sign in
using your campus credentials. When done, you'll return automatically to the
OSG Connect portal to complete the signup.

> **Returning to the OSG Connect website**?
> 
> If you think you already have an OSG Connect profile and are not being taken to your 
> profile page after logging in with your institution's credentials, 
> see our [transition guide](12000065909#action-items) for 
> how to proceed.

After continuing, and allowing certain permissions in the next screen, you'll be 
asked to create a profile and save changes. If this works successfully, you should 
see that your membership is "pending" on the right hand side of the screen. 

### Orientation Meeting

Once you've applied to join OSG Connect as described above, an OSG Connect support 
team member will contact you to arrange an initial orientation meeting. This meeting 
generally takes about 20-30 minutes and is a chance to talk about your work, how it will 
fit on the OSG, and some practical next steps for getting started. Some of these 
next steps are also listed below. 

### Join a Project

As part of the sign up and meeting process, you'll be asked for information related 
to your research group so that you can be assigned to an accounting project. For 
more information about this process, see this guide: [Start or Join a Project in OSG Connect][projects]

### Generate and Add an SSH key

Once your account is created and you're approved, you can generate and upload an 
SSH key to your profile on the OSG Connect website; this key will be duplicated on the OSG Connect 
login node so that you're able to log in there and submit jobs. 

To see how to generate and add an SSH key, please visit this 
page: [Step by step instructions to generate and adding an SSH key][ssh-key]

## Log In

Once you've gone through the steps above, you should be able to log in to the OSG Connect 
login node using the "Unix Username" listed on your profile page. See the second half of the SSH key guide for details: 
[How to Log Into the OSG Connect Login Node][ssh-key]


[ssh-key]: 12000027675
[projects]: 5000634360

