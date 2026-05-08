Azure & AzureDevops with AI :
============================

timings - 9am 1hr
mon - fri
labs 
documentation & recordings
interiews

qa
qa


Agenda:
======

1.⁠ ⁠Azure free trail 

    Use incognito browser 

    NEW EMAIL
    NEW MOBILE Number
    NEW CC/DC


2.⁠ ⁠Azure portal demo

    All services
    Microsoft learn
    Azure documentation

3.⁠ ⁠Azure pricing 

abcd.com -> onpremises -> azure cloud 

abcd.com application architecture 

1 windows server
1 linux server 
1 storage 
1 sql db 
1 loadbalancer 
1 firewall


Agenda:
=======

1. Azure RBAC (Role based access control)

    - Owner         : He will get full access to manage all resources, also ability to assign Azure RBAC 
    - Contributor   : He will get full access to manage all resources, but he will not have ability to assign Azure RBAC
    - Reader        : view only access 

    saanvikitapril2026@outlook.com

SAANVIK IT - 20 resources  (vm, db,network,storage, monitoring, backup, security, loadbalancing, etc)

virtual network 

Network team --> network category



2. Azure heirarchy

    Management Group            to manage mulptilple subscriptions RBAC and Policies 
        \_
            Subscription        to start using azure services
                \_
                    Resource Group      Logical grouping of resources 
                        \_
                            Resources   the resources which we consume like vm, storage, etc



Azure Policies:
==============


Azure Tags: Tags are name/value pairs that enable you to categorize resources and view consolidated billing
=========

Enterprise Shared subscription 

volvo 
    Project: volvo

Mercedes
    Project: Mercedes

Maruthi

Tata


IP Address: Internet protocal
==========

IPv4 and IPv6

IPv4 - 32 bit
IPv6 - 128 bit


IPv4   0.0.0.0 - 255.255.255.255

Class A     0.0.0.0         127.255.255.255
            10.0.0.0   to  10.255.255.255                   

Class B     128.0.0.0       191.255.255.255
            172.16.0.0  to 172.31.255.255

Class C     192.0.0.0       223.255.255.255
            192.168.0.0 to 192.168.255.255

Class D     224.0.0.0       239.255.255.255

Class E     240.0.0.0       255.255.255.255



CIDR:
====

10.0.0.0/16     = 2^32-16 = 2^16 = 65536 (5 reserved IPs) = 65531

172.16.0.0/24   = 2^32-24 = 2^8 = 256 (5 reserved IPs) = 251

10.0.0.0/25     = 2^32-25 = 2^7 = 128 (5 reserved IPs) = 123

10.0.0.0/27     = 2^32-27 = 2^5 = 32 (5 reserved IPs) = 27

10.0.0.0/29     =               = 8 (5 reserved IPs) = 3

10.0.0.0/30     =               = 4 (5 reserved IPs) 


10.0.0.0/29 = 8

10.0.0.0    Network address.
10.0.0.1    Reserved by Azure for the default gateway.
10.0.0.2    Reserved by Azure to map the Azure DNS IP addresses to the virtual network space.
10.0.0.3    Reserved by Azure to map the Azure DNS IP addresses to the virtual network space.
10.0.0.4
10.0.0.5
10.0.0.6
10.0.0.7    Network broadcast address.

VM1 - NIC1 - 10.0.0.4
VM2 - NIC2 - 10.0.0.6


Azure Virtual Network: VNET
=====================

10.0.0.0/24 = 256 = 251

10.0.0.0    Network address.
10.0.0.1    Reserved by Azure for the default gateway.
10.0.0.2    Reserved by Azure to map the Azure DNS IP addresses to the virtual network space
10.0.0.3    Reserved by Azure to map the Azure DNS IP addresses to the virtual network space
10.0.0.4
10.0.0.5
10.0.0.6
-
-
-
-
10.0.0.254
10.0.0.255    Network broadcast address

200 VMs = 256



Agenda:
======
1. Azure virtualmachine 

    Availability options:

        *** choose while creating the VMs

        - Availability set
        - Availability zone



