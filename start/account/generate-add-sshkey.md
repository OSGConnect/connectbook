[title]: - "Generate SSH Keys and Activate Your OSG Login"

[TOC]

## Overview

OSG Connect requires SSH-key-based logins. You need to follow a two-step process to set up the SSH key to your account. 

1. Generate a SSH key pair.  

2. Add your public key to the submit host by uploading it to your OSG Connect user profile (via the OSG Connect website).

After completing the process, you can log in from a local computer (your laptop or desktop) to the OSG Connect submit `login.osgconnect.net` using either 
ssh or an ssh program like Putty -- see below for more details on logging in. 

NOTE: Please do not edit the authorized keys file on the submit host (login.osgconnect.net).

## Step 1: Generating SSH Keys

We will discuss how to generate a SSH key pair for two cases: 

* "Unix" systems (Linux, Mac) and certain, latest versions of Windows
* Older Windows systems

Please note: The key pair consist of a private key and a public key. You will upload the 
public key to OSG Connect, but you also need to keep a copy of the private key to log in!  
You should keep the private key on machines that you have 
direct access to, i.e. your local computer (your laptop or desktop).

### Unix-based operating system (Linux/Mac) or latest Windows 10 versions

Open a terminal on your local computer and run the following commands: 

     mkdir ~/.ssh
     chmod 700 ~/.ssh
     ssh-keygen -t rsa

The last command will produce a prompt similar to

     Generating public/private rsa key pair.
     Enter file in which to save the key (/home/<local_user_name>/.ssh/id_rsa):

Unless you want to change the location of the key, continue by pressing enter.
Now you will be asked for a passphrase. Enter a passphrase that you will be 
able to remember and which is secure:

     Enter passphrase (empty for no passphrase):
     Enter same passphrase again:

When everything has successfully completed, the output should resemble the
following: 

     Your identification has been saved in /home/<local_user_name>/.ssh/id_rsa.
     Your public key has been saved in /home/<local_user_name>/.ssh/id_rsa.pub.
     The key fingerprint is:
     ...

The part you want to upload is the content of the `.pub` file (~/.ssh/id_rsa.pub)

### Windows, using Putty to log in

If you can connect using the `ssh` command within the Command Prompt (Windows 10 build version 1803 and later), please follow the Mac/Linux directions above. If not, 
continue with the directions below. 

1. Open the `PuTTYgen` program.  You can download `PuttyGen` 
here: [PuttyGen Download Page](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html), 
scroll down until you see the `puttygen.exe` file. 

2. For Type of key to generate, select RSA or SSH-2 RSA. 

2. Click the "Generate" button.

3. **Move your mouse in the area below the progress bar.**
When the progress bar is full, PuTTYgen generates your key pair.

4. Type a passphrase in the "Key passphrase" field. Type the same passphrase in the "Confirm passphrase" field. You 
can use a key without a passphrase, but this is not recommended.

5. Click the "Save private key" button to save the private key. **You must save the private key.** You will need it to connect to your machine.

6. Right-click in the text field labeled "Public key for pasting into OpenSSH authorized_keys file" and choose Select All.

7. Right-click again in the same text field and choose Copy.

![alt text](https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/puttygen_ssh_key.png "PuttyGen Window")

## Step 2: Add the public SSH key to login node

To add your public key to the OSG Connect log in server: 

1. Go to www.osgconnect.net and sign in with your Globus ID. 

2. Go to "Update Profile".

3. Click on "Manage SSH and X.509 keys" - it's a small link under your Globus ID 
in the "Identity" column. 

4. Click on "Add a New Key".

5. Give the key a name, select "SSH Public Key", and copy/paste the public key into the text box. The expected key is a single line, with three fields looking something like `ssh-rsa ASSFFSAF... user@host`. If you used the first set of key-generating 
instructions it is the content of `~/.ssh/id_rsa.pub` and for the second (using PuTTYgen), it is the content from step 7 above.

6. Click "Add Key"

The key is now added to your profile in the OSG Connect website. This will automatically
be added to the login nodes within a couple hours.

## Logging In

After following the steps above to upload your key and it's been a few hours, you should be able to log in to OSG Connect. 

### For Mac, Linux, or newer versions of Windows

Open a terminal and type in: 

    ssh <your_osg_connect_username>@login.osgconnect.net

It will ask for the passphrase for your ssh key (if you set one) and then you 
should be logged in. 

### For older versions of Windows

On older versions of Windows, you can use the [Putty program](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) to log in. 

1. Open the `PutTTY` program. If necessary, you can download PuTTY from the website here [PuTTY download page](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).

2. Type "login.osgconnect.net" as the hostname.

3. In the left hand menu, click the "+" next to "SSH" to expand the menu.

4. Click "Auth" in the "SSH" menu.

5. Click "Browse" and specify the private key file you saved in step 5 above.

6. Click "Open" and provide your Globus ID (do not include @globusid.org) and passphrase when prompted to do so.

![alt text](https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/putty_ssh.png "PuPTTYen SSH Window")


## Getting Help 

For assistance or questions, please email the OSG User Support team  at <mailto:user-support@opensciencegrid.org> or visit the [help desk and community forums](http://support.opensciencegrid.org).

