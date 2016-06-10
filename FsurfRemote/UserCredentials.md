[title]: - "Saving or changing user account information"
 
 
## Saving account name and password

However, when you do so, `fsurf` will ask you if you want to save 
these credentials. If you say yes to this, then you can omit these options 
and let `fsurf` use the saved credentials for future invocations.


## Changing saved account information
To change saved user credentials (e.g. if your password has been changed), 
just run any command with the `--user ` option.  The `fsurf` utility will 
ask you for a password and then ask you if you'd like to save your 
credentials.  Enter 'y' or 'yes' at the prompt and your credentials 
will be updated.

## Changing your account's password 
To change your account's password, run 
`./fsurf change-password` or `./fsurf --user myuser --password mypassword`.  
`fsurf` will then prompt you for a new password and update 
your account's password.

## Security 
Since `fsurf` stores your password on your computer in a format that
can be decoded, please use a password unique to `fsurf`.

## Getting Help 
For assistance or questions, please email the OSG User Support team  at
[user-support@opensciencegrid.org](mailto:user-support@opensciencegrid.org) or
visit the [help desk and community forums](http://support.opensciencegrid.org).

## Validation Information
A list of linux kernels on OSG  on which the FreeSurfer workflows have been
validated can be found
[here](https://support.opensciencegrid.org/support/solutions/articles/12000008494-freesurfer-validation-on-the-osg-)