2. How to host applications on the VM 

    Windows VM:

        - IIS web server (port 80) (Internet information services)
        - RDP Port 3389

    Linux VM:

        - Apache2 web server (80)

            sudo apt update -y
            sudo apt install apache2 -y 
            sudo systemctl status apache2 

            /var/www/html -> index.html

        - SSH Port 22

    <projectname>-<region>-<environment>-<resource>-##
    saanvikit-eastus-dev-vm-01



Agenda:
======

1. Azure storage account types

   1. Standard general-purpose v2       Azure Blob Storage , Azure Queue Storage, Azure Table Storage, and Azure Files
   2. Premium block blobs               Blob Storage (including Data Lake Storage1)
   3. Premium file shares               Azure Files
   4. Premium page blobs                Page blobs only

2. Azure Storage service types 

    - Blob (Binary large object)
        Page blob
        Append blob
        Block blob
    - Azure Fileshare
    - Queues
    - Table 

3. Azure storage redundency options

    1. LRS Locally redundant storage: 3 copies in primary region
    2. ZRS Zone-redundant storage: 3 copies in different AZ in primary region
    3. GRS Geo-redundant storage: 6 copies, 3 copies in primary and 3 copies in secondary region. 
    4. RA-GRS Read Access geo redundant storage: 6 copies, 3 copies in primary and 3 copies in secondary region & read access to secondery region
    5. GZRS Geo-zone-redundant storage: 6 copies, 3 copies in primary ZRS mode and 3 copies in secondary in LRS mode
    6. RA-GZRS Read Access Geo-zone-redundant storage: 6 copies, 3 copies in primary ZRS mode and 3 copies in secondary in LRS mode & read access to the secondary region


4. Azure storage endpoints

    Storage service	                Endpoint
    ===============                 ========
    Blob Storage	                https://<storage-account>.blob.core.windows.net
    Static website (Blob Storage)	https://<storage-account>.web.core.windows.net
    Data Lake Storage	            https://<storage-account>.dfs.core.windows.net
    Azure Files	                    https://<storage-account>.file.core.windows.net
    Queue Storage	                https://<storage-account>.queue.core.windows.net
    Table Storage	                https://<storage-account>.table.core.windows.net

5. Access tier

    Hot tier - 
    An online tier optimized for storing data that is accessed or modified frequently. The hot tier has the highest storage costs, but the lowest access costs.

    Cool tier - 
    An online tier optimized for storing data that is infrequently accessed or modified. Data in the cool tier should be stored for a minimum of 30 days. The cool tier has lower storage costs and higher access costs compared to the hot tier.

    Cold tier - 
    An online tier optimized for storing data that is rarely accessed or modified, but still requires fast retrieval. Data in the cold tier should be stored for a minimum of 90 days. The cold tier has lower storage costs and higher access costs compared to the cool tier.

    Archive tier - 
    An offline tier optimized for storing data that is rarely accessed, and that has flexible latency requirements, on the order of hours. Data in the archive tier should be stored for a minimum of 180 days.

    Smart tier - 
    Smart tier automatically moves your data between the hot, cool, and cold access tiers based on usage patterns, optimizing your costs for these access tiers automatically. To learn more, see Optimize costs with smart tier.

6. Azure Blob Storage lifecycle management

    Lifecycle management offers a rich, rule-based policy for general purpose v2 and blob storage accounts. Use the policy to transition your data to the appropriate access tiers or expire at the end of the data's lifecycle. A new or updated rule can take up to 24 hours to go into effect.

    ** these rules are applicable only to the Blob storage not for remaining storage service types. 

7. Hosting static website on the Azure storage.


