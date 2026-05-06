# Login to Azure
Connect-AzAccount

# Variables
$resourceGroup = "RG-Demo-Automation"
$location = "EastUS"
$vnetName = "DemoVNet"
$subnetName = "DemoSubnet"
$nsgName = "DemoNSG"
$vmName = "DemoVM"
$publicIpName = "DemoPublicIP"
$nicName = "DemoNIC"

# Create Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create Virtual Network & Subnet
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24"

$vnet = New-AzVirtualNetwork `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -Name $vnetName `
  -AddressPrefix "10.0.0.0/16" `
  -Subnet $subnetConfig

# Create NSG Rule (Allow SSH)
$nsgRule = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-SSH" `
  -Protocol "Tcp" `
  -Direction "Inbound" `
  -Priority 1000 `
  -SourceAddressPrefix "*" `
  -SourcePortRange "*" `
  -DestinationAddressPrefix "*" `
  -DestinationPortRange 22 `
  -Access "Allow"

# Create NSG
$nsg = New-AzNetworkSecurityGroup `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -Name $nsgName `
  -SecurityRules $nsgRule

# Create Public IP
$publicIp = New-AzPublicIpAddress `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -Name $publicIpName `
  -AllocationMethod "Dynamic"

# Create NIC
$nic = New-AzNetworkInterface `
  -Name $nicName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -SubnetId $vnet.Subnets[0].Id `
  -PublicIpAddressId $publicIp.Id `
  -NetworkSecurityGroupId $nsg.Id

# VM Credentials
$cred = Get-Credential

# Create VM Configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize "Standard_B1s" |
    Set-AzVMOperatingSystem -Linux -ComputerName $vmName -Credential $cred |
    Set-AzVMSourceImage -PublisherName "Canonical" `
                        -Offer "UbuntuServer" `
                        -Skus "18.04-LTS" `
                        -Version "latest" |
    Add-AzVMNetworkInterface -Id $nic.Id

# Create VM
New-AzVM `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -VM $vmConfig