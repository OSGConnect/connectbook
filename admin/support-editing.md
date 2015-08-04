[title]: - "Editing content (topics)"

[TOC]

# General

All Knowledge Base articles at http://support.osgconnect.net/ are maintained
in GitHub. This provides us version tracking and co-authoring capabilities,
as well as allowing us to maintain documents in a neutral format (we chose
Markdown) that can be converted to HTML or to any other presentation.


# Reviewing content

For reviewing content, it's _critical_ to view the [Support Knowledge Base][kbase]
(formerly the ConnectBook) *as a user or customer would see it*.  

If you are a help desk *agent*, meaning you have advanced privileges in the
system for supporting users and organizing content, your default view is
the agent view.  To see the *customer portal*, choose an article or category
in the Solutions tab ([kbase]).  In the upper right hand corner is a small box with an arrow
which will take you to the user's view of the article.

Alternatively you can visit the site in another browser, or using your browser's "Incognito",
"Private Browsing", etc. mode.

[kbase]: http://support.opensciencegrid.org/solution/categories

At the end of any article that you want to edit, you'll find a statement like this one:

> This page was updated on Jul 01, 2015 at 12:33 from [example.md][example-link].

[example-link]: https://github.com/OSGConnect/connectbook/blob/master/example.md

This is a link directly to the source document in GitHub.  Click it, or copy its link
and paste into another browser, and you'll see the document rendered by GitHub.  Take
note: this view is probably slightly different from what you see in the Knowledge Base.
This is because there's a difference between regular Markdown (with extensions) and
the "[GitHub-Flavored Markdown][gfm]" that GitHub uses.  Don't worry how it looks
in GitHub.

[gfm]: https://help.github.com/articles/github-flavored-markdown/

# Editing content in the browser

Once you see the document in GitHub, find the "edit" button in the action bar:
![editbar][editbar]

[editbar]: https://raw.githubusercontent.com/OSGConnect/connectbook/master/admin/github-edit.jpg

The edit button is the pencil icon near the right edge. Click it, and you'll enter
a text editor where you can edit the Markdown.

You can directly edit Markdown text if you're comfortable with it.  If you'd like
a different experience, you also can copy/paste the entire document into one of the
Markdown editors shown below, make your edits, and then copy/paste it back to Github.
When you finish, add a commit changelog note and click "Commit changes".  Your updates
will be published to the Knowledge Base within 15-20 seconds.

# Editing content on your computer

You also can edit content on your own computer.  This requires a working understanding
of git which we won't get into here.  Just clone the connectbook repository:

  $ git clone --recursive https://github.com/OSGConnect/connectbook

(The `--recursive` option is critical for getting copies of all tutorials.)

Make your changes, then commit and push from your computer.  Again, changes
will be published within 15-20 seconds, provided that no merge was necessary
at the time you pushed.  (If one was, there may be further delay.)


# About Markdown

You can learn more about Markdown here:

* http://daringfireball.net/projects/markdown/
* http://whatismarkdown.com/
* http://www.squarespace.com/display/ShowHelp?section=Markdown


Tools for editing Markdown:

* Web
  * http://daringfireball.net/projects/markdown/dingus
  * http://dillinger.io/
  * https://stackedit.io/
* MacOS
  * http://mouapp.com/
  * http://texts.io/


