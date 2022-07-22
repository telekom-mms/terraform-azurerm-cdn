output "cdn_profile" {
  description = "azurerm_cdn_profile results"
  value = {
    for cdn_profile in keys(azurerm_cdn_profile.cdn_profile) :
    cdn_profile => {
      id   = azurerm_cdn_profile.cdn_profile[cdn_profile].id
      name = azurerm_cdn_profile.cdn_profile[cdn_profile].name
    }
  }
}

output "cdn_endpoint" {
  description = "azurerm_cdn_endpoint results"
  value = {
    for cdn_endpoint in keys(azurerm_cdn_endpoint.cdn_endpoint) :
    cdn_endpoint => {
      id   = azurerm_cdn_endpoint.cdn_endpoint[cdn_endpoint].id
      name = azurerm_cdn_endpoint.cdn_endpoint[cdn_endpoint].name
      fqdn = azurerm_cdn_endpoint.cdn_endpoint[cdn_endpoint].fqdn
    }
  }
}