Agenda:
======

    Azure Fileshare - NFS
    ==============

    SMB Port - 445

    shared access signature (SAS):
    =============================
     SAS is a URI that grants restricted access rights to Azure Storage resources. You can provide a shared access signature to clients who should not be trusted with your storage account key but whom you wish to delegate access to certain storage account resources. By distributing a shared access signature URI to these clients, you grant them access to a resource for a specified period of time.

    Resource Locks:
    ===============
    CanNotDelete means authorized users can read and modify a resource, but they can't delete it.

    ReadOnly means authorized users can read a resource, but they can't delete or update it. Applying this lock is similar to restricting all authorized users to the permissions that the Reader role provides.


    Azure CDN - Content delivey network
    =========
        A content delivery network is a distributed network of servers that can efficiently deliver web content to users. A content delivery network store cached content on edge servers in point of presence (POP) locations that are close to end users, to minimize latency.


Azure Virtual Network connectivities:
====================================
1. Azure VNET Peering 
    ** IPs shouldn't be overlapping 

    VNET1 - 10.0.0.0/23         10.0.0.0 - 10.0.0.255
                                10.0.1.0 - 10.0.1.255

    VNET2 - 10.0.0.0/24         10.0.0.0 - 10.0.0.255


    VNET1 - 10.0.0.0/24         10.0.0.0 - 10.0.0.255

    VNET2 - 10.0.1.0/24         10.0.1.0 - 10.0.1.255

    Global VNET Peering        - VNET1 EastUS & VNET2 Central India
    Regional VNET Peering      - VNET1 EastUS & VNET2 EastUS

2. Site to Site VPN

3. Express Route 

4. Network Security Group (NSG)

    - Subnet (Best practice)
    - NIC 

5. NIC 
6. Public IP
7. Azure Bastion:
    Azure Bastion is a fully managed PaaS service that provides secure and seamless RDP/SSH connectivity to your virtual machines directly over TLS from the Azure portal, or via the native SSH or RDP client already installed on your local computer.


Agenda:
------
How many ways i can create resources in azure 

1. Azure Portal

2. Azure powershell

        Login-AzAccount / Connect-AzAccount
        Login-AzAccount -TenantID <TENANTID> -SubscriptionID <SUBSCRIPTIONID>
        Logout-AzAccount / Disconeect-AzAccount

        New-AzResourceGroup -Name test -Location EastUS
        Get-AzResourceGroup
        Remove-AzResourceGroup -Name test -Force

3. Azure CLI
        az login --tenant <TENANTID>

        az logout
        az group create --name test --location 
        az group list 
        az group delete -n test -y

IAC - Infrastructure as a code

4. ARMTemplates
5. Bicep
6. Terraform


Agenda:
======

Microsoft Entra ID (Formarly Azure Active directory - AAD) - PAAS managed service / cloud managed identity and access management


Onprem DC - Windows Server - ADDS (Actice directory domain services)

Active directory: Identity and access management

SSPR 
RBAC
MFA - Mulit factor authentication

create a user:
=============

$passwordProfile = @{
    Password = "Azure@123"
    ForceChangePasswordNextSignIn = $true
}

