# Description

AzHop supports multi-region clusters, allowing users to deploy and manage applications across different regions. However, it is important to note that, due to limitations of PBS, multi-region name resolution is not supported if AzHop is deployed with PBS as the scheduler. This means that hostnames cannot be resolved across different regions within the cluster. However, there are situations where an application may need to communicate back to its submit host. If the submit host originated from a different region, this communication is no longer possible. Consequently, these hooks are a possible workaround to enable the communication between the execution hosts and the submit hosts in the multi-region setup. 

## Getting the IP Address of the Submit Host
The `append_ip_hook.py` hook is responsible for identifying the submit host, getting the submit host's IP address, and appending that information to the job's list of environment variables. The hook is designed to be executed when a user submit's the job. 

### Adding the hook 
In order to add this hook to your deployment, you will need to perform these steps as root: 
<ol>
  <li><strong>Copy the hook script</strong>

  As root, cd to `/root` and copy the `append_ip_hook.py` script </li>
  <li><strong>Create the hook</strong>
  
  Use the `qmgr` command to create the hook: 
  
  ```bash
   qmgr -c "create hook append_ip_hook event=queuejob"
  ```
  and import the script to the hook: 
  ```bash
  qmgr -c "import hook append_ip_hook application/x-python default append_ip_hook.py"
  ```

  </li>
  <li><strong>Verify the hook is enabled</strong></li>

  Use the `qmgr` command to list the hook: 
  ```bash
  qmgr -c "l h append_ip_hook"
  ```
  You should see the `enabled` property set to true. If it is not set, you can enable the hook with `qmgr` 
  ```bash
  qmgr -c 's h append_ip_hook enabled=true'
  ```
  <li><strong>Test the hook</strong></li>

  As `clusteradmin` (or another cluster user), you can try submitting jobs to test the hook. Included in this directory are two simple job submissions scripts that only run the sleep command. For example, you can use the `sleep_excl.sh` in the `test` directory script to submit a job: 
  ```bash
  qsub sleep_excl.sh 
  ```
  After the job is submitted, you can query the job properties and you will find that the `Variable_List` will include two additional variables that have been configured by the hook - `AZHOP_SUBMIT_HOST` and `AZHOP_SUBMIT_HOST_IP`: 
  ```bash
  qstat -x <jobid>
  ```   

</ol>

## Adding Submit Host to /etc/hosts of execution nodes
The `update_etc_hosts.py` hook is a prologue and epilogue hook that is used to update the `/etc/hosts` file with the IP address of the submit host. It retrieves the IP address by querying for the variables that were previously set by `append_ip_hook.py`. The modifications to `/etc/hosts` are removed at job completion.

### Adding the hook 
In order to add this hook to your deployment, you will need to perform these steps as root: 
<ol>
  <li><strong>Copy the hook script</strong></li>

  As root, cd to `/root` and copy the `update_etc_hosts.py` script </li>

  
  <li><strong>Create the hook</strong></li>

  Use the `qmgr` command to create the hook: 
  
  ```bash
   qmgr -c 'create hook update_etc_hosts_hook event="execjob_prologue,execjob_epilogue"'
  ```
  and import the script to the hook: 
  ```bash
  qmgr -c "import hook update_etc_hosts_hook application/x-python default update_etc_hosts_hook.py"
  ```

  <li><strong>Verify the hoook is enabled</strong></li>

  Use the `qmgr` command to list the hook: 
  ```bash
  qmgr -c "l h update_etc_hosts_hook"
  ```
  You should see the `enabled` property set to true. If it is not set, you can enable the hook with `qmgr` 
  ```bash
  qmgr -c 's h update_etc_hosts_hook enabled=true'
  ```

  <li><strong>Test the hook</strong></li>

  Since this hook modifies the `/etc/hosts` file, it is crucial that this hook only execute when the job is not sharing its execution hosts with other jobs. Consequently, it has logic included to verify that the `place` statement does not have `shared` set. There are two simple jobs in the `test` directory that test the logic of this hook: 

  <ul>
  <li> 

  `sleep.sh` - A sleep job that allows other jobs to run on the same execution hosts.  
  </li>
  <li>
  
  `sleep_excl.sh` - A sleep job that uses the default attributes to define how the job is placed. In the case of AzHop, the jobs are set up to not share execution hosts by default. 
  </li>
  </ul>

  By submitting both jobs, after the execution nodes are available and allocated the job, you will find that ***only*** the execution hosts for the `sleep_excl.sh` job will include a new entry in their `/etc/hosts` file for the submit host defined by the `append_ip_hook.py`. The entry will be removed after the job completes. 

</ol>

## Notes

<ul>
<li>

While testing you can enable/disable the hooks by updating the `enabled` property with `qmgr`. 
</li>
<li>

If any modifications are made to the scripts, you can re-run the `import` command from `qmgr` to upload the changes. 
</li>

<li>

Refer to the **[Altair PBS Professional Hooks Guide](https://2021.help.altair.com/2021.1.2/PBS%20Professional/PBSHooks2021.1.2.pdf)** for more information about hooks 
</li>
</ul>