# Start a Project with OSG Connect

Background
----------

Projects in OSG are the means by which work by individual research groups is
organized, resources granted access, and usage accounted for. We use OSG
Connect Projects to organize science work. Projects allow access to resources
and provide accounting. Below is the process by which **principal
investigators or their delegates** create and manage projects within OSG
Connect.

Contact
-------

To start a project in OSG Connect, visit <https://osgconnect.net/newproject>.
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
-    Join Date
-    Sponsor
-    OSG Sponsor Contact
-    Project Contact
-    Project Contact Email
-    Telephone Number
-    Project Description

OSG Connect administrative staff will review and create the project in the
system.  Within the [OSG Connect Portal](<https://portal.osgconnect.net/>), all
OSG Connect science projects are subgroups of the **osg** group. The naming
convention is: **osg.projectname**. *Projectname* is typically a mix of upper
case and lower case with no spaces or punctuation (except for hyphens). It
derives from the *short name* that you submit in your application form.

Project Membership
------------------

The project's principal investigator, or his/her delegate, is responsible for
project membership. We will consult the PI or contact for group membership
request approvals. The PI may also be assigned an "Administrator" role of the
subgroup, and can invite OSG Connect members to the group directly. [Contact
us](<mailto:connect-support@opensciencegrid.org>) if this interests you.

ProjectName in HTCondor Jobs
----------------------------
The job submission on OSG Connect requires a project. Either you define the keyword `+ProjectName` for each job or you set the default project. 

In your HTCondor job submit file, include the following directive convention:

    +ProjectName="ProjectName"

To set the default project, type 

    $ connect project 
    
 and select a project. After the selection of default project, it is okay to omit the "+Projectname" description in the job description file.


Accounting Name
---------------

The project's resource usage appears in the OSG accounting system (Gratia) with
its name converted to ALL CAPS. For example, a project named BiomechAnalysis
would become BIOMECHANALYSIS in Gratia.


