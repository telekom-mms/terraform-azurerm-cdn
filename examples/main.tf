module "cdn" {
  source = "registry.terraform.io/T-Systems-MMS/cdn/azurerm"
  cdn_profile = {
    live = {
      name                = "service-live-cdn"
      location            = "westeurope"
      resource_group_name = "service-live-rg"
      sku                 = "Premium_Verizon"
      tags = {
        service = "service_name"
      }
    }
  }
  cdn_endpoint = {
    storage = {
      name                          = module.storage.storage_account.live.name
      profile_name                  = module.cdn.cdn_profile.live.name
      location                      = "westeurope"
      resource_group_name           = "service-live-rg"
      is_http_allowed               = false
      querystring_caching_behaviour = "NotSet"
      origin = {
        host_name = module.storage.storage_account.live.primary_blob_host
      }
      origin_host_header = module.storage.storage_account.live.primary_blob_host
      tags = {
        service = "service_name"
      }
    }
  }
  cdn_endpoint_custom_domain = {
    live = {
      cdn_endpoint_id = module.cdn.cdn_endpoint["storage"].id
      host_name       = "service.domain.com"
      cdn_managed_https = {
        certificate_type = "Shared"
        protocol_type    = "IPBased"
      }
    }
  }
}
