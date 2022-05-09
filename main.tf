/**
 * # cdn
 *
 * This module manages Azure CDN Configuration.
 *
*/

resource "azurerm_cdn_profile" "cdn_profile" {
  for_each = var.cdn_profile

  name                = local.cdn_profile[each.key].name == "" ? each.key : local.cdn_profile[each.key].name
  location            = local.cdn_profile[each.key].location
  resource_group_name = local.cdn_profile[each.key].resource_group_name
  sku                 = local.cdn_profile[each.key].sku
  tags                = local.cdn_profile[each.key].tags
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  for_each = var.cdn_endpoint

  name                = local.cdn_endpoint[each.key].name == "" ? each.key : local.cdn_endpoint[each.key].name
  profile_name        = local.cdn_endpoint[each.key].profile_name
  location            = local.cdn_endpoint[each.key].location
  resource_group_name = local.cdn_endpoint[each.key].resource_group_name
  origin {
    name      = local.cdn_endpoint[each.key].origin.name
    host_name = local.cdn_endpoint[each.key].origin.host_name
  }
  origin_host_header            = local.cdn_endpoint[each.key].origin_host_header
  is_http_allowed               = local.cdn_endpoint[each.key].is_http_allowed
  querystring_caching_behaviour = local.cdn_endpoint[each.key].querystring_caching_behaviour
  tags                          = local.cdn_endpoint[each.key].tags
}

resource "azurerm_cdn_endpoint_custom_domain" "cdn_endpoint_custom_domain" {
  for_each = var.cdn_endpoint_custom_domain

  name            = local.cdn_endpoint_custom_domain[each.key].name == "" ? each.key : local.cdn_endpoint_custom_domain[each.key].name
  cdn_endpoint_id = local.cdn_endpoint_custom_domain[each.key].cdn_endpoint_id
  host_name       = local.cdn_endpoint_custom_domain[each.key].host_name

  dynamic "cdn_managed_https" {
    for_each = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.certificate_type != "" ? [1] : []
    content {
      certificate_type = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.certificate_type
      protocol_type    = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.protocol_type
      tls_version      = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.tls_version
    }
  }

  dynamic "user_managed_https" {
    for_each = local.cdn_endpoint_custom_domain[each.key].user_managed_https.key_vault_certificate_id != "" ? [1] : []
    content {
      key_vault_certificate_id = local.cdn_endpoint_custom_domain[each.key].user_managed_https.key_vault_certificate_id
      tls_version              = local.cdn_endpoint_custom_domain[each.key].user_managed_https.tls_version
    }
  }
}
