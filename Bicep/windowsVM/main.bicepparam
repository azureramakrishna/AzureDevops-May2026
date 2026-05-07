using 'main.bicep'

param storageAccountName = 'saanvikitsa2026'
param location = 'eastus'
param virtualNetworkName = 'saanvikit-vnet-01'
param virtualNetworkAddressPrefix = ['10.0.0.0/16']
param subnetName = 'saanvikit-snet-01'
param subnetAddressPrefix = '10.0.0.0/24'
param VMName = 'saanvikit-vm-01'
param VMSize = 'Standard_DS1_v2' // 1 vCPU, 3.5 GB RAM
param adminUsername = 'azureuser'
param adminPassword = 'P@ssw0rd1234!' // Note: In production, use secure methods to handle credentials
