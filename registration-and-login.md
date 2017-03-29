[title]: - "Registration and Login for OSG Connect"

Registration and Login for OSG Connect
======================================

(An [abbreviated version of these signup
instructions](<https://osgconnect.net/signup>) is provided when you
choose [signup](<https://osgconnect.net/signup>) from the [OSG Connect main
site](<https://osgconnect.net/>). This section of the ConnectBook provides more
comprehensive information about the registration process, but the shortened
step-by-step guide is perhaps easier to follow.)

Overview of access procedure
----------------------------

The Open Science Grid governs access to grid resources through an accounting
framework that assigns each user's *jobs* to an *accounting group* or *project*.
As a new user of the OSG, therefore, one of the first things to iron out is what
project or projects best describe your work.  This is more a matter of
accountability than of entitlement: it concerns how organizations report to
their sponsors and funding agencies on the utilization of resources placed under
their administration.

To assist in this, OSG Connect uses a group management tool that places users —
individual human identities — into one or more groups with names such
as *osg.RDCEP* or *osg.Extenci*. The *osg* portion of this name differentiates
our groups from those of other organizations in the same group management
facility. The latter portion identifies the specific project, each with a
Principal Investigator or other administrator, that oversees access to
resources. Within our web tools, these names are often in mixed case, though you
may see them uppercased in some reporting/accounting software.

The first step in registration is to create a user account and *bind* it to
other identity information. After that you will enroll in a project group.


Once you've enrolled in a group, you'll have the requisite rights to log in to
the submit node for the OSG Connect job scheduler, or to transfer data in and
out of Stash. Submit node logins are typically via Secure Shell (SSH) using a
password or a public key. We'll discuss how to connect further on. Stash access
is possible from the submit node and through Globus transfer or using HTTP to a 
public space within your Stash.

Sign in to or create an account
-------------------------------

Before enrolling in a project you must have an account in the identity
management framework. Visit the [OSG Connect web
site](<https://osgconnect.net/>), then select **Sign In/Sign Up ▸ Sign up as a
new user**. There are a few paths forward from here, but all end up with linking
your OSG Connect identity with a Globus identity. This not only provides
integrated identity service, it also enables you to begin performing data
transfers to OSG Connect very early on, with a minimal fuss, using Globus 
transfer.

### InCommon Registration

The default first step is to sign in using an InCommon ID through the CILogon
service. This allows you to enroll using your existing campus identifier and
credentials, provided that your home institution is a member of the InCommon
Federation.

Click on **Proceed** to begin this process. You'll be directed to a discovery
service which asks you what your home institution is. (If you've used CILogon
before it may already know your home institution and skip this step.) Locate
your institution in the list, or type its name to find matches. If your
institution does not appear, it may not be an InCommon member; you'll need to
register using another approach described below.

After selecting your institution in the discovery service, you'll be taken to
your own institution's local sign-in screen. You've probably used it before,
and if it looks familiar that's because it's exactly the same web site.  Sign in
using your campus credentials. When done, you'll return automatically to the
OSG Connect portal and can carry on with signup.

### Globus Registration

If your institution is not linked to CILogon, you can sign in with a Globus identity 
instead. Click on **Sign Up with Globus**. If you already have
a Globus account, click **Already a member? Sign In** to sign in now. Otherwise,
provide your name, email address, and a username and password to register a new
account. Your OSG Connect identity will piggyback from here.

| **Using InCommon/CILogon**                     | **Using Globus ID (existing)**                             | **Using Globus  (new)**                |
|------------------------------------------------|-------------------------------------------------------------------|----------------------------------------------|
| Click **Proceed**.                             | Click **Sign Up with Globus**, then **Already a member? Sign In** | Click **Sign Up with Globus**.               |
| Select your institution from the CILogon site. | Enter Globus username and password.                               | Enter Name, Email, Username, Password.       |
| Perform authentication at your institution.    | ↓                                                                 | Await validation email, use link to confirm. |
| Go to the **Link accounts **workflow.          | Go to the **Join group **workflow.                                | Go to the **Join group **workflow.           |


Link accounts
-------------

After CILogon signin, you should find yourself at
a `portal.osgconnect.net` screen that deals with Globus ID. If you don't
have a Globus account already, skip this section. Click on **Create a new
Globus account** and move on to the next section.

If you have a Globus account, go ahead and sign in. This will link your
account information together, allowing you to sign in using your InCommon ID or
any other ID that you link in the future. Otherwise, create one now.

Create a new Globus account
----------------------------------

If you need to create a new account, it's mostly straightforward. At this time
you'll only need to provide your name, email address, a username you want to
use, and a password. You will also need to validate your email address.  You
should quickly receive an email from <support@globus.org> with a subject
of **Globus - Confirm Email Address**. Wait for it now: the link in that email
will resume the registration workflow. Then wait a moment for your account to be
created. Then move to the **Join group** workflow below.

Join group
----------

You'll see some activity in the browser as you automatically join
the *osg* community, and you may need to provide some additional personal
information: a *Field of Science*, a*Department*, an *Institution*, and a *Phone
Number*.  Finally you'll land on the **Manage Identities** screen.  Move on
to **Add an SSH key**.

Generate and Add an SSH key
---------------------------

## Generating SSH-Keys

### Unix-based operating system (Linux/Mac)

On your local machine:

     mkdir ~/.ssh
     chmod 700 ~/.ssh
     ssh-keygen -t rsa

The last command will produce a prompt similar to


     Generating public/private rsa key pair.
     Enter file in which to save the key (/home/<local_user_name>/.ssh/id_rsa):

Unless you want to change the location of the key, continue by pressing enter. Now you will be asked for a passphrase. This passphrase is not necessary, but a good security measure in case your private key gets stolen. We strongly recommend that you set a passphrase:

     Enter passphrase (empty for no passphrase):
     Enter same passphrase again:

When everything has successfully completed, you the prompted will read something like: 

     Your identification has been saved in /home/<local_user_name>/.ssh/id_rsa.
     Your public key has been saved in /home/<local_user_name>/.ssh/id_rsa.pub.
     The key fingerprint is:
     ae:89:72:0b:85:da:5a:f4:7c:1f:c2:43:fd:c6:44:38 myname@mymac.local
     The key's randomart image is:
     +--[ RSA 2048]----+
     |                 |
     |         .       |
     |        E .      |
     |   .   . o       |
     |  o . . S .      |
     | + + o . +       |
     |. + o = o +      |
     | o...o * o       |
     |.  oo.o .        |
     +-----------------+

### Windows

#### Putty

Using `PuTTYgen`, follow these steps:

1. Open the `PuTTYgen` program.

2. For Type of key to generate, select SSH-2 RSA.

2. Click the Generate button.

3. Move your mouse in the area below the progress bar. When the progress bar is full, PuTTYgen generates your key pair.

4. Type a passphrase in the Key passphrase field. Type the same passphrase in the Confirm passphrase field. You can use a key without a passphrase, but this is not recommended.

5. Click the Save private key button to save the private key. Warning! You must save the private key. You will need it to connect to your machine.

6. Right-click in the text field labeled Public key for pasting into OpenSSH authorized_keys file and choose Select All.

7. Right-click again in the same text field and choose Copy.

![alt text](https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/puttygen_ssh_key.png "PuttyGen SSH Window")

#### Git Bash

Follow the instructions here to generate keys:

https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-windows

#### Other clients

If you are unsure how to generate a SSH-key with your preferred Windows SSH client, please contact the Helpdesk.

## Add SSH-key to login nodes

To add your new SSH public key to the login nodes you can use two methods:

### OSGConnect Website (Preferred)

To add your public key to the Globus Online interface:

1. Go to www.osgconnect.net

2. Go to "Update Profile"

3. Click on "Manage SSH and X.509 keys".

4. Click on "Add a New Key"

5. Give the key a name, select "SSH Public Key", and copy/paste the public key into the text box

6. Click "Add Key"

The key is now added to your profile in Globus Online. This will automatically
be added to the login nodes within a couple hours.

### Copy-Pasting

On `login01.osgconnect.net`:

     mkdir ~/.ssh
     chmod 700 ~/.ssh
     cd ~/.ssh
     touch authorized_keys

Open `authorized_keys` in your favorite text editor, i.e. `vim`, `emacs`, `nano`, `ed`, and paste the public key (contents of `/home/<local_user_name>/.ssh/id_rsa.pub` for Unix-y or output from the `PuTTYgen` window), into the file and save it. 

Finally execute:

     chmod go-w ~/
     chmod 600 ~/.ssh/authorized_keys

### ssh-copy-id (only Unix-based)

Execute: 

     ssh-copy-id <osg_connect_username>@login01.osgconnect.net

## Troubleshooting

### Permission denied (publickey)

If ssh returns the error 

     Permission denied (publickey).

This most likely means that the remote permissions are too open. Please execute:

     chmod go-w ~/
     chmod 700 ~/.ssh
     chmod 600 ~/.ssh/authorized_keys

on `login01.osgconnect.net`.

<!-- In the Manage Identities screen, you may add an SSH key to your Globus 
account. Not only will this facilitate scripted Globus file transfers, it also
will help with logins to the OSG Connect job submission server. It's not
required though; you can log in with your password, too. *We will typically skip
this in interactive workshops, and assume password use. You are encouraged to
come back and set up an SSH key later, however.*

-   If you already have an SSH key you're happy using, upload the public key
    now.

-   If you want or need to create a new SSH key and you're comfortable with an
    SSH key generation tool, you can generate a new key for OSG Connect and
    upload its public key.

-   If you're not familiar with SSH key generation, you can [use our key
    generation tool](<https://osgconnect.net/keygen>). This will create a *key
    pair* — a public key and a matching private key — and allow you to copy or
    download them.

No matter which of these options you use, you should click **Add SSH Public
Key**, then paste in your public key and submit. -->

Join a project
--------------

Congratulations! You're now signed up, and you have all the accounts that you'll
need. A critical step remains, though, before you can begin computing. You've
now joined the OSG Connect community, which gives you visibility of the various
projects associated with OSG Connect. To begin working in the facility, or using
the Stash service for file storage,  you'll need to join one (or more) of them.

You may already know what project(s) you need to join, go to the OSG Connect web
site and select the **Connect ▸ Join a Project** menu item to see a [list of
currently active projects](<http://osgconnect.net/project-summary>).(If you're a
PI, and your project is not shown, let us know. [Details on setting up a new
project](<https://confluence.grid.iu.edu/display/CON/Start+a+Project+with+OSG+Connect>) in
OSG Connect are shown elsewhere in the ConnnectBook.)

Once you've found a project to join, simply click on its name at the left of
your screen, and then on **Join Now** at the lower right. On receiving your
request, SG Connect staff will request authorization from the PI or designated
representative.* *Upon acceptance, you will automatically be granted all access
to submit node and to Stash. On the submit node, you'll be a member of a UNIX
group representing the project. And, in addition to your personal stash, the
project will have its own group stash for shared data.

For our workshops, we readily admit attendees into
the `osg.ConnectTrain` project. Even if you have no other project at this time,
we can bring you in for the short term to learn more about OSG Connect. After
the workshop, please feel free and ready to discuss creation of projects to more
closely accommodate your work.

Ready?
------

Having stepped through these procedures and joined an `osg.*` project group, you
have all the roles and access that you need to continue working. There can be
some delay for project membership approval, but aside from that access rights
are generally implemented in the OSG Connect servers within minutes. Take a
moment if you need to, then we'll move on to basic high-throughput (HT) job
submission using HTCondor.
