@description('Deployment location for all resources')
param location string = 'eastus'

@description('Deployment environment tag')
param environment string = 'dev'

@description('Azure SQL administrator login name')
param sqlAdministratorLogin string = 'saanvikitadmin'

@description('Azure SQL administrator password')
@secure()
param sqlAdministratorPassword string

@description('Initial application secret stored in Key Vault')
@secure()
param appSecretValue string

var keyVaultName = 'saanvikit-kv-007'
var logWorkspaceName = 'saanvikit-law'
var appServicePlanName = 'saanvikit-appserviceplan'
var webAppName = 'saanvikit-webapp-007'
var sqlServerName = 'saanvikit-sqlserver'
var sqlDatabaseName = 'saanvikit-sqldb'
var sqlConnectionStringSecretName = 'sql-connection-string'
var appSecretName = 'app-secret'
var certificateName = 'saanvikit-appcert'
var tags = {
  project: 'saanvikit'
  environment: environment
}

var sqlConnectionString = 'Server=tcp:${sqlServerName}.database.windows.net,1433;Initial Catalog=${sqlDatabaseName};User ID=${sqlAdministratorLogin};Password=${sqlAdministratorPassword};Encrypt=true;TrustServerCertificate=false;Connection Timeout=30;'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'S1'
    tier: 'Standard'
    size: 'S1'
    family: 'S'
    capacity: 1
  }
  properties: {
    reserved: false
    perSiteScaling: false
    maximumElasticWorkerCount: 1
  }
  tags: tags
}

resource webApp 'Microsoft.Web/sites@2024-04-01' = {
  name: webAppName
  location: location
  tags: tags
  kind: 'app'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
}

resource slotStage 'Microsoft.Web/sites/slots@2024-04-01' = {
  name: '${webApp.name}/stage'
  location: location
  tags: tags
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource slotLastGood 'Microsoft.Web/sites/slots@2024-04-01' = {
  name: '${webApp.name}/lastgood'
  location: location
  tags: tags
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logWorkspaceName
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

resource sqlServer 'Microsoft.Sql/servers@2024-08-01-preview' = {
  name: sqlServerName
  location: location
  tags: tags
  properties: {
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqlAdministratorPassword
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-08-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  tags: tags
  properties: {
    createMode: 'Default'
  }
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource sqlFirewallRule 'Microsoft.Sql/servers/firewallRules@2024-08-01-preview' = {
  parent: sqlServer
  name: 'AllowAzureServices'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  tags: tags
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: webApp.identity.principalId
        permissions: {
          secrets: [
            'get'
            'list'
          ]
          certificates: [
            'get'
            'list'
          ]
        }
      }
    ]
  }
}

resource appSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  name: '${keyVault.name}/${appSecretName}'
  properties: {
    value: appSecretValue
  }
}

resource sqlConnectionStringSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  name: '${keyVault.name}/${sqlConnectionStringSecretName}'
  properties: {
    value: sqlConnectionString
  }
  dependsOn: [
    keyVault
    sqlServer
    sqlDatabase
  ]
}

resource appCertificate 'Microsoft.KeyVault/vaults/certificates@2023-07-01' = {
  name: '${keyVault.name}/${certificateName}'
  properties: {
    certificatePolicy: {
      keyProperties: {
        exportable: true
        keyType: 'RSA'
        keySize: 2048
        keyUsage: [
          'digitalSignature'
          'keyEncipherment'
        ]
      }
      secretProperties: {
        contentType: 'application/x-pkcs12'
      }
      x509CertificateProperties: {
        subject: 'CN=saanvikit-app-cert'
        validityInMonths: 12
      }
      issuerParameters: {
        name: 'Self'
      }
      lifetimeActions: [
        {
          action: {
            actionType: 'AutoRenew'
          }
          trigger: {
            daysBeforeExpiry: 30
          }
        }
      ]
    }
  }
}

resource webAppDiagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'webapp-to-loganalytics'
  scope: webApp
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'AppServiceHTTPLogs'
        enabled: true
      }
      {
        category: 'AppServiceConsoleLogs'
        enabled: true
      }
      {
        category: 'AppServiceAppLogs'
        enabled: true
      }
      {
        category: 'AppServiceAuditLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
  }
}

resource webAppSettings 'Microsoft.Web/sites/config@2024-04-01' = {
  name: '${webApp.name}/appsettings'
  properties: {
    SQL_CONNECTION_STRING: '@Microsoft.KeyVault(SecretUri=${sqlConnectionStringSecret.properties.secretUri})'
    APP_SECRET: '@Microsoft.KeyVault(SecretUri=${appSecret.properties.secretUri})'
    APP_CERT_SECRET: '@Microsoft.KeyVault(SecretUri=${appCertificate.properties.secretId})'
    WEBSITE_RUN_FROM_PACKAGE: '1'
  }
}

