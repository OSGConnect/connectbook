[title]: - "Data Transfer with Globus"

Background
----------

Use Globus for transferring data to and from OSG Connect and its storage
service [Stash](<http://stash.osgconnect.net/>).  For data to be used on the
OSG, move the data into your storage area on Stash. From the OSG Connect login
host, `login.osgconnect.net`, this appears as: `/stash/user/your-username`.

Transfer data between existing servers
--------------------------------------

-   From the [portal.osgconnect.net](<http://portal.osgconnect.net/>) web site,
    click the Transfer ▸ Start Transfer menu.

-   On one side, enter `connect#stash` into the endpoint field, and press
    "Return" or the "Go" button.  

-   On the other side, enter the other endpoint from which you want to transfer
    data.

-   Browse the files and folders on the two endpoints to configure you transfer.

-   Optionally modify the advanced options below the two file browser panes.

-   Click on one of the arrows at the top to submit the transfer request: Go to
    the View Transfer window to see your transfer progress.  Click on the
    progress bar to drill in on transfer details.

Transferring between your laptop and OSG Connect Stash
------------------------------------------------------

To add your own laptop as an endpoint, so that you can transfer data to/from
stash, you need to install Globus Connect, by clicking on the "Get Globus
Connect" in the upper right corner of the Start Transfer page. More detailed
instructions for installing Globus Connect can be found
here: <https://www.globusonline.org/globus_connect/>.

 

For servers
-----------

To add your own server as an endpoint, so that any user on that server can
transfer data to/from stash, you need to install Globus Connect Multiuser.
Detailed instructions can be found here: <https://www.globusonline.org/gcmu/>. 

 

Using the Globus Online Command Line Interface
----------------------------------------------

You can also use the Globus Online CLI via ssh
<your-user-name>@cli.globusonline.org. More
instructions on using the Globus Online CLI are
here: <https://www.globusonline.org/usingcli/>.

 

Using the Globus CLI from login.osgconnect.net
----------------------------------------------

When logging into `login.osgconnect.net`, if you use the `ssh -A`
flag, then you will be able to login from `login.osgconnect.net`
to `cli.globusonline.org`.   This would be useful to run transfer
scripts on `login.osgconnect.net`. Check the Globus command line
interface from your terminal.

 

	$ ssh -A username@login.osgconnect.net
	$ ssh username@cli.globusonline.org help
	Task Management:        cancel                 modify
	                        details                status
	                        events                 wait
	Task Creation:          scp                    transfer
	                        rm                     delete
	File Management:        ls                     rename
	                        mkdir
	Endpoint Management:    endpoint-add           acl-add
	                        endpoint-activate      acl-list
	                        endpoint-deactivate    acl-remove
	                        endpoint-list         
	                        endpoint-modify
	                        endpoint-remove
	                        endpoint-rename
	Other:                  help                   profile
	                        history                versions
	                        man

Now check the available endpoints:

	$ ssh username@cli.globusonline.org endpoint-list
	...
	username#desktop  
	...
	connect#stash
	...

To activate the end points:

	$ ssh username@cli.globusonline.org endpoint-activate \
	  username#desktop connect#stash

To copy a file from `connect#stash` to `username#desktop`:

	$ ssh username@cli.globusonline.org scp \
	  connect#stash:/stash/user/username/public/file.txt \
	  username#desktop:/home/username/.
 

More Information
----------------

-   There are a few other quick start guides
    here: <https://www.globusonline.org/quickstart/>.  

-   There's lots of good Globus Online material, including documentation, faqs,
    etc here: <https://support.globusonline.org/forums>

-   More instructions on using the Globus Online CLI are
    here: <https://www.globusonline.org/usingcli/>.
