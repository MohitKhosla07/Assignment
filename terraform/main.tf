resource "azurerm_resource_group" "rg" {
   name  = "fsl-${var.env}-rg"
   location = "East US"
   
}

resource "v" {
   name = "fsl-${var.env}-storage"
   resource_group_name = azurerm_resource_group.rg.name
   location = "East US"
   account_tier = "Standard"
   account_replication_type = "LRS"
   static_website {
     index_document = "index.html"
	 }
}

resource "azurerm_cdn_endpoint" "endpoint" {
   name = "fsl-${var.env}-cdn"
   resource_group_name = azurerm_resource_group.rg.name
   location = "East US"
   profile_name = azurerm_cdn_endpoint.endpoint.name
   origin {
    name = "storage-origin"
	host_name  = azurerm_storage_account.storage.primary_web_host 
	
	}
}
