[title]: - "Saving or changing user account information"
[TOC]
 
 
## Saving user credentials
The examples in these pages run the `fsurf` command using the `--user` and `--password` options to give an username 
and password to the fsurf command.  However, when you do so, fsurf will ask you if you want to save these credentials.  
If you say yes to this, then you can omit these options and let fsurf use the saved credentials for future invocations.


## Changing saved user credentials
To change saved user credentials (e.g. if your password has been changed),  just run any command with the `--user ` option. 
The `fsurf` tool will ask you for a password and then ask you if you'd like to save your credentials.  Enter 'y' or 'yes' at 
the prompt and your credentials will be updated.

## Changing your account's password 
To change your account's password, run `./fsurf change-password` or `./fsurf --user myuser --password mypassword`.  The tool
will then prompt you for a new password and update your account's password.


## Getting Help 
For assistance or questions, please email the OSG User Support team  at [user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or visit the [help desk and community forums](http://support.opensciencegrid.org).



