[title]: - "Saving or Changing User Account Information"
 
 
## Saving account name and password

When you run `fsurf` it will ask you for an username and password.  
After requesting this information, `fsurf` will ask you if you want to save
these credentials. If you say yes to this, then you can omit these options 
and let `fsurf` use the saved credentials for future invocations.

If you would like to change the saved username or password, you can run any
`fsurf` command with the `--user NEW_USERNAME` option where `NEW_USERNAME` is 
the new username that you would like to use.  Fsurf will prompt you for a new
password and ask you if you would like to save this information.  Saying yes to
the prompt will replace the saved username and password.


## Changing account password

To change your account's password, run 
`./fsurf change-password` or `./fsurf --user='myuser' --password='mypassword'`.  
`fsurf` will then prompt you for a new password and update 
your account's password.

## Security 
Since `fsurf` stores your password on your computer in a format that
can be decoded, please use a password unique to `fsurf`.
