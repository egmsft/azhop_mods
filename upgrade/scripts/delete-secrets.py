#!/usr/bin/env python3 
import yaml
import inquirer
from inquirer.themes import GreenPassion
from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient
from azure.identity import AzureCliCredential
from azure.mgmt.subscription import SubscriptionClient
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.keyvault import KeyVaultManagementClient
from azure.keyvault.secrets import SecretClient

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
        inquirer.List("target", message=prompt, choices=list_of_choices)
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
        target_sub = list(sub_dict.keys())[0]

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
        target_rg = list(resource_group_dict.keys())[0]
         
    print(f"Using subscription: {target_sub}")
    print(f"Using resource group: {target_rg}")

    kvclient = KeyVaultManagementClient(credential, sub_dict[target_sub])

    vaults = kvclient.vaults.list_by_resource_group(resource_group_name=target_rg)

    if not vaults:
        print("No Key Vaults found.")
        exit(1)
        
    vault_dict = {}
    for vault in vaults:
        vault_dict[vault.name] = vault

    if len(vault_dict) > 1:
        kv_target = get_target("key vault", vault_dict.keys())
    else:
        kv_target = list(vault_dict.keys())[0]

    print(f"Using key vault: {kv_target}")

    # get the secrets in the key vault
    secrets = kvclient.secrets.list(resource_group_name=target_rg, vault_name=kv_target)

    if not secrets:
        print("No secrets found.")
        exit(1)

    secret_dict = {}
    for secret in secrets:
        secret_dict[secret.name] = secret

    secrets_to_delete = get_delete_list("secret", secret_dict.keys())
    secretClient = SecretClient(vault_dict[kv_target].properties.vault_uri, credential)

    print("This script will delete the selected secrets.")
    print("\n")
    print("-------------------------------------------")
    print("Below are the secrets that will be deleted:")
    for secret in secrets_to_delete:
        print(f" - {secret}")
    print("-------------------------------------------")
    print("\n")
    confirm_delete()

    print("Deleting secrets...")
    for secret in secrets_to_delete:
        print(f"Deleting secret: {secret}")
        secretClient.begin_delete_secret(secret).result()
        print(f"Deleted secret: {secret}")
    print("Completed deletion of secrets.")
    

if __name__ == "__main__":
    main()