New-MgUser `
    -DisplayName "krishna" `
    -UserPrincipalName "krishna@rarmakrishnaad.onmicrosoft.com" `
    -MailNickname "krishna" `
    -AccountEnabled:$true `
    -PasswordProfile $passwordProfile


Agenda:
======
1. App registration (Service principal)

Application (client) ID:
eadd93c7-e6d2-49a7-9d62-b8be08b54c8d

Directory (tenant) ID:
459865f1-a8aa-450a-baec-8b47a9e5c904

Secret:
VAa8Q~1XQzCzV0OV6nwD67Y1zt8ZMtyKLsu.sb7C

SubscriptionID:
2e28c82c-17d7-4303-b27a-4141b3d4088f

az login --service-principal --username eadd93c7-e6d2-49a7-9d62-b8be08b54c8d --password VAa8Q~1XQzCzV0OV6nwD67Y1zt8ZMtyKLsu.sb7C --tenant 459865f1-a8aa-450a-baec-8b47a9e5c904


2. Azure Keyvault 

az group create --name "myResourceGroup" --location "EastUS"

az keyvault create --name "saanvikit-kv-001" --resource-group "myResourceGroup" --enable-rbac-authorization true


3. Managed Identity



az keyvault secret show --vault-name saanvikit-kv-001 --name windows-vm-password --query value -o tsv


4. Private endpint:
A private endpoint is a network interface that uses a private IP address from your virtual network. This network interface connects you privately and securely to a service that's powered by Azure Private Link. By enabling a private endpoint, you're bringing the service into your virtual network.


Agenda:
======

1. Azure App services (WebApp): 
    
    Azure App Service is a platform that lets you run web applications,mobile back ends, and RESTful APIs without worrying about managing the underlying infrastructure.

    Azure VM --> IAAS --> IIS -> host application
    WebApp   --> PAAS 


az webapp up --sku F1 --name saanvikit001 --os-type Windows
az webapp up --os-type Windows

custom domain:

www.pioneer.com --> https://saanvikit001.azurewebsites.net/



2. Logic App
3. Function App 


Loadbalancers:
=============
1. Azure loadbalancer

    - OSI layer 4 (Transport layer)
    - Types of Loadbalancer
       - Public loadbalancer
       - internal loadbalancer 
    - BackendPool 
        - VM 
        - VMSS
    - Health Probe (Monitor the health of backendpool)
    - Loadbalancing rules
    - Supports only Http traffic
    

2. Application Gateway
    - OSI Layer 7 (Application Layer)
    - WAF (Web application firewall)
    - Path based routing 
    - Multisite hosting 
    - SSL Offloading (Https -> Http)
    - Session offinity 
    - Backend Pool
        - VM
        - VMSS
        - IP address or FQDN (google.com)
        - App services 
    - Support Http & Https

3. Traffic Manager
    Azure Traffic Manager is a DNS-based traffic load balancer that distributes traffic to your public-facing applications across global Azure regions.


4. Front door
    Application Gateway + traffic manager + CDN




Agenda: Monitoring
======

Azure Monitor - Infrastructure monitoring 
Application Insights - Application Monitoring 

Azure SQL:
=========
1. Azure SQL Database - PAAS 

2. Azure SQL Managed Instance - IAAS 
3. SQL Server on Azure VM - IAAS 



IAC:
===
1. Automated way of deploying the resources 

    Project - Architecture - 
    100 VM's 

JSON Data types:
===============
    - String
    - Number
    - Object
    - Array
    - Boolean
    - Null


Azure Bicep:
===========


Terraform:
=========

ARMTemplates                             Azure Bicep                                Terraform
============                             ===========                                ==========
1. IAC                                   1. IAC                                     1. IAC
2. Specific to Azure                     2. Specific to Azure                       2. Open source (Azure, AWS, GCP, Onprem etc)
3. JSON format                           3. Domain specific format                  3. HCL (Hashicorp configuration language) format
4. exptension template.json              4. extension main.bicep                    4. extension main.tf          
5. template.json                         5. main.bicep                              5. main.tf
   parameters.json                          main.bicepparam                            variables.tf
6. az deploymnet group create \          6. az deploymnet group create \            6.  Terraform init
   -g demo --template-file a.json           -g demo --template-file a.json              Terraform validate
   --parameters b.json                      --parameters b.json                         Terraform fmt
                                                                                        Terraform plan
                                                                                        Terraform apply 
                                                                                        Terraform destroy
7. Structure:                           7. param                                    7. Building blocks:
   Shcema                                  var                                          provider
   contentversion                          resources                                    resources
   parameters                              outputs                                      outputs
   variables
   resources
   outputs


Get started with terraform:
==========================

download terraform: https://developer.hashicorp.com/terraform/install#windows

terraform version : v1.15.2 / v1.14.8
terraform Azure provider version: 4.71.0 

Terraform init - Intialize the backend & install the provider plugins
Terraform fmt  - It formats the terraform templates
Terraform validate - It does syntax validation of the templates
Terraform plan - The plan of the deployment, Plan: 2 add, 0 change, 0 destroy 
Terraform apply - Its going to deploy the resources on the target platform 
Terraform destroy - delete all the resources as per template