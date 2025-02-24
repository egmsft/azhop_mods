# How to Drain a Cluster for Scheduled Maintenance

`dedicated_time` is a feature in PBS that allows administrators to reserve a specific time period for exclusive use of the cluster. During this period, no new jobs will be scheduled, and running jobs can be drained to prepare the cluster for maintenance or other administrative tasks.

## Configure `dedicated_time`

You define dedicated time by adding a time slot in the file <sched_priv directory>/dedicated_time. In azhop, this file can be found in: 

`/var/spool/pbs/sched_priv/dedicated_time` 

A time slot should include a start date, start time and an end date and end time.  

The time slots in the `dedicated_time` file follow the following format:

`<start date> <start time> <end date> <end time>`

expressed as

`MM/DD/YYYY   HH:MM   MM/DD/YYYY   HH:MM`

Below is a sample time slot: 
```
#Dedicated time for maintenance
03/15/2025 12:00 03/15/2025 15:30
```

## Load the `dedicated_time` configuration 
The dedicated time file is read on startup and HUP. Consequently, for the scheduler to be aware of the defined maintenance window, you must first find the PID of the scheduler

```bash

[root@ip-0A020004 sched_priv]$ ps -elf | grep pbs_sched
5 S root       41736       1  0  80   0 - 120274 core_s 13:47 ?       00:00:00 /opt/pbs/sbin/pbs_sched  # this is the scheduler process and the PID is 41736
0 S root      120623   47019  0  80   0 -  3054 -      15:38 pts/0    00:00:00 grep --color=auto pbs_sched

```

Once you've obtained the PID, you can HUP the scheduler so that it will load the configuration for the maintenance window:

`kill -HUP <pbs_sched PID>`

For the example above, the command will look like this:

```bash
 [root@ip-0A020004 sched_priv]$ kill -HUP 41736  
```
## Disable CycleCloud autoscaling 

CycleCloud is not aware of the `dedicated_time` setting in PBS. Therefore, the autoscaling hook must be disabled to allow the cluster to drain appropriately. If not disabled, CycleCloud will continue to bring up VMs because it detects jobs in the queued state.

To disable CycleCloud autoscaling, follow these steps:

<ol>

<li><strong>Use the qmgr command to disable the autoscale hook:</strong></li>

```bash
qmgr -c 's h autoscale enabled=false'
```

<li><strong>Verify that the change was applied by using the qmgr command to list the hook:</strong></li>

```bash
qmgr -c 'l h autoscale'
```
You should see the `enabled` property set to false. 

</ol> 

By disabling the autoscaling hook, you ensure that no new VMs are brought up. **However, this also means that no VMs are brought down.** You can manually scale down nodes as needed. 

## Post-Maintenance Activities 

Once the maintenance window has passed, you will need to re-enable the hook so that CycleCloud can autoscale nodes for the jobs that are queued: 

```bash
qmgr -c 's h autoscale enabled=true'
```

Although it is not necessarily required, you can also remove the entry of the defined time slot in the `dedidated_time` file and HUP the scheduler to clean up the configuration. You can also do this if your maintenance activities completed earlier than anticipated to allow jobs to run as soon as maintenance activities are complete. 

## Notes

<ul>
<li>

You should apply this configuration a couple of days before the scheduled maintenance window. For example, if you allow jobs to run for 10 days, you can apply this configurations 11 days earlier than the scheduled outage to ensure all jobs are complete during the maintenance window.     
</li>
<li>

Refer to the **[Altair PBS Professional Administrator's Guide](https://2021.help.altair.com/2021.1/PBSProfessional/PBSAdminGuide2021.1.pdf)** for more information about dedicated time
</li>
<li>

Refer to the **[Altair PBS Professional Hooks Guide](https://2021.help.altair.com/2021.1.2/PBS%20Professional/PBSHooks2021.1.2.pdf)** for more information about hooks 
</li>
</ul>



