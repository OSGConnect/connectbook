
Data Storage

|         | Recommended Limit| Purpose | Details|
| ------- |:----------------:| :------:| ------:|
| home    | 0-5 GB      | Meant for quick data access and not for submitting jobs.| [Home storage] (https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|
| stash   |  < 1 TB GB  | Meant for large storage and I/O of your jobs. |[Stash storage] (https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|
| public  |  < 10 GB    | Meant for sharing data and input data  transfer via HTTP|[Public Storage] (https://support.opensciencegrid.org/support/solutions/articles/12000002985-storage-solutions-on-osg-home-stash-and-public)|


Input data for your job

|    Protocol     | Data Size| command| Purpose | Details|
| --------------- |:--------:| :-----:|:--------|--------:|
| HTCondor    | < 1 GB       | transfer_input_files| Common approach to transfer your input and parameter files|Ref|
| HTTP        |  < 1 10 GB   | wget, curl or transfer_input_files  | Input files from ~/public |Ref|
| StachCache  |  < 100 GB    | Staschcp |Input files from ~/public|Ref|

Output data for your job
The solutions for data transfers from your job back to OSG Connect are more limited. At this point, we recommend that you use the built-in HTCondor file transfer mechanism (transfer_output_files=... in your job submit file).

External data transfer

|    Protocol | Data Size| Details|
| ------------|:--------:| ------:|
| scp         | < 1 GB   | Ref|
| Globus      |  > 1 GB  | Ref|

