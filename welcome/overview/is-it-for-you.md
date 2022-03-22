[title]: - "Computation on the Open Science Pool"


The [OSG][osg] is a nationally-funded consortium of computing resources 
at more than one hundred institutional partners that, together, offer a strategic 
advantage for computing work that can be run as numerous short tasks that can execute 
independent of one another. For researchers
who are not part of an organization with their own pool in the OSG, we offer the 
[Open Science Pool (OSPool)](https://opensciencegrid.org/about/open_science_pool/), with dozens 
of campuses contributing excess computing capacity in support of open science. The OSPool is available 
for US-affiliated research projects and groups via the [OSG Connect](https://www.osgconnect.net/) service, which the documentation 
on this site is specific to.

Learn more about the services provided by the OSG that can support your HTC workload: 

<a href="https://www.youtube.com/watch?v=5FMAFxROGv0"><img alt="OSG Introduction" src="https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/osg-intro-video-screenshot.png" width="360" height="204"></a>

For problems that can be run as numerous independent jobs (a high-throughput approach) and have requirements
represented in the first two columns 
of the table below, the significant capacity of the OSPool can transform the types of 
questions that researchers are able to tackle. **Importantly,
many compute tasks that may appear to not be a good fit _can_ be modified in simple ways 
to take advantage, and we'd love to discuss options with you!** 

|   		| **Ideal jobs!** | **Still advantageous** | **Maybe not, but get in touch!** | 
|:--------|:--------------|:--------------|:--------------|
| Expected Throughput: | 1000s concurrent jobs | 100s concurrent jobs | let's discuss! |
| **Per-Job Requirements** |  |  |  |
| CPU	cores	|	1			|	< 8			|	> 8 (or MPI)|
| GPUs		|	0			|	1			|	> 1 |
| Walltime	| 	< 10 hrs*	|	< 20 hrs*	|	> 20 hrs (not a good fit)	|
| RAM		| 	< few GB	|	< 40 GB	|	> 40 GB	|
| Input		| 	< 500 MB	|	< 10 GB	|	> 10 GB**		|
| Output	| 	< 1GB		|	< 10 GB	|	> 10 GB**		|
| Software	| pre-compiled binaries, containers | Most other than ---> | Licensed software, non-Linux |

\* or checkpointable

\** per job; you can work with a multi-TB dataset on the OSPool if it can be split into pieces!

Some examples of work that have been a good fit for the OSPool and benefited from 
using its resources include: 

- image analysis (including MRI, GIS, etc.)
- text-based analysis, including DNA read mapping and other bioinformatics
- hyper/parameter sweeps
- Monte Carlo methods and other model optimization

**Learn more and chat with a Research Computing Facilitator by [signing up for OSG Connect][account-request]**


## Resources to Quickly Learn More

**Introduction to OSG the Distributed High Throughput Computing framework** from the annual [OSG User School](https://opensciencegrid.org/outreach/):

[<img src="https://raw.githubusercontent.com/OSGConnect/connectbook/master/images/Intro_OSG_Video_Thumbnail.png" width="500">](https://www.youtube.com/embed/vpJPPjoQ3QU)

**[Full OSG User Documentation](https://support.opensciencegrid.org/support/home)** including our [Roadmap to HTC Workload Submission](12000081596-roadmap-to-htc-workload-submission-via-osg-connect)

**[OSG User Training materials](https://support.opensciencegrid.org/support/solutions/articles/12000084444-osg-user-training)** . Live training sessions are advertised/open to those with active accounts on OSG Connect.


**Learn more and chat with a Research Computing Facilitator by [signing up for OSG Connect][account-request]**

[osg]: https://opensciencegrid.org/
[account-request]: https://osgconnect.net/signup
