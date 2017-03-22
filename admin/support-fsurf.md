[title]: - "FSurf user onboarding"

[TOC]

# General

Adding users to the FSurf system consists of three steps:

* Confirming user identity
* Create the account
* User Onboarding


# Confirming user identity

When signing up, users should provide some basic information including
their institution, institutional phone number, and institutional email 
address.  

Before creating the user account, preferably call the user to verify the user's
identity.  If that's not possible, emailing to verify the institutional email
address is acceptable.

# Create the account

Login to fsurf.osgconnect.net and run 

      sudo su - fsurf

to change to the fsurf user.  Then run 

      cd ~/fsurf-admin
      ./fsurf_user_admin.py create

and fill in all the fields.  You can use
[this](https://www.random.org/passwords/?num=5&len=8&format=html&rnd=new) page
to get a random password.

# Wrapping up 

Once the account has been created, respond to the ticket request with the
password that has been assigned to the account.  Make sure to point the user to
the FSurf documentation at
https://support.opensciencegrid.org/solution/folders/12000002373 .  
