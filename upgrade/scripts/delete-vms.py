#!/usr/bin/env python3 
import yaml
import inquirer
from inquirer.themes import GreenPassion
from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient
from azure.identity import AzureCliCredential
from azure.mgmt.subscription import SubscriptionClient
from azure.mgmt.resource import ResourceManagementClient

def confirm_delete():
    q = [
        inquirer.Confirm("confirm", message="Are you sure you want to delete the selected resources?", default=False),
    ]
    response = inquirer.prompt(q, theme=GreenPassion())
    if not response["confirm"]:
        print("Exiting without deleting resources.")
        exit(0)

def get_delete_list(resource_type, list_of_choices):
    prompt = f"Select the {resource_type} you want to delete"
    q = [
        inquirer.Checkbox("delete", message=prompt, choices=list_of_choices)
    ]
    response = inquirer.prompt(q, theme=GreenPassion())

    return response["delete"]


def get_target(resource_type, list_of_choices):
    prompt = f"Select the {resource_type} you want to use"
    q = [
        inquirer.List("target", message=prompt, choices=list_of_choices),
    ]
    response = inquirer.prompt(q, theme=GreenPassion())
    return response["target"]

def main(): 
    # Acquire a credential object
    credential = DefaultAzureCredential() #AzureCliCredential() #DefaultAzureCredential()
    sub_client = SubscriptionClient(credential)
    subs = sub_client.subscriptions.list()

    if not subs:
        print("No subscriptions found.")
        exit(1)

    sub_dict = {}
    for sub in subs:
        sub_dict[sub.display_name] = sub.subscription_id

    target_sub = None
    if len(sub_dict) > 1:
        target_sub = get_target("subscription", sub_dict.keys())
    else:
        target_sub = subs[0].subscription_id

    # get the resource groups in the subscription
    resource_client = ResourceManagementClient(credential, sub_dict[target_sub])
    resource_groups = resource_client.resource_groups.list()

    if not resource_groups:
        print("No resource groups found.")
        exit(1)

    resource_group_dict = {}
    for rg in resource_groups:
        resource_group_dict[rg.name] = rg.id

    target_rg = None

    if len(resource_group_dict) > 1:
        target_rg = get_target("resource group", resource_group_dict.keys())
    else:
        target_rg = resource_group_dict.keys()[0]
     
    print(f"Using subscription: {target_sub}")
    print(f"Using resource group: {target_rg}")

    # get the vms in the resource group
    compute_client = ComputeManagementClient(credential, sub_dict[target_sub])
    vms = compute_client.virtual_machines.list(resource_group_name=target_rg)

    if not vms:
        print("No VMs found.")
        exit(1)

    # create a dictionary of vms where the key is vm.name and the value is the vm object
    vm_dict = {}
    for vm in vms:
        vm_dict[vm.name] = vm

    vms_to_delete = get_delete_list("virtual machine", vm_dict.keys())

    disks_to_delete = []

    print("This script will delete the selected VMs and their associated disks.")
    print("\n")
    for vm in vms_to_delete:
        disks_to_delete.append(vm_dict[vm].storage_profile.os_disk.name)
        for disk in vm_dict[vm].storage_profile.data_disks:
            disks_to_delete.append(disk.name)

    print("-------------------------------------------")
    print("Below are the VMs that will be deleted:")        
    for vm in vms_to_delete:
        print(f" - {vm}")

    print("-------------------------------------------")
    print("Below are the disks that will be deleted:")
    for disk in disks_to_delete:
        print(f" - {disk}")
    print("-------------------------------------------")
    print("\n")
    confirm_delete()

    print("Deleting VMs and disks...")
    for vm in vms_to_delete:
        print(f"Deleting VM: {vm}")
        compute_client.virtual_machines.begin_delete(resource_group_name=target_rg, vm_name=vm).result()
        print(f"Deleted VM: {vm}")

    for disk in disks_to_delete:
        print(f"Deleting Disk: {disk}")
        compute_client.disks.begin_delete(resource_group_name=target_rg, disk_name=disk).result()
        print(f"Deleted Disk: {disk}")

    print("Completed deletion of VMs and disks.")
    

if __name__ == "__main__":
    main()