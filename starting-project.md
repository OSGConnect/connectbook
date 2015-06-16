# Start a Project with OSG Connect

Background
----------

Projects in OSG are the means by which work by individual research groups is
organized, resources granted access, and usage accounted for.  We use OSG
Connect Projects to organize science work. Projects allow access to resources
and provide accounting.   Below is the process by which **principal
investigators or their delegates** create and manage projects within OSG
Connect.

Contact
-------

To start a project in OSG Connect, visit <https://osgconnect.net/newproject>.
 You will be asked to provide the following information:

-   Your name

-   Appointment type (student, postdoc, scientist, faculty, professional)

-   Email (please use an institutional email account, e.g.
    me\@myinstitution.edu)

-   Phone \#

-   Project name (short name and full name)

-   Principal investigator name

-   Principal investigator email

-   Field of science

-   Project description (the science goal)

-   A brief description of the application or workflow

OSG Connect administrative staff will review and create the project in the
system.  Within the [OSG Connect Portal](<https://portal.osgconnect.net/>), all
OSG Connect science projects are subgroups of the **osg** group. The naming
convention is: **osg.projectname**. *Projectname* is typically a mix of upper
case and lower case with no spaces or punctuation (except for hyphens). It
derives from the *short name* that you submit in your application form.

Project Membership
------------------

The project's principal investigator, or his/her delegate, is responsible for
project membership.  We will consult the PI or contact for group membership
request approvals. The PI may also be assigned an "Administrator" role of the
subgroup, and can invite OSG Connect members to the group directly. [Contact
us](<mailto:connect-support@opensciencegrid.org>) if this interests you.

ProjectName in HTCondor 
------------------------

The chosen ProjectName in HTCondor for jobs from this project have the
convention: 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ProjectName="ProjectName"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The submit files must include this directive or the jobs will not be submitted
by OSG Connect. (If it is incorrect, `condor-submit` will give you a useful
error message.)

Accounting Name
---------------

The project's resource usage appears in the OSG accounting system (Gratia) with
its name converted to ALL CAPS.  For example, a project named BiomechAnalysis
would become BIOMECHANALYSIS in Gratia.

 

About the OSG
-------------

The Open Science Grid (OSG) is a consortium of research communities who promote
science via sharing of computing resources. We enable a framework of distributed
computing and storage resources, a set of services and methods that enable
better access to ever increasing computing resources for researchers and
communities, and principles and software that enable distributed high
through-put computing (DHTC) for users and communities at all scales.

The OSG does not own the computing, storage, or network resources used by the
scientific community. The resources accessible through the OSG are contributed
by the community and organized by the OSG; an overview is available at [An
Introduction to
OSG](<http://osg-docdb.opensciencegrid.org/0008/000839/004/OSG%20Intro%20v23.pdf>).
Today, the OSG community brings together over 100 sites that provide
computational and storage resources; a current snapshot of deployment and usage
is available at the [OSG Usage Display](<http://display.grid.iu.edu/>).
Additional “how to” information is available at [An Introduction to Grid
Users](<https://www.opensciencegrid.org/bin/view/Documentation/UsingTheGrid>).
