[title]: - "Using scp to transfer files to OSG Connect"

Background
----------

This tutorial assumes that you will be using a command line application for performing file transfers instead of a
GUI-based application such as WinSCP. 

We can transfer files to and from the OSG Connect login node using the Unix `scp` command. Note `scp` is a counterpart 
to the secure shell command,`ssh`, that allows for secure, encrypted file transfers between systems using your 
ssh credentials.

When using `scp`, you will always need to specify both the source of the
content that you wish to copy and the destination of where you would like 
the copy to end up. For example:

    $ scp <source> <destination>

Files on remote systems (like an OSG login node) are indicated using
`username@machine:/path/to/file`.

Transfer files to OSG Connect
-----

Let's say you have a file you wish to transfer to OSG Connect named `my_file.txt`.

Using the terminal application on your computer, navigate to the location of `my_file.txt`.

Then use the following `scp` command to tranfer `my_file.txt` to your `/home` on OSG Connect. Note
that you will **not** be logged into OSG Connect when you perform this step.

    $ scp my_file.txt username@loginNN.osgconnect.net:/home/username/

To copy directories using `scp`, add the (recursive) `-r` option to your scp command. 

For example:

    $ scp -r my_Dir username@loginNN.osgconnect.net:/home/username/

Transfer files from OSG Connect
-----
To transfer files from OSG Connect back to your laptop or desktop you can use the `scp` as shown above, 
but with the source being the copy that is located on OSG Connect:

    $ scp username@loginNN.osgconnect.net:/home/username/my_file.txt ./

where `./` sets the destination of the copy to your current location on your computer 

More Information
----------------

-   [The Unix
    Shell](<http://swc-osg-workshop.github.io/2014-12-15-UChicago/novice/shell/index.html>)
