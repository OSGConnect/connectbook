[title]: - "Use scp To Transfer Files To and From OSG Connect"

[TOC]

# Overview

This tutorial assumes that you will be using a command line application 
for performing file transfers instead of a GUI-based application such as WinSCP. 

We can transfer files to and from the OSG Connect login node using the 
`scp` command. Note `scp` is a counterpart to the secure shell 
command,`ssh`, that allows for secure, encrypted file transfers between 
systems using your ssh credentials.

When using `scp`, you will always need to specify both the source of the
content that you wish to copy and the destination of where you would like 
the copy to end up. For example:

    $ scp <source> <destination>

Files on remote systems (like an OSG Connect login node) are indicated using
`username@machine:/path/to/file`.

# Transfer Files To OSG Connect

Let's say you have a file you wish to transfer to OSG Connect named `my_file.txt`.

Using the terminal application on your computer, navigate to the location of `my_file.txt`.

Then use the following `scp` command to tranfer `my_file.txt` to your `/home` on OSG Connect. Note
that you will **not** be logged into OSG Connect when you perform this step.

    $ scp my_file.txt username@loginNN.osgconnect.net:/home/username/

Where **NN** is the specific number of your assigned login node (i.e. `04` or `05`).

Large files (>100MB in size) can be uploaded to your `/public` directory also using `scp`:

    $ scp my_large_file.gz username@loginNN.osgconnect.net:/public/username/

## Transfer Directories To OSG Connect

To copy directories using `scp`, add the (recursive) `-r` option to your scp command.

For example:

    $ scp -r my_Dir username@loginNN.osgconnect.net:/home/username/

# Transfer Files From OSG Connect

To transfer files from OSG Connect back to your laptop or desktop you can use the `scp` as shown above, 
but with the source being the copy that is located on OSG Connect:

    $ scp username@loginNN.osgconnect.net:/home/username/my_file.txt ./

where `./` sets the destination of the copy to your current location on your computer 

# Transfer Files Between OSG Connect and Another Server

`scp` can be used to transfer files between OSG Connect and another server that you have 
`ssh` access to. This means that files don't have to first be transferred to your 
personal computer which can save a lot of time and effort! For example, to transfer 
a file from another server and your OSG Connect login node `/home` directory:

    $ scp username@serverhostname:/path/to/my_file.txt username@loginNN.osgconnect.net:/home/username

Be sure to use the username assigned to you on the other server and to provide the 
full path on the other server to your file.

# Get Help

For assistance or questions, please email the OSG User Support team  at [support@osgconnect.net](mailto:support@osgconnect.net) or visit the [help desk and community forums](http://support.opensciencegrid.org).

