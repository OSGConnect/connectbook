[TOC]

[title]: - "Create user login and projects by manual intervention with gosync"


# Intervention

Usually, the cron jobs take care of everything (see below). However, in case of cron job failures or due to some unforseen 
errors, one may have to run the `gosync` command by hand. 

## Login to the Portal Server

Since `gosync` runs on the `www.osgconnect.net` server, the first step is to log in.

    $ ssh www.osgconnect.net

## Update new user and project

(Note that `gosync` must be run under sudo.)

To sync a new user "newosgconnectuser":

    $ cd /usr/local/gosync
    $ sudo ./gosync sync users --new --only newosgconnectuser

To sync all new users:

    $ cd /usr/local/gosync
    $ sudo ./gosync sync users --new

To sync all existing users:

    $ cd /usr/local/gosync
    $ sudo ./gosync sync users --updated

To sync a project:

    $ cd /usr/local/gosync
    $ sudo ./gosync sync groups

Note that after bringing in a new user, groups must _also_ be synchronized in order to grant the new user access. Thus the following idiom:

    $ cd /usr/local/gosync
    $ sudo ./gosync sync users --new
    $ sudo ./gosync sync groups



## gosync command reference

    $ cd /usr/local/gosync
    $ ./gosync
    usage: gosync [-u|--user=api-user] [-g|--group=top-group] [-f|--file=configfile] [--nw|--nowait] [-q|--quiet] [--force] 
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
           


# Automation

Cron jobs maintain the synchronization of users and groups in CI Connect with Globus Nexus.  The cron jobs run from the `root` user's crontab on `www.osgconnect.net`, and look like this:

    */2 * * * * ( cd /usr/local/gosync && ./gosync -q --nw sync users --new && ./gosync -q --nw sync groups ) >/dev/null 2>&1
    */15 * * * * ( cd /usr/local/gosync && ./gosync -q --nw sync users --updated; ./gosync -q --nw sync groups ) >/dev/null 2>&1

The first job adds new users every two minutes.  The second job updates existing users every 15 minutes.  Each job also adds new groups and updates existing groups.

Globus used to be called "Globus Online". `gosync` is short for `Globus Online Synchronizer`.

# Locks

In order to prevent one instance of `gosync` from conflicting with another, `gosync` uses a lock file. All uses of `gosync` that might conflict with another use of `gosync` require an exclusive lock.  A `gosync` command will run immediately if it can; otherwise it will "spin" until the lock is available.  The `gosync waitlock` command will wait for the lock to become available, then exit:

    $ cd /usr/local/gosync
    $ sudo ./gosync waitlock
    gosync NOTICE: lock file exists: pid = 28483 [waiting]
    gosync NOTICE: lock file exists: pid = 28483 [waiting]
    gosync NOTICE: lock file exists: pid = 28483 [waiting]
    gosync NOTICE: lock file exists: pid = 28483 [waiting]
    $ 

Again, any sync command will wait for the lock in this way.  To prevent a command from waiting, use the `--nowait` (or `--nw`) option. If the lock is unavailable, `gosync` will exit right away without doing whatever you asked it to do.

# Welcome message 
This is a boiler plate message send to the new users. 
Hi

Welcome to OSG Connect. I've activated your account in OSG Connect. You'll be able to log in using SSH to login.osgconnect.net.

General Examples:
Few examples outlined on  HelpDesk (http://support.opensciencegrid.org/support/solutions) under the section High Throughput Computation on OSG.⋅

Project:
We recommend the users to create new project for their research work.  You may want to review existing projects here: http://osgconnect.net/project-summary  and the guide on how to start a new project:
http://support.opensciencegrid.org/support/solutions/articles/5000634360-start-a-project-with-osg-connect 

Contact Us:
If you or your users have questions about OSG Connect or assistance in getting started, please contact us at user-support@opensciencegrid.org, or use the "Email Us" link from the web site or contact me.

Thank you



