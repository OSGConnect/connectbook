[title]: - "Add a tutorial to the knowledge base"

[TOC]

# General

Tutorials are separate repositories in GitHub, so that each can be
cloned independently on demand.  (This is the main thing that the
`tutorial` command does when you use it to set up a tutorial.)  Each
tutorial has, at minimum, a `README.md` file that describes the
tutorial, the steps to be taken, and the lessons learned.

To add this tutorial file to the Knowledge Base, several steps
must be taken:

1. add the tutorial as a *submodule* to the `connectbook` repo
2. add a *webhook* to the repository on GitHub
3. *create a template* article in Freshdesk
4. *map* the README.md file in the `freshpush.ini` file.

For discussion's sake, let's say we've already created a tutorial named
`tutorial-folding`, that it has a `README.md` file and all its requisite
materials, and that it works with the `tutorial` command already.  We'll
explain each of the above steps in detail below.

# Add the tutorial as a submodule

Since it's a tutorial, `tutorial-folding` exists as a completely
separate repository in GitHub.  This makes sense: changes to one
tutorial rarely affect others, and users are usually not interested in
_all_ tutorials -- just a handful.  But for documentation's sake we
want to track all tutorials with the `connectbook`, which serves as an
"umbrella" for all the Help Desk documentation.  We do that by making
each tutorial a _submodule_, which means that the `connectbook` repo has
a reference to the tutorial repo, and can incorporate changes by pulling
from the submodule.  Each of the tutorials is incorporated by reference
like this.  [You can see how it looks in GitHub][ghtutorials].

[ghtutorials]: https://github.com/OSGConnect/connectbook/tree/master/tutorials

Adding a new submodule is easy, but it must be done from the git
client -- it can't be done in the GitHub web UI.  Let's say that
our new tutorial is hosted on GitHub at
https://github.com/OSGConnect/tutorial-folding :

	$ git clone --recursive https://github.com/OSGConnect/connectbook
	$ cd connectbook/tutorials
	$ git submodule add https://github.com/OSGConnect/tutorial-folding
	$ git commit tutorial-folding
	$ git push

That's it! The new tutorial is now part of `connectbook`, incorporated
by reference.  Future pulls and clones will copy it alongside the other
tutorials.


# Add a webhook

We've established `tutorial-folding` as a part of the overall
connectbook repository, but what happens when someone pushes changes
to the tutorial?  Those changes still belong to the `tutorial-folding`
repo, and that repo doesn't know about `connectbook`.  We need to create
some trigger so that when changes arrive for `tutorial-folding`, they
cause the connectbook material to be updated on the Help Desk.

That trigger is called a _webhook_, and we set it up in GitHub.  All
our webhooks look the same!  The `connectbook` repo has one, and
each tutorial repo has one too, and each of them is identical.
You can load the webhook settings for `tutorial-folding` here:
https://github.com/OSGConnect/tutorial-folding/settings/hooks

Here's what that screen looks like for `tutorial-R`:

![Webhook Setup](https://raw.githubusercontent.com/OSGConnect/connectbook/master/admin/webhook.jpg)

To add a webhook for `tutorial-folding`, click *Add Webhook*.  In the
new screen, paste https://ci-connect.net/github.wsgi into the *Payload
URL* input.  Ensure that the *content type* is _application/json_.  No
*secret* is needed.  Finally, for the "which events" radio, select
*just the push event*.  Then click *Add webhook* to save your changes.

Now, whenever a change to this repo is received by GitHub, it will
notify https://ci-connect.net/github.wsgi and an update to the Help Desk
will be triggered (using the `freshpush` program).


# Create a template article

To publish our Markdown content into Freshdesk, we need an article
to send it to.  Unfortunately there's no way (at present) to have
`freshpush` just make one.  We need to make one directly in the
Freshdesk Agent environment, then record its article number.

To begin, go to the category that you want your new article to
appear in.  For a tutorial, this is likely the [HTC on OSG][htccategory]
category.

[htccategory]: http://support.opensciencegrid.org/solution/categories/5000161171

Choose a folder, then click "add solution":

![add solution screenshot](https://raw.githubusercontent.com/OSGConnect/connectbook/master/admin/add-solution.jpg)

Give the article any title at all, it doesn't matter.  Don't add any
content either.  Just save it, and note the number that appears in
the URL bar.  For example, I just got this:

http://support.opensciencegrid.org/solution/articles/5000641902-hfghf

That `5000641902` is the article number.  Save it for the next step.
Leave the article.


# Map the file in freshpush.ini

There's still one more piece to put in place, though.  For `freshpush`
to be able to update a document in Freshdesk, it needs to know the
article number for each document it should care about.  We give it that
through a mapping table that's kept in the [freshpush.ini][freshpush-ini]
file.

[freshpush-ini]: https://github.com/OSGConnect/connectbook/blob/master/update/freshpush.ini

To make your new tutorial active, you'll need to add a line to
the `[filemap]` section of this file.  Just click over there and
edit the file in GitHub, then commit -- it's simple enough, there's
no need to get fancy.

	[filemap]
	...
	tutorial-R/README.md = 5000634364
	tutorial-ScalingUp-R/README.md = 5000639781
	tutorial-VinaAutodock/README.md = 5000634379
	...

That's a snippet of the `[filemap]` section.  Just add another row
mapping `tutorial-folding/README.md` to the article number for the new
tutorial.  Above, we pretended it was 5000641902, so it would look
like this:

	[filemap]
	...
	tutorial-R/README.md = 5000634364
	tutorial-ScalingUp-R/README.md = 5000639781
	tutorial-VinaAutodock/README.md = 5000634379
	...
	tutorial-folding/README.md = 5000641902

Commit this change.  It will be sent immediately to the server that
handles publishing from GitHub to Freshdesk.


# Test

That's all there is.  The next change committed to
`tutorial-folding/README.md` should be published to Freshdesk
straightaway, so commit a change to the file and test it out!
