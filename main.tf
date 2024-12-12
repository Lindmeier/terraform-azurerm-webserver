
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_storage_account" "sa" {
  name                = "stlabwetest01"
  resource_group_name = data.azurerm_resource_group.rg.name
}




resource "azurerm_service_plan" "getting_started" {
  name                = "tfdp-getting-started-${var.env_name}"
  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "getting_started" {
  name                = "tfdp-getting-started-${var.env_name}"
  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.getting_started.id

  site_config {
    application_stack {
      docker_image_name   = "nginx:1.25"
      docker_registry_url = "https://index.docker.io"
    }
  }

  storage_account {
    account_name = data.azurerm_storage_account.sa.name
    access_key   = data.azurerm_storage_account.sa.primary_access_key
    type         = "AzureFiles"
    share_name   = data.azurerm_storage_account.sa.name
    mount_path   = "/usr/share/nginx/html"
    name         = "nginx_files"
  }
}