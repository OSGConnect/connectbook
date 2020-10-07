[title]: - "Policies for Using OSG via OSG Connect Submit Servers"

Access to OSG Connect resources is contingent on compliance with the below and with any requests from OSG staff to change practices that cause issues for OSG Connect systems and/or users. **Please contact us if you have any questions! We can often help with exceptions to default policies and/or identify available alternative approaches to help you with a perceived barrier.**

As the below do not cover every possible scenario of potentially disruptive practices, OSG staff reserve the right to take any necessary corrective actions to ensure performance and resource availability for all OSG Connect users. This may include the hold or removal of jobs, deletion of user data, deactivation of accounts, etc. In some cases, these actions may need to be taken without notifying the user.

1. **By using OSG Connect, users are expected to follow the OSG Connect [acceptable use policy](https://github.com/opensciencegrid/osgconnect-portal-markdowns/blob/master/signup_content/signup_modal.md)**, which includes appropriate scope of use and common user security practices. OSG Connect is only available to individuals affiliated with a US-based academic, government, or non-profit organization, or with a research project led by an affiliated sponsor.

2. **Users can have up to 10,000 jobs queued, without taking additional steps**, and should submit multiple jobs via a single submit file, according to our online guides. Please write to us if you’d like to easily submit more!

3. **Do not run computationally-intensive or persistent processes on the submit servers.** Exceptions include software compilation and data management tasks (transfer to/from the login nodes, directory creation, file moving/renaming, untar-ing, etc.). Software testing should be executed from within submitted jobs, where job scheduling provides functionality to the user without compromising performance of the submit servers. Please contact us to discuss appropriate features and options (rather than running scripts) to automate job submission, throttling, resubmission, or ordered execution (e.g. workflows). OSG staff reserve the right to kill any tasks running on the login nodes, in order to ensure performance for all users.

4. **Data Policies**: *OSG Connect filesystems are not backed up and should be treated as temporary (“scratch”-like) space for active work, only*, following [OSG Connect policies for data storage and per-job transfers](https://support.opensciencegrid.org/support/solutions/articles/12000002985-introduction-to-data-management-on-osg-connect). Some OSG Connect storage spaces are truly ‘open’ with data available to be downloaded publicly. Of note:
	 - Users should keep copies of essential data and software in non-OSG locations, as OSG staff reserve the right to remove data at any time in order to ensure and/or restore system availability, and without prior notice to users.
	 - Proprietary data, HIPAA, and data with any other privacy concerns should not be stored on any OSG Connect filesystems or computed in OSG. Similarly, users should follow all licensing requirements when storing and executing software via OSG Connect submit servers. (See “Software in OSG Connect”.) 
	 - Users should keep their /home directory privileges restricted to their user or group, and should not add ‘global’ permissions, which will allow other users to potentially make your data public.
	 - User-created ‘open’ network ports are [disallowed](https://github.com/opensciencegrid/security/blob/master/docs/policy/OSG_Connect_Login_Server_Open_Port_Policy.md), unless explicitly permitted following an accepted justification to support@osgconnect.net. (If you’re not sure whether something you want to do will open a port, just get in touch!)

5. The following actions may be taken automatedly or by OSG staff to stop or prevent jobs from causing problems. Please contact us if you’d like help understanding why your jobs were held or removed, and so we can help you avoid problems in the future.
	 - **Jobs using more memory or disk than requested** may be automatically held (see Optimize your Job Throughput for tips on requesting the ‘right’ amount of job resources in your submit file).
	 - **Jobs that have executed more than 30 times without completing** may be automatically held (likely because [they’re too long](https://support.opensciencegrid.org/support/solutions/articles/5000632058-is-the-open-science-grid-for-you-) for OSG).
	 - **Jobs that have been held more than 14 days** may be automatically removed.
	 - **Jobs queued for more than three months** may be automatically removed.
	 - **Jobs otherwise causing known problems** may be held or removed, with prior notification to the user.
	 - **Held jobs may also be edited to prevent automated release/retry**
	 - NOTE: in order to respect user email clients, job holds and removals do not come with specific notification to the user, unless configured by the user at the time of submission using HTCondor’s ‘notification’ feature.
