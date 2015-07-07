[title]: - "What is the Connect Client?"

[TOC]

# Introducing the Connect Client

The [Campus Connect Client][client] is a bridge from your campus to
OSG's national grid infrastructure.  It comprises a set of tools for
linking a campus research computing cluster to a CI Connect instance
such as OSG Connect.  It enables users of a campus facility to submit
jobs into the Open Science Grid without leaving their own institutional
working environment.  Connect Client gives you an interface for job and
data transfer and synchronization with the OSG Connect server, and an
interface for remote job management.

If you are an experienced HTCondor user, you may prefer to use OSG
Connect's login server directly.  But many campus researchers already
have a comfortable home on their local computational resource, and
no need to interact directly with HTCondor.  Connect Client targets
these users, making it easy to extend local resources with the full
national grid.

OSG works with resource providers to set up Connect Client access at
the system level.  If the `connect-client` package or module is already
installed at your site, you can [start using it today][using].  If not,
we can [work with your site operations team][install-rp] to provide it,
or you can [install it for yourself][install-user].

[client]: https://github.com/CI-Connect/connect-client
[using]: /support/solutions/articles/5000621976
[install-rp]: /support/solutions/articles/5000640325
[install-user]: /support/solutions/articles/5000640326
