terraform {
  required_providers {
    azurerm={
        source="hashicorp/azurerm"
        version="3.17.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "6912d7a0-bc28-459a-9407-33bbba641c07"
  tenant_id = "70c0f6d9-7f3b-4425-a6b6-09b47643ec58"
  client_id = "3feda701-6a3d-4915-8d26-343827060a8e"
  client_secret = "kKH8Q~54-LwKs2lYfNj6ECD_VmAt-cKSllRG4bfE"
  features {    
  }
}

resource "azurerm_service_plan" "plan787878" {
  name                = "plan787878"
  resource_group_name = "template-grp"
  location            = "North Europe"
  os_type             = "Windows"
  sku_name            = "F1"
}

resource "azurerm_windows_web_app" "newapp1002030" {
  name                = "newapp1002030"
  resource_group_name = "template-grp"
  location            = "North Europe"
  service_plan_id     = azurerm_service_plan.plan787878.id

  site_config {
    always_on = false
    application_stack{
        current_stack="dotnet"
        dotnet_version="v6.0"
    }
  }

  depends_on = [
    azurerm_service_plan.plan787878
  ]
}

resource "azurerm_mssql_server" "sqlserver468985656" {
  name                         = "sqlserver468985656"
  resource_group_name          = "template-grp"
  location                     = "North Europe"
  version                      = "12.0"
  administrator_login          = "sqlusr"
  administrator_login_password = "Azure@123"  
}

resource "azurerm_mssql_database" "appdb" {
  name           = "appdb"
  server_id      = azurerm_mssql_server.sqlserver468985656.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2  
  sku_name       = "Basic"
  depends_on = [
    azurerm_mssql_server.sqlserver468985656
  ]
}