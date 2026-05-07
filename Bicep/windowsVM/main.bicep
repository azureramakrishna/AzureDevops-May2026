param storageAccountName string
param location string
param virtualNetworkName string
param virtualNetworkAddressPrefix array
param subnetName string
param subnetAddressPrefix string
param VMName string
param VMSize string
param adminUsername string
@secure()
param adminPassword string

var tags = {
  environment: 'DEV'
  project: 'azure-infrastructure'
}
var networkSecurityGroupName = 'saanvikit-nsg-01'
var networkInterfaceName = 'saanvikit-nic-01'
var publicIPAddressName = 'saanvikit-pip-01'

// Create a storage account
resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  tags: tags
}

// Create a virtual network
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: virtualNetworkName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: virtualNetworkAddressPrefix
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }
    ]
  }
}

// create the NSG
resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'RDP'
        properties: {
          description: 'Allow RDP traffic'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'HTTP'
        properties: {
          description: 'Allow HTTP traffic'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 200
          direction: 'Inbound'
        }
      }
    ]
  }
}

// Create a public IP address
resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}


// Create the NIC
resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: networkInterfaceName
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetwork.properties.subnets[0].id
          }
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
  }
}

// Create Windows VM 
resource windowsVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: VMName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: VMSize
    }
    osProfile: {
      computerName: VMName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: '${VMName}-osdisk' // saanvikit-vm-01-osdisk
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
  }
}



