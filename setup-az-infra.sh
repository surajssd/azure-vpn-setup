#!/usr/bin/env bash
# This script will create RG, VM and setup network so that vpn server can run without problems.

set -euo pipefail

export index="1"
export resource_group="vpn-setup-${index}"
export location="centralindia"
export vm_name="vpnserver"
export user_name="azuser"
export ssh_key="~/.ssh/id_rsa.pub"
export dns_name="vpn-server-${index}"

az group create --name "${resource_group}" --location "${location}"

az vm create \
    --resource-group "${resource_group}" \
    --size Standard_B2s \
    --name "${vm_name}" \
    --image canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
    --location "${location}" \
    --public-ip-address-dns-name "${dns_name}" \
    --admin-username "${user_name}" \
    --ssh-key-values "${ssh_key}"

# Open ssh port 22 and 51820
az vm open-port \
    --port 22,51820 \
    --resource-group "${resource_group}" \
    --name "${vm_name}"

URL="${dns_name}.${location}.cloudapp.azure.com"
echo $URL

echo "ssh ${user_name}@${URL}"
