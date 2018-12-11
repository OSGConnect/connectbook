[title]: - "Editing a tutorial in the knowledge base"

[TOC]

Because tutorials are separate GitHub repositories that are included in the connectbook repo as submodules, the correct workflow for editing/updating a tutorial is to edit the main (upstream) repository and then pull those changes into the connectbook tutorial submodule.  For example, if we are editing the “quickstart” tutorial, proceed as follows:

1)  Clone the main/upstream tutorial repository locally.

	$ git clone https://github.com/OSGConnect/tutorial-quickstart.git
	$ cd tutorial-quickstart

Make your changes, commit them, and then push those changes to GitHub.

	$ git push origin master

2)  Next, update the tutorial-quickstart submodule in the connectbook repo.  Start by first cloning the connectbook repository locally (recursively to include submodules).  Make sure not to clone it inside the tutorial-quickstart repo from step 1.

	$ cd ~
	$ git clone --recursive https://github.com/OSGConnect/connectbook

Then, update the submodule from the upstream remote repo.  Commit the update and push to GitHub.

	$ cd connectbook
	$ git submodule update --remote tutorials/tutorial-quickstart
	$ git add tutorials/tutorial-quickstart
	$ git commit -m “Pulling in changes from upstream OSGConnect/tutorial-quckstart repo”
	$ git push origin master	

That's it.  Now check the tutorial article in Freshdesk to make sure that any updates to the README file have propagated.


