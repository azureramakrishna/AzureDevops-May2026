@description('Deployment location for project resources')
param location string = 'eastus'

@description('Admin username for the VMs')
param adminUsername string = 'azureuser'

@description('Admin password for the VMs - use a strong password when deploying')
@secure()
param adminPassword string

@description('Virtual machine size for both VMs')
param vmSize string = 'Standard_B1s'

@description('Tags to apply to all resources')
param tags object = {
  project: 'VNetPeeringTopology'
  environment: 'dev'
}

var vnet1Name = 'VNET-01'
var vnet2Name = 'VNET-02'
var vnet1AddressPrefix = '10.0.0.0/24'
var vnet1Subnet1Prefix = '10.0.0.0/25'
var vnet1Subnet2Prefix = '10.0.0.128/25'
var vnet2AddressPrefix = '10.0.1.0/24'
var vnet2Subnet1Prefix = '10.0.1.0/25'
var vnet2Subnet2Prefix = '10.0.1.128/25'
var vm1Name = 'VM01'
var vm2Name = 'VM02'

resource nsgVnet1Snet1 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: 'nsg-vnet01-snet01'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowVNetInbound'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationPortRange: '*'
        }
      }
      {
        name: 'DenyInternetInbound'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourceAddressPrefix: 'Internet'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

resource nsgVnet1Snet2 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: 'nsg-vnet01-snet02'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowVNetInbound'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationPortRange: '*'
        }
      }
      {
        name: 'DenyInternetInbound'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourceAddressPrefix: 'Internet'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

resource nsgVnet2Snet1 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: 'nsg-vnet02-snet01'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowVNetInbound'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationPortRange: '*'
        }
      }
      {
        name: 'DenyInternetInbound'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourceAddressPrefix: 'Internet'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

resource nsgVnet2Snet2 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: 'nsg-vnet02-snet02'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowVNetInbound'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationPortRange: '*'
        }
      }
      {
        name: 'DenyInternetInbound'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourceAddressPrefix: 'Internet'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

resource vnet1 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: vnet1Name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet1AddressPrefix
      ]
    }
    subnets: [
      {
        name: 'snet-01'
        properties: {
          addressPrefix: vnet1Subnet1Prefix
          networkSecurityGroup: {
            id: nsgVnet1Snet1.id
          }
        }
      }
      {
        name: 'snet-02'
        properties: {
          addressPrefix: vnet1Subnet2Prefix
          networkSecurityGroup: {
            id: nsgVnet1Snet2.id
          }
        }
      }
    ]
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: vnet2Name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet2AddressPrefix
      ]
    }
    subnets: [
      {
        name: 'snet-01'
        properties: {
          addressPrefix: vnet2Subnet1Prefix
          networkSecurityGroup: {
            id: nsgVnet2Snet1.id
          }
        }
      }
      {
        name: 'snet-02'
        properties: {
          addressPrefix: vnet2Subnet2Prefix
          networkSecurityGroup: {
            id: nsgVnet2Snet2.id
          }
        }
      }
    ]
  }
}

resource vnet1ToVnet2Peer 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-07-01' = {
  name: '${vnet1.name}/VNET01-to-VNET02'
  properties: {
    remoteVirtualNetwork: {
      id: vnet2.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

resource vnet2ToVnet1Peer 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-07-01' = {
  name: '${vnet2.name}/VNET02-to-VNET01'
  properties: {
    remoteVirtualNetwork: {
      id: vnet1.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

var vnet1Snet1SubnetId = '${vnet1.id}/subnets/snet-01'
var vnet2Snet1SubnetId = '${vnet2.id}/subnets/snet-01'

resource nicVm1 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: 'nic-vm01'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig-vm01'
        properties: {
          subnet: {
            id: vnet1Snet1SubnetId
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource nicVm2 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: 'nic-vm02'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig-vm02'
        properties: {
          subnet: {
            id: vnet2Snet1SubnetId
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm1 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: vm1Name
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vm1Name
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicVm1.id
        }
      ]
    }
  }
}

resource vm2 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: vm2Name
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vm2Name
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicVm2.id
        }
      ]
    }
  }
}

output vnet1Id string = vnet1.id
output vnet2Id string = vnet2.id
output vm1Id string = vm1.id
output vm2Id string = vm2.id
