# Start or Join a Project in OSG Connect

## Background

We use OSG Connect Projects to organize science work. Projects in OSG are the 
means by which work by individual research groups is
organized, resources granted access, and usage accounted for.
You should be a member of a project before you can use OSG Connect to submit jobs. 

Below is the process by which **principal
investigators or their delegates** can create, join, and manage projects within OSG
Connect.

## Request a New Project

If you or your group does not already have a project in OSG Connect, you can 
start one. To do so, visit <https://osgconnect.net/newproject>.
 You will be asked to provide the following information:
 
-    Your Name
-    Your Email Address
-    Project Name
-    Short Project Name
-    Field of Science
-    Field of Science (if Other)
-    PI Name
-    PI Email
-    PI Organization
-    PI Department
-    Project Contact
-    Project Contact Email
-    Telephone Number
-    Project Description

You can also send us this information directly via email at support@osgconnect.net. 

OSG Connect administrative staff will review and create the project in the
system.  Within the [OSG Connect Portal](<https://portal.osgconnect.net/>), all
OSG Connect science projects are subgroups of the **osg** group. The naming
convention is: **osg.projectname**. *Projectname* is typically a mix of upper
case and lower case with no spaces or punctuation (except for hyphens). It
derives from the *short name* that you submit in your application form.

## Join a Project

To join a pre-existing project email the OSG Connect team (support@osgconnect.net) 
with your name and the project you wish to join. You can also be added to a project 
by the PI or their delegate (see next session). 

## Managing Project Membership

The project's principal investigator, or their delegate, is responsible for
project membership. We will consult the PI or contact for group membership
request approvals. The PI may also be assigned an "Administrator" role of the
project group, and can invite OSG Connect members to the group directly. [Contact
us](<mailto:user-support@opensciencegrid.org>) if this interests you.

## ProjectName in HTCondor Jobs

The job submission on OSG Connect requires a project. Either you define the keyword `+ProjectName` for each job or you set the default project. 

* Option 1: In your HTCondor job submit file, include the following directive convention:

    +ProjectName="ProjectName"

* Option 2: To set the default project, type 

    $ connect project 
    
 and select a project. After the selection of default project, it is okay to omit the "+Projectname" description in the job description file.

## Projects in Accounting

The project's resource usage appears in the OSG accounting system, [GRACC](<https://gracc.opensciencegrid.org/>). 


