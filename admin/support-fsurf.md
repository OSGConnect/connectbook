[title]: - "FSurf Administration"

[TOC]

# Adding Users

Adding users to the FSurf system consists of three steps:

* Confirming user identity
* Create the account
* Wrapping Up


## Confirming user identity

When signing up, users should provide some basic information including
their institution, institutional phone number, and institutional email 
address.  

Before creating the user account, preferably call the user to verify the user's
identity.  If that's not possible, emailing to verify the institutional email
address is acceptable.

## Create the account

Login to fsurf.osgconnect.net and run 

      sudo su - fsurf

to change to the fsurf user.  Then run 

      cd ~/fsurf-admin
      ./fsurf_user_admin.py create

and fill in all the fields.  You can use
[this](https://www.random.org/passwords/?num=5&len=8&format=html&rnd=new) page
to get a random password.

## Wrapping up 

Once the account has been created, respond to the ticket request with the
password that has been assigned to the account.  Make sure to point the user to
the FSurf documentation at
https://support.opensciencegrid.org/solution/folders/12000002373 .  

# General administration

## Listing workflows

In order to view workflows, login to `fsurf.osgconnect.net` and run the
following:

        sudo su - fsurf
        cd ~/fsurf-admin
        ./fsurf_admin.py list

To view an entire list of all the workflows use the `--all-workflows` option.
To see workflows run by a specific user, use the `--username USERNAME` option.

## Deleting workflows

In order to delete workflows, login to `fsurf.osgconnect.net` and run the
following:

        sudo su - fsurf
        cd ~/fsurf-admin
        ./fsurf_admin.py delete --id WORKFLOW_ID

where `WORKFLOW_ID` is replaced by the id of the workflow that should be
deleted.

## Listing users

In order to view users, login to `fsurf.osgconnect.net` and run the
following:

        sudo su - fsurf
        cd ~/fsurf-admin
        ./fsurf_user_admin.py list

## Modifying user information

In order to modify an user, login to `fsurf.osgconnect.net` and run the
following:

        sudo su - fsurf
        cd ~/fsurf-admin
        ./fsurf_user_admin.py modify --username USER

where `USER` is the name of the user.

## Disabling an user

In order to disable an user account, login to `fsurf.osgconnect.net` and run the
following:

        sudo su - fsurf
        cd ~/fsurf-admin
        ./fsurf_user_admin.py disable --username USER

where `USER` is the name of the user.
