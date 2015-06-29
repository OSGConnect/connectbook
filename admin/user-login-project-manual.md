[title]: - "Create user login and projects by manual intervention with gosync"

Usually, the cron jobs take care of user and account creations on login node based on the globus database. The gosync command synchronizes the globus information with the www.osgconnect.net server. In case of cron job failures or due to some unforseen 
errors, one may have to run the gosync command by hand. 

## Login to the Portal Server

    $ ssh www.osgconnect.net
    $ cd /usr/local/gosync
    $ gosync

## gosync command 

    $ /usr/local/gosync --help
gosync ERROR: option --help not recognized
    usage: gosync [-u|--user=api-user] [-g|--group=top-group] [-f|--file=configfile] [--nw|--nowait] [-q|--quiet] [--force] ...
           gosync [opts] deluser <user> [<user> ...]
           gosync [opts] group accept <groupname> <user> <email>
           gosync [opts] group accept <groupname> <user> [<...>]
           gosync [opts] group admin <groupname> <user> [<user> ...]
           gosync [opts] group delmember <groupname> <user> [<user> ...]
           gosync [opts] group get <groupname>
           gosync [opts] group list [-baseurl url | -portal hostname] [-format {html|csv|xml|json|text}] [filters ...]
           gosync [opts] group manager <groupname> <user> [<user> ...]
           gosync [opts] group member <groupname> <user> [<user> ...]
           gosync [opts] group members <groupname> [<groupname> ...]
           gosync [opts] group new [-top] [-parent groupname] <groupname> [<groupname> ...] [: <user> ...]
           gosync [opts] group syncdesc <groupname> [<groupname> ...]
           gosync [opts] group syncpolicy <groupname> [<groupname> ...]
           gosync [opts] shell
           gosync [opts] sync groups
           gosync [opts] sync users
           gosync [opts] sync users [--new] [--updated] [--only <user> [...]]
           gosync [opts] waitlock

## Update new user and project 
To sync a new user "newosgconnectuser"

    sudo /usr/local/gosync sync users --new --updated --only newosgconnectuser

To sync the project

   sudo /usr/local/gosync sync groups


##Cronjob scripts
(location of the cronjob scripts, in case we want to refer them or to check they are running)









