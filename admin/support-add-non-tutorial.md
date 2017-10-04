[title]: - "Add a topic to the knowledge base"

[TOC]

# General

The Connect documentation is kept in the [ConnectBook repository
in GitHub][connectbook].  Most documents are in Markdown format,
and are published to the [support site][support] when changed.

[connectbook]: https://github.com/OSGConnect/connectbook/tree/master/
[support]: https://support.opensciencegrid.org/

To add a new document to the Knowledge Base, several steps must be
taken:

1. *create the document* and add it to the `connectbook` repo
2. *create a template* article in Freshdesk
3. *map* the new file in the `freshpush.ini` file.

For discussion's sake, let's say we want to create an article named
"Contacting us during a natural disaster."  We'll explain each of the
above steps in detail below.  This guide assumes that you're using the
GitHub web UI for all changes.  (You can alternatively use the git
client, but you'll need to translate directions accordingly.)

# Create the document

Begin by creating a new file in GitHub. For our example, we might name
it `contacting-disaster.md`.  The file name is not significant.

The file might begin as follows:

	[title]: - "Contacting us during a natural disaster"

	[TOC]

	# What events are natural disasters?

The `[title]` line sets the article's title.  If you don't have one of
these, then the first headline will be used instead.  That's not usually
what you want.

Continue editing until your document is as you want it.  Remember that
it's a Markdown document, and its filename should end in `.md`.  When
you're done, save/commit the new file.


# Create a template article

To publish our Markdown content into Freshdesk, we need an article
to send it to.  Unfortunately there's no way (at present) to have
`freshpush` just make one.  We need to make one directly in the
Freshdesk Agent environment, then record its article number.

To begin, go to the category that you want your new article to
appear in.  Let's say you want to add an article in the 
Additional Support & Training -> Education and Training
category.

Click the folder, then click "add solution":

![add solution screenshot](https://raw.githubusercontent.com/OSGConnect/connectbook/master/admin/add-solution-2.jpg)

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

To make your new tutorial active, you'll need to add a line to the
`[filemap]` section of this file.  Just click over there and edit the
file in GitHub, then commit -- it's simple enough, there's no need to
get fancy.  Just add another row mapping `tutorial-folding/README.md`
to the article number for the new article.  Above, we pretended it was
5000641902, so it would look like this:

	[filemap]
	...
	client-using.md = 5000621976
	client-whatis.md = 5000640327
	communicate.md = 5000632439
	contact-information.md = 5000634383
	...
	

Commit this change.  It will be sent immediately to the server that
handles publishing from GitHub to Freshdesk.  You should see the update
within a minute.


# Test

That's all there is.  The next change committed to
`tutorial-folding/README.md` should be published to Freshdesk
straightaway, so commit a change to the file and test it out!


# Images and "attachments"

If you need images or other "attachments" in your document, just make
them part of the `connectbook` repository.  You can put them into a
subdirectory or not.  Your Markdown content will refer to the file's
location using a specially constructed URL.  For example, the URL to
the screenshot above is:

	https://raw.githubusercontent.com/OSGConnect/connectbook/master/admin/add-solution-2.jpg

Everything _up to and including_ `admin` is the special construction.
The folder and file names following `admin` are relative to the
`connectbook` repository root.
