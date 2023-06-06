# output "cdn_profile" {
#   description = "azurerm_cdn_profile results"
#   value = {
#     for cdn_profile in keys(azurerm_cdn_profile.cdn_profile) :
#     cdn_profile => {
#       id   = azurerm_cdn_profile.cdn_profile[cdn_profile].id
#       name = azurerm_cdn_profile.cdn_profile[cdn_profile].name
#     }
#   }
# }

# output "cdn_endpoint" {
#   description = "azurerm_cdn_endpoint results"
#   value = {
#     for cdn_endpoint in keys(azurerm_cdn_endpoint.cdn_endpoint) :
#     cdn_endpoint => {
#       id   = azurerm_cdn_endpoint.cdn_endpoint[cdn_endpoint].id
#       name = azurerm_cdn_endpoint.cdn_endpoint[cdn_endpoint].name
#       fqdn = azurerm_cdn_endpoint.cdn_endpoint[cdn_endpoint].fqdn
#     }
#   }
# }

#####

output "cdn_frontdoor_profile" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_profile in keys(azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile) :
    cdn_frontdoor_profile => {
      for key, value in azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile[cdn_frontdoor_profile] :
      key => value
    }
  }
}

output "cdn_frontdoor_origin_group" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_origin_group in keys(azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group) :
    cdn_frontdoor_origin_group => {
      for key, value in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group[cdn_frontdoor_origin_group] :
      key => value
    }
  }
}

output "cdn_frontdoor_origin" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_origin in keys(azurerm_cdn_frontdoor_origin.cdn_frontdoor_origin) :
    cdn_frontdoor_origin => {
      for key, value in azurerm_cdn_frontdoor_origin.cdn_frontdoor_origin[cdn_frontdoor_origin] :
      key => value
    }
  }
}

output "cdn_frontdoor_endpoint" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_endpoint in keys(azurerm_cdn_frontdoor_endpoint.cdn_frontdoor_endpoint) :
    cdn_frontdoor_endpoint => {
      for key, value in azurerm_cdn_frontdoor_endpoint.cdn_frontdoor_endpoint[cdn_frontdoor_endpoint] :
      key => value
    }
  }
}

output "cdn_frontdoor_custom_domain" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_custom_domain in keys(azurerm_cdn_frontdoor_custom_domain.cdn_frontdoor_custom_domain) :
    cdn_frontdoor_custom_domain => {
      for key, value in azurerm_cdn_frontdoor_custom_domain.cdn_frontdoor_custom_domain[cdn_frontdoor_custom_domain] :
      key => value
    }
  }
}

output "cdn_frontdoor_route" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_route in keys(azurerm_cdn_frontdoor_route.cdn_frontdoor_route) :
    cdn_frontdoor_route => {
      for key, value in azurerm_cdn_frontdoor_route.cdn_frontdoor_route[cdn_frontdoor_route] :
      key => value
    }
  }
}

output "cdn_frontdoor_rule_set" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_rule_set in keys(azurerm_cdn_frontdoor_rule_set.cdn_frontdoor_rule_set) :
    cdn_frontdoor_rule_set => {
      for key, value in azurerm_cdn_frontdoor_rule_set.cdn_frontdoor_rule_set[cdn_frontdoor_rule_set] :
      key => value
    }
  }
}

output "cdn_frontdoor_rule" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_rule in keys(azurerm_cdn_frontdoor_rule.cdn_frontdoor_rule) :
    cdn_frontdoor_rule => {
      for key, value in azurerm_cdn_frontdoor_rule.cdn_frontdoor_rule[cdn_frontdoor_rule] :
      key => value
    }
  }
}

output "cdn_frontdoor_firewall_policy" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_firewall_policy in keys(azurerm_cdn_frontdoor_firewall_policy.cdn_frontdoor_firewall_policy) :
    cdn_frontdoor_firewall_policy => {
      for key, value in azurerm_cdn_frontdoor_firewall_policy.cdn_frontdoor_firewall_policy[cdn_frontdoor_firewall_policy] :
      key => value
    }
  }
}

output "cdn_frontdoor_security_policy" {
  description = "Outputs all attributes of resource_type."
  value = {
    for cdn_frontdoor_security_policy in keys(azurerm_cdn_frontdoor_security_policy.cdn_frontdoor_security_policy) :
    cdn_frontdoor_security_policy => {
      for key, value in azurerm_cdn_frontdoor_security_policy.cdn_frontdoor_security_policy[cdn_frontdoor_security_policy] :
      key => value
    }
  }
}

output "variables" {
  description = "Displays all configurable variables passed by the module. __default__ = predefined values per module. __merged__ = result of merging the default values and custom values passed to the module"
  value = {
    default = {
      for variable in keys(local.default) :
      variable => local.default[variable]
    }
    merged = {
      cdn_frontdoor_profile = {
        for key in keys(var.cdn_frontdoor_profile) :
        key => local.cdn_frontdoor_profile[key]
      }
      cdn_frontdoor_origin_group = {
        for key in keys(var.cdn_frontdoor_origin_group) :
        key => local.cdn_frontdoor_origin_group[key]
      }
      cdn_frontdoor_origin = {
        for key in keys(var.cdn_frontdoor_origin) :
        key => local.cdn_frontdoor_origin[key]
      }
      cdn_frontdoor_endpoint = {
        for key in keys(var.cdn_frontdoor_endpoint) :
        key => local.cdn_frontdoor_endpoint[key]
      }
      cdn_frontdoor_custom_domain = {
        for key in keys(var.cdn_frontdoor_custom_domain) :
        key => local.cdn_frontdoor_custom_domain[key]
      }
      cdn_frontdoor_route = {
        for key in keys(var.cdn_frontdoor_route) :
        key => local.cdn_frontdoor_route[key]
      }
      cdn_frontdoor_rule_set = {
        for key in keys(var.cdn_frontdoor_rule_set) :
        key => local.cdn_frontdoor_rule_set[key]
      }
      cdn_frontdoor_rule = {
        for key in keys(var.cdn_frontdoor_rule) :
        key => local.cdn_frontdoor_rule[key]
      }
      cdn_frontdoor_firewall_policy = {
        for key in keys(var.cdn_frontdoor_firewall_policy) :
        key => local.cdn_frontdoor_firewall_policy[key]
      }
      cdn_frontdoor_security_policy = {
        for key in keys(var.cdn_frontdoor_security_policy) :
        key => local.cdn_frontdoor_security_policy[key]
      }
    }
    variable = {
      for key in keys(var.cdn_frontdoor_rule) :
      key => local.cdn_frontdoor_rule[key].conditions.request_header_condition
    }
  }
}
