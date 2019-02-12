[title]: - "Accessing data - when to use which tool?"

Job Input Data
--------------

There are multiple solutions for accessing input data, and which solution to use
depends on factors such as data size, if the same data is used by multiple jobs, and
if you prefer POSIX-like file access or not. Here is a list of options, and links
to details:

- **HTCondor file transfers** - This is by far the simplest solution, and can be
  used for small to moderate file sizes (up to 1 GB total).
  [Details](/solution/articles/5000639787)

- **Accessing Stash over HTTP** - This is a good solution for moderate to large
  filesizes (0 - 100 GB), 
  [Details](/solution/articles/5000639798)

- **StashCache** - This has similar characteristics as the Stash solution, but
  with the additional benefit of transparent data caching making the solution
  even more attractive if you have many job using the same data inputs.
  [Details](/solution/articles/12000002775)


Job Output Data
---------------

The solutions for data transfers from your job back to OSG Connect are more limited.
At this point, we recommend that you use the built-in HTCondor file transfer mechanism
(*transfer_output_files=...* in your job submit file).

