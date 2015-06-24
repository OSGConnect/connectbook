[title]: - "Accessing Stash via the web"

Making data accessible over HTTP
--------------------------------

All user accounts on OSG-Connect have a directory that is automatically web accessible.  This directory is located at
~/data/public.  To make a file or directory accessible, copy it to this directory or a subdirectory of this directory
and give files permissions of 644 and directories permissions of 755.  E.g. :

	$ cd ~/osg-stash_http
	$ cp random_words ~/data/public
	$ chmod 644 ~/data/public/random_words
	$ cp -a test_directory ~/data/public/test_directory
	$ chmod 755 ~/data/public/test_directory
	$ chmod 644 ~/data/public/test_directory/test_file


Manually Accessing Stash using HTTP
-----------------------------------

All the contents of the public directory are made available over HTTP.  Go to http://stash.osgconnect.net/+username to view 
the files and directory that you just made available in the previous section.  You can also use wget to retrieve the files, 
e.g:

	$ cd ~/osg-stash_http
	$ mkdir tmp
	$ cd tmp
	$ wget --no-check-certificate http://stash.osgconnect.net/+username/test_directory/test_file

