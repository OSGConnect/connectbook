[title]: - "Generate and add an SSH key to your account"


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

The key is now added to your profile in Globus Online. We will add to the login nodes within a couple hours

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

