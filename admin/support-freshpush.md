[title]: - "How knowledge base synchronization works"

[TOC]

# General

All Knowledge Base articles at http://support.osgconnect.net/ are maintained
in GitHub. This provides us version tracking and co-authoring capabilities,
as well as allowing us to maintain documents in a neutral format (we chose
Markdown) that can be converted to HTML or to any other presentation.

# Date flow

Here is a high-level view of the data flow:

![architecture](https://raw.githubusercontent.com/OSGConnect/connectbook/master/admin/connectbook-high-level.png)

(This image is a bit outdated: in place of `cron`, we should have `GitHub webhook`.
This will be updated.)

The piece of this diagram that concerns us right now is at the lower left
corner.  Inside the `connectbook` repository are three files:

* [freshpush](https://github.com/OSGConnect/connectbook/blob/master/update/freshpush)
* [freshpush.ini](https://github.com/OSGConnect/connectbook/blob/master/update/freshpush.ini)
* [update.sh](https://github.com/OSGConnect/connectbook/blob/master/update/update.sh)

When GitHub receives an update to any of the `tutorial-` repos, or to the `connectbook`
repo, it sends a signal via webhook to a WSGI program running on `www.osgconnect.net`.
(Specifically this WSGI is at `/web/prod/ci-connect.net/github.wsgi`.) That in turn
runs the `update.sh` script.  `Update.sh` `git pull`s all pending changes to
`connectbook` and all its submodules (the `tutorial-` repos), then runs `freshpush`
to send updates to Freshdesk.  `Update.sh` receives as arguments the filenames
of any files that `github.wsgi` knows have changed, and passes these on to `freshpush`.

`Freshpush` loads the configuration data in `freshpush.ini`.  The main items of
interest in `freshpush.ini` are the mappings in the `[filemap]` section:

  [filemap]
  acknowledgOSG.md = 5000640421
  client-install-rp.md = 5000640325
  client-install-user.md = 5000640326
  ...
  tutorial-namd/README.md = 5000634378
  ...
  admin/support-freshpush.md = 5000641634
  ...
  
The numbers on the right are _article numbers_ in Freshdesk. They are used to construct
a URL for a Freshdesk API call.  That API call is to update the article's content, and
the content is HTML that `freshpush` generates from the Markdown data in the corresponding
filename on the left-hand side.  Thus any changes to the `acknowledgeOSG.md` file in the
`connectbook` repo are turned into HTML, and become part of the new content that is
pushed upstream to Freshdesk.  Likewise, any Markdown change in the `README.md` file
in the `tutorial-namd` (sub-)repo becomes part of article `5000634378`.  So long as the
changed files' filenames can be detected by `github.wsgi`, this entire procedure takes
downwards of 15 seconds from the time you `git push` your changes.

# Specifics of editing articles

There are several things to keep in mind as you write Markdown content for Freshdesk
publication.

* The title of the article in Freshdesk is generated on the fly from metadata in the Markdown content.
* We use "real" Markdown, not [GitHub-Flavored Markdown (GFM)](https://help.github.com/articles/github-flavored-markdown/).
* There are several Markdown extensions available, notable Tables and Table of Contents.

Let's look at each point.

## Article titling

There are three ways that `freshpush` can infer a title for your article:

1. from the `[title]` "tag"
2. from the first heading in the article
3. from the file name

### `[title]`

The first is preferable.  It (ab)uses the link by reference notation:

  \[linkname\]: url "alt text for url"

to stand as invisible metadata within the document.  "title" is the magic value for
"linkname".  Inside your document, the first thing that `freshpush` sees that matches
this pattern will be used as the article's title:

  \[title\]: - "Article title"

Note that "-" is used for the URL.

### first heading

If no `[title]:` appears in the article, then `freshpush` finds the first heading
in the article that is denoted by some number of leading `#` symbols.  The entire
heading (after the hash marks) becomes the article title.

### file name

Finally, of neither previous method is successful, then the _local_ file name of the
article -- e.g., `support-freshpush.md` -- becomes the article name.  However, the
`.md` at the end is removed, and all hyphens in the remainder become spaces:
`support freshpush`.


## Markdown flavor

This is a requirement of the software libraries we use for publication, and a good idea for
portability.  GFM is GitHub-specific.  Do not assume that if it looks fine in GitHub, it
will be OK everywhere! The most common portability problem is that GFM allows "fenced" block
quotations:

  Regular text
  ```
  blockquote content
  ```
  More regular text

Markdown does not allow this.  It requires just a simple indentation for block quoting:

  Regular text
  
    blockquote content
  
  More regular text

The second most common problem also has to do with block quotes: in Markdown, you need
a blank line between your regular content and the block-quoted content.  Not including
one **will** mess up your rendering.

## Markdown extensions

Lastly, we support both the table of contents extension for Markdown and the tables
extension.  The table of contents extension is very straightforward.  It simply notes
all headings in the markdown content, and turns them into a table of contents with
internal anchor links to the associated section.  This ToC is inserted wherever the
original document contains the simple line:

  \[TOC\]

Upper case is required.

The table extension allows you to construct simple tables.  By way of example:

  | President | Year | Vice President |
  | Washington | 1789 | Adams |
  | Adams | 1797 | Jefferson |
  | Jefferson | 1801 | Burr, Clinton |
  | Madison | 1809 | Clinton, Gerry |

| President | Year | Vice President |
| Washington | 1789 | Adams |
| Adams | 1797 | Jefferson |
| Jefferson | 1801 | Burr, Clinton |
| Madison | 1809 | Clinton, Gerry |

_Note that GitHub does not support tables, and your edits **will** look wrong in GitHub._
