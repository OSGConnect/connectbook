[title]: - "Removing Content From the Helpdesk"

[TOC]

## Remove or hide the FreshDesk article

Go to the Freshdesk portal, click on the solutions option on the left, and 
find the relevant article. Click "Edit" in the top right and then either delete 
the article (button on the left) or save it as a draft. 

## Remove the `freshpush.ini` entry

In the [connectbook](https://github.com/OSGConnect/connectbook) repository, edit the `update/freshpush.ini` file by 
either removing the referenced page or tutorial or commenting it out (if you 
think it will be updated and restored later). 

## Remove the source

### For non-tutorials

Go to the [connectbook](https://github.com/OSGConnect/connectbook) repository and 
either remove the source `.md` file for the guide, or move it to the `archive/` 
folder. Commit changes and push to the central Github repository. 

### For tutorials

If you want to revisit the tutorial later, change its name on GitHub to something like 
`TOREVIEW-tutorial-name`. 

If you want to completely remove the tutorial: 
- optional: download a zip copy first
- delete it from Github
- remove its submodule from the connectbook repository by following these instructions: 
[removing a git submodule](https://gist.github.com/myusuf3/7f645819ded92bda6677)

