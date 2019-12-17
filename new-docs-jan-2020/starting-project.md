# Join a Project in OSG Connect

## Background

The OSG Connect team assigns individual user accounts to "projects". These projects 
are a way to track usage hours and capture information about the types of 
research using OSG Connect. 

A project typically corresponds to a research group headed by a single PI, but can 
sometimes represent a long-term multi-institutional project or some other grouping. 

You must be a member of a project before you can use OSG Connect to submit jobs. 
The rest of this guide describes the process for joining an OSG Connect project. 

## Joining a Project

### Project Membership via Account Creation Process (usual)

You will be added to a project when going through the typical 
OSG Connect account creation process. After applying for an OSG Connect account, 
you will receive an email to set up a consultation meeting and also whether 
or not you want to join an existing project. You will be prompted to provide information 
based on the following two scenarios: 

- **If you are the first member of your research group / team to use the OSG through 
OSG Connect**, a new project will be created for you. You will be prompted to provide 
the following information to do so: 
	-    Project Name
	-    Short Project Name
	-    Field of Science
	-    PI Name
	-    PI Email
	-    PI Organization
	-    PI Department
	-    Project Description
- **If you know that other members of your research group have used OSG Connect** in the past, 
you can likely join a pre-existing group. Provide the name of your institution and PI 
to the OSG Connect team (if you haven't already) and we can confirm. 

Based on this information, OSG Connect support staff will either create a project and 
add you to it, or add you to an existing project when your account is approved. 

### Join a Project

If you are changing research groups (and therefore projects) or are coming to 
OSG Connect outside of the usual account creation process, it is possible to 
join a pre-existing project via the OSG Connect website or by emailing the 
OSG Connect support team (support@osgconnect.net) with your name and the project 
you wish to join. 

## "Set" your OSG Connect project

The job submission on OSG Connect requires a project. 

* Option 1 (preferred): To set the default project, type 

    $ connect project 
    
You should see a list of projects that you have joined. Most often there will 
only be one option! Make sure the right project is highlighted and press "enter" 
to save that choice. 

* Option 2: If you're running a few jobs under a different project, you can manually 
set the project by putting this option in the submit file: 

    +ProjectName="ProjectName"

## View Metrics For Your Project

The project's resource usage appears in the OSG accounting system, [GRACC](<https://gracc.opensciencegrid.org/>). 


