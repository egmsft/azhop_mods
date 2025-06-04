kv_rg_name = ""
kv_name = ""

# set to the output of this command: az account show -o json | jq -r .tenantId
tenant_id = ""

# set to the output of this command: az resource list -n <ubuntu-deployer-vm-name> -g <rg-of-ubuntu-deployer-vm> --query [*].identity.principalId --out tsv
mi_obj_id = ""
