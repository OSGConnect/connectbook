[title]: - "Is the Open Science Grid for You?"


The [Open Science Grid][osg] is a nationally-funded consortium of computing resources 
at more than one hundred institutional partners that, together, offer a strategic 
advantage for computing work that can be run as numerous short tasks. 


|   		| **Ideal jobs!** | **Still very advantageous** | **Less-so, but maybe** | 
|:----------|:--------------|:--------------|:--------------|
| Expected Throughput, per user		|	1000s concurrent cores |	100s concurrent cores |	let's discuss! |
| CPU		|	1			|	< 8			|	> 8 (or MPI)|
| Walltime	| 	< 12 hrs*	|	< 24 hrs*	|	> 24 hrs	|
| RAM		| 	< few GB	|	< 10s GB	|	> 10s GB	|
| Input		| 	< 500 MB**	|	< 10 GB**	|	> 10 GB		|
| Output	| 	< 1GB**		|	< 10 GB**	|	> 10 GB		|
| Software	| pre-compiled binaries, containers | Most other than -> | Licensed software, non-Linux |

*or checkpointable

**per job; you can work with a large data set on OSG if it can be split into pieces

For problems that can be run as many independent jobs, as in the first two columns 
of the table above, the OSG provides practically-unlimited resources as 
compared to local computing systems, with the possibility 
of having hundreds or even thousands of computer cores in use at once. Access 
to this amount of computing capacity can transform the types of questions that researchers 
are able to tackle. 

Some examples of work that have been a good fit for the OSG and benefited from 
using its resources include: 

- MRI image analysis
- DNA read mapping and other bioinformatic pipelines
- parameter sweeps
- Monte Carlo methods

Learn more by requesting an account here: [OSG Connect Sign-Up][account-request]

[osg]: https://opensciencegrid.org/
[account-request]: https://osgconnect.net/signup
