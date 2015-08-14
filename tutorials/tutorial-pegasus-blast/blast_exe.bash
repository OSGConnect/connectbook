#!/bin/bash

echo "System Information"
echo -n "HOSTNAME=  "
hostname
echo -n "UnixName=  "
uname -a
echo -n "OSsystem=   "

if [ -f /etc/lsb-release ]; then
        osysname=$(lsb_release -s -d)
elif [ -f /etc/debian_version ]; then
        osysname="Debian $(cat /etc/debian_version)"
elif [ -f /etc/redhat-release ]; then
        osysname=`cat /etc/redhat-release`
else
        osysname="$(uname -s) $(uname -r)"
fi

echo " $osysname " 


echo OSG_WN_TMP: $OSG_WN_TMP
echo OSG_JOB_CONTACT: $OSG_JOB_CONTACT
echo OSG_DATA: $OSG_DATA
echo OSG_APP: $OSG_APP
echo OSG_GRID: $OSG_GRID
echo OSG_HOSTNAME: $OSG_HOSTNAME
echo OSGVO_CMSSW_Path: $OSGVO_CMSSW_Path
echo OSG_SITE_NAME: $OSG_SITE_NAME
echo OSGVO_CPU_MODEL: $OSGVO_CPU_MODEL
echo LD_LIBRARY_PATH: $LD_LIBRSRY_PATH


query_file=$1
database=$2
output_file=$3



wget http://stash.osgconnect.net/public/blast/database/nt.5-30-2014/$database.tar.gz
tar -xzf $database.tar.gz
ls
source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/5.6.2/init/bash
module load blast
blastn -query $query_file -db $database -out $output_file 
  #blastn -query $query_file -db $database -out $output_file -evalue 0.001 -outfmt 6 -best_hit_score_edge 0.05 -best_hit_overhang 0.25 -perc_identity 98.0
ls

