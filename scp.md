[title]: "Moving files onto login.osgconnect.net using scp"

Background
----------

We can transfer files to the OSG Connect login host using the Unix `scp command.
 Note scp `is a counterpart to the secure shell command, ssh, that allows for
secure, encrypted file transfers between systems using your ssh credentials.

Steps
-----

To transfer a file using `scp`, you'll need to run `scp` with the source and
destination.  Files on remote systems are indicated using
user\@[machine:/path/to/file](<http://machine/path/to/file>).

First, log in using your OSG Connect user id (username): 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ ssh username@login.osgconnect.net
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once logged in, change to the data directory, a link from your home area:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ cd ~/data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This directory is area on the Stash data server that you can use to store files
and directories. It functions just like any other UNIX directory although it has
additional functions that we'll go over shortly. 

Let's create a file:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ echo "Hello world" > my_hello_world
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now copy the file just created from Stash to our local system (Desktop or
laptop):

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ scp username@login.osgconnect.net:~/data/my_hello_world .
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As you can see, `scp` uses similar syntax to the `cp` command. To copy
directories using `scp`, you'll just pass the (recursive) `-r `option to it. 

For example:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ scp -r username@login.osgconnect.net:~/data/my-directory .
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

More Information
----------------

-   [The Unix
    Shell](<http://swc-osg-workshop.github.io/2014-12-15-UChicago/novice/shell/index.html>)
