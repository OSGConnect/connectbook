#!/usr/bin/env python

from Pegasus.DAX3 import *
import sys
import os

base_dir = os.getcwd()
query_filename = "HLA.txt"
database_dir = "/stash/public/blast/database/nt.5-30-2014"

# Create a abstract dag
dax = ADAG("blastn-nt")

# Add executables to the DAX-level replica catalog
blast_ex = Executable(name="blast_exe.bash", arch="x86_64", installed=False)
blast_ex.addPFN(PFN("file://" + base_dir + "/blast_exe.bash", "local"))
blast_ex.addProfile(Profile(Namespace.PEGASUS, "clusters.size", 1))
dax.addExecutable(blast_ex)


# Add param file to the DAX-level replica catalog
query_file = File(query_filename)
query_file.addPFN(PFN("file://" + base_dir + "/" + query_filename, "local"))
dax.addFile(query_file)


# add jobs, one for each database file

for dbase_filename in os.listdir(database_dir):
     if dbase_filename.endswith(".tar.gz"):
          dbase_filename = dbase_filename.replace(".tar.gz", "");
          dbase_file = File(dbase_filename)
          blast_job = Job(name="blast_exe.bash")
          out_filename = query_filename + "." + dbase_filename + ".output"
          out_file = File(out_filename)
          #print dbase_filename, query_filename, out_filename
          blast_job.addArguments(query_file, dbase_file, out_file)
          blast_job.uses(query_file, link=Link.INPUT)
          blast_job.uses(out_file, link=Link.OUTPUT)
          dax.addJob(blast_job)

# Write the DAX to stdout
f = open("dax.xml", "w")
dax.writeXML(f)
f.close()



