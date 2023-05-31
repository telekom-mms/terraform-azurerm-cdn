/**
* # cdn
*
* This module manages the hashicorp/azurerm cdn resources.
* For more information see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs > cdn
*
*/

# resource "azurerm_cdn_profile" "cdn_profile" {
#   for_each = var.cdn_profile

#   name                = local.cdn_profile[each.key].name == "" ? each.key : local.cdn_profile[each.key].name
#   location            = local.cdn_profile[each.key].location
#   resource_group_name = local.cdn_profile[each.key].resource_group_name
#   sku                 = local.cdn_profile[each.key].sku
#   tags                = local.cdn_profile[each.key].tags
# }

# resource "azurerm_cdn_endpoint" "cdn_endpoint" {
#   for_each = var.cdn_endpoint

#   name                = local.cdn_endpoint[each.key].name == "" ? each.key : local.cdn_endpoint[each.key].name
#   profile_name        = local.cdn_endpoint[each.key].profile_name
#   location            = local.cdn_endpoint[each.key].location
#   resource_group_name = local.cdn_endpoint[each.key].resource_group_name
#   origin {
#     name      = local.cdn_endpoint[each.key].origin.name
#     host_name = local.cdn_endpoint[each.key].origin.host_name
#   }
#   origin_host_header            = local.cdn_endpoint[each.key].origin_host_header
#   is_http_allowed               = local.cdn_endpoint[each.key].is_http_allowed
#   querystring_caching_behaviour = local.cdn_endpoint[each.key].querystring_caching_behaviour
#   tags                          = local.cdn_endpoint[each.key].tags
# }

# resource "azurerm_cdn_endpoint_custom_domain" "cdn_endpoint_custom_domain" {
#   for_each = var.cdn_endpoint_custom_domain

#   name            = local.cdn_endpoint_custom_domain[each.key].name == "" ? each.key : local.cdn_endpoint_custom_domain[each.key].name
#   cdn_endpoint_id = local.cdn_endpoint_custom_domain[each.key].cdn_endpoint_id
#   host_name       = local.cdn_endpoint_custom_domain[each.key].host_name

#   dynamic "cdn_managed_https" {
#     for_each = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.certificate_type != "" ? [1] : []
#     content {
#       certificate_type = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.certificate_type
#       protocol_type    = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.protocol_type
#       tls_version      = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.tls_version
#     }
#   }

#   dynamic "user_managed_https" {
#     for_each = local.cdn_endpoint_custom_domain[each.key].user_managed_https.key_vault_certificate_id != "" ? [1] : []
#     content {
#       key_vault_certificate_id = local.cdn_endpoint_custom_domain[each.key].user_managed_https.key_vault_certificate_id
#       tls_version              = local.cdn_endpoint_custom_domain[each.key].user_managed_https.tls_version
#     }
#   }
# }

#####

resource "azurerm_cdn_frontdoor_profile" "cdn_frontdoor_profile" {
  for_each = var.cdn_frontdoor_profile

  name                     = local.cdn_frontdoor_profile[each.key].name == "" ? each.key : local.cdn_frontdoor_profile[each.key].name
  resource_group_name      = local.cdn_frontdoor_profile[each.key].resource_group_name
  sku_name                 = local.cdn_frontdoor_profile[each.key].sku_name
  response_timeout_seconds = local.cdn_frontdoor_profile[each.key].response_timeout_seconds
  tags                     = local.cdn_frontdoor_profile[each.key].tags
}

resource "azurerm_cdn_frontdoor_origin_group" "cdn_frontdoor_origin_group" {
  for_each = var.cdn_frontdoor_origin_group

  name                                                      = local.cdn_frontdoor_origin_group[each.key].name == "" ? each.key : local.cdn_frontdoor_origin_group[each.key].name
  cdn_frontdoor_profile_id                                  = local.cdn_frontdoor_origin_group[each.key].cdn_frontdoor_profile_id
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = local.cdn_frontdoor_origin_group[each.key].restore_traffic_time_to_healed_or_new_endpoint_in_minutes
  session_affinity_enabled                                  = local.cdn_frontdoor_origin_group[each.key].session_affinity_enabled

  load_balancing {
    additional_latency_in_milliseconds = local.cdn_frontdoor_origin_group[each.key].load_balancing.additional_latency_in_milliseconds
    sample_size                        = local.cdn_frontdoor_origin_group[each.key].load_balancing.sample_size
    successful_samples_required        = local.cdn_frontdoor_origin_group[each.key].load_balancing.successful_samples_required
  }

  dynamic "health_probe" {
    for_each = flatten(compact(values(local.cdn_frontdoor_origin_group[each.key].health_probe))) == [] ? [] : [0]

    content {
      protocol            = local.cdn_frontdoor_origin_group[each.key].health_probe.protocol
      interval_in_seconds = local.cdn_frontdoor_origin_group[each.key].health_probe.interval_in_seconds
      request_type        = local.cdn_frontdoor_origin_group[each.key].health_probe.request_type
      path                = local.cdn_frontdoor_origin_group[each.key].health_probe.path
    }
  }
}

resource "azurerm_cdn_frontdoor_origin" "cdn_frontdoor_origin" {
  for_each = var.cdn_frontdoor_origin

  name                           = local.cdn_frontdoor_origin[each.key].name == "" ? each.key : local.cdn_frontdoor_origin[each.key].name
  cdn_frontdoor_origin_group_id  = local.cdn_frontdoor_origin[each.key].cdn_frontdoor_origin_group_id
  host_name                      = local.cdn_frontdoor_origin[each.key].host_name
  certificate_name_check_enabled = local.cdn_frontdoor_origin[each.key].certificate_name_check_enabled
  enabled                        = local.cdn_frontdoor_origin[each.key].enabled
  http_port                      = local.cdn_frontdoor_origin[each.key].http_port
  https_port                     = local.cdn_frontdoor_origin[each.key].https_port
  origin_host_header             = local.cdn_frontdoor_origin[each.key].origin_host_header
  priority                       = local.cdn_frontdoor_origin[each.key].priority
  weight                         = local.cdn_frontdoor_origin[each.key].weight

  dynamic "private_link" {
    for_each = flatten(compact(values(local.cdn_frontdoor_origin[each.key].private_link))) == [] ? [] : [0]

    content {
      request_message        = local.cdn_frontdoor_origin[each.key].private_link.request_message
      target_type            = local.cdn_frontdoor_origin[each.key].private_link.target_type
      location               = local.cdn_frontdoor_origin[each.key].private_link.location
      private_link_target_id = local.cdn_frontdoor_origin[each.key].private_link.private_link_target_id
    }
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "cdn_frontdoor_endpoint" {
  for_each = var.cdn_frontdoor_endpoint

  name                     = local.cdn_frontdoor_endpoint[each.key].name == "" ? each.key : local.cdn_frontdoor_endpoint[each.key].name
  cdn_frontdoor_profile_id = local.cdn_frontdoor_endpoint[each.key].cdn_frontdoor_profile_id
  enabled                  = local.cdn_frontdoor_endpoint[each.key].enabled
  tags                     = local.cdn_frontdoor_endpoint[each.key].tags
}

resource "azurerm_cdn_frontdoor_custom_domain" "cdn_frontdoor_custom_domain" {
  for_each = var.cdn_frontdoor_custom_domain

  name                     = local.cdn_frontdoor_custom_domain[each.key].name == "" ? each.key : local.cdn_frontdoor_custom_domain[each.key].name
  cdn_frontdoor_profile_id = local.cdn_frontdoor_custom_domain[each.key].cdn_frontdoor_profile_id
  host_name                = local.cdn_frontdoor_custom_domain[each.key].host_name
  dns_zone_id              = local.cdn_frontdoor_custom_domain[each.key].dns_zone_id
  tls {
    certificate_type        = local.cdn_frontdoor_custom_domain[each.key].tls.certificate_type
    minimum_tls_version     = local.cdn_frontdoor_custom_domain[each.key].tls.minimum_tls_version
    cdn_frontdoor_secret_id = local.cdn_frontdoor_custom_domain[each.key].tls.cdn_frontdoor_secret_id
  }
}

resource "azurerm_cdn_frontdoor_route" "cdn_frontdoor_route" {
  for_each = var.cdn_frontdoor_route

  name                            = local.cdn_frontdoor_route[each.key].name == "" ? each.key : local.cdn_frontdoor_route[each.key].name
  cdn_frontdoor_endpoint_id       = local.cdn_frontdoor_route[each.key].cdn_frontdoor_endpoint_id
  cdn_frontdoor_origin_group_id   = local.cdn_frontdoor_route[each.key].cdn_frontdoor_origin_group_id
  cdn_frontdoor_origin_ids        = local.cdn_frontdoor_route[each.key].cdn_frontdoor_origin_ids
  forwarding_protocol             = local.cdn_frontdoor_route[each.key].forwarding_protocol
  patterns_to_match               = local.cdn_frontdoor_route[each.key].patterns_to_match
  supported_protocols             = local.cdn_frontdoor_route[each.key].supported_protocols
  cdn_frontdoor_custom_domain_ids = local.cdn_frontdoor_route[each.key].cdn_frontdoor_custom_domain_ids
  cdn_frontdoor_origin_path       = local.cdn_frontdoor_route[each.key].cdn_frontdoor_origin_path
  cdn_frontdoor_rule_set_ids      = local.cdn_frontdoor_route[each.key].cdn_frontdoor_rule_set_ids
  enabled                         = local.cdn_frontdoor_route[each.key].enabled
  https_redirect_enabled          = local.cdn_frontdoor_route[each.key].https_redirect_enabled
  link_to_default_domain          = local.cdn_frontdoor_route[each.key].link_to_default_domain

  dynamic "cache" {
    for_each = flatten(compact(values(local.cdn_frontdoor_route[each.key].cache))) == [] ? [] : [0]

    content {
      query_string_caching_behavior = local.cdn_frontdoor_route[each.key].cache.query_string_caching_behavior
      query_strings                 = local.cdn_frontdoor_route[each.key].cache.query_strings
      compression_enabled           = local.cdn_frontdoor_route[each.key].cache.compression_enabled
      content_types_to_compress     = local.cdn_frontdoor_route[each.key].cache.content_types_to_compress
    }
  }
}

resource "azurerm_cdn_frontdoor_firewall_policy" "cdn_frontdoor_firewall_policy" {
  for_each = var.cdn_frontdoor_firewall_policy

  name                              = local.cdn_frontdoor_firewall_policy[each.key].name == "" ? each.key : local.cdn_frontdoor_firewall_policy[each.key].name
  resource_group_name               = local.cdn_frontdoor_firewall_policy[each.key].resource_group_name
  sku_name                          = local.cdn_frontdoor_firewall_policy[each.key].sku_name
  enabled                           = local.cdn_frontdoor_firewall_policy[each.key].enabled
  mode                              = local.cdn_frontdoor_firewall_policy[each.key].mode
  redirect_url                      = local.cdn_frontdoor_firewall_policy[each.key].redirect_url
  custom_block_response_status_code = local.cdn_frontdoor_firewall_policy[each.key].custom_block_response_status_code
  custom_block_response_body        = local.cdn_frontdoor_firewall_policy[each.key].custom_block_response_body

  # dynamic "custom_rule" {
  #   for_each = keys(local.cdn_frontdoor_firewall_policy[each.key].custom_rule)

  #   content {
  #     name                           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].name == "" ? custom_rule.key : local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].name
  #     action                         = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].action
  #     enabled                        = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].enabled
  #     priority                       = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].priority
  #     type                           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].type
  #     rate_limit_duration_in_minutes = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].rate_limit_duration_in_minutes
  #     rate_limit_threshold           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].rate_limit_threshold

  #     dynamic "match_condition" {
  #       for_each = keys(local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition)

  #       content {
  #         match_variable     = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].match_variable
  #         match_values       = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].match_values
  #         operator           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].operator
  #         selector           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].selector
  #         negation_condition = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].negation_condition
  #         transforms         = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].transforms
  #       }
  #     }
  #   }
  # }

  # dynamic "managed_rule" {
  #   for_each = local.cdn_frontdoor_firewall_policy[each.key].managed_rule

  #   content {
  #     type    = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].type
  #     version = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].version
  #     action  = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].action

  #     dynamic "exclusion" {
  #       for_each = keys(local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].exclusion)

  #       content {
  #         match_variable = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].exclusion[exclusion.key].match_variable
  #         operator       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].exclusion[exclusion.key].operator
  #         selector       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].exclusion[exclusion.key].selector
  #       }
  #     }

  #     dynamic "override" {
  #       for_each = keys(local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override)

  #       content {
  #         rule_group_name = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule_group_name

  #         dynamic "exclusion" {
  #           for_each = keys(local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].exclusion)

  #           content {
  #             match_variable = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].exclusion[exclusion.key].match_variable
  #             operator       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].exclusion[exclusion.key].operator
  #             selector       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].exclusion[exclusion.key].selector
  #           }
  #         }

  #         dynamic "rule" {
  #           for_each = keys(local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule)

  #           content {
  #             rule_id = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].rule_id
  #             action  = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].action
  #             enabled = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].enabled

  #             dynamic "exclusion" {
  #               for_each = keys(local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].exclusion)

  #               content {
  #                 match_variable = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].exclusion[exclusion.key].match_variable
  #                 operator       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].exclusion[exclusion.key].operator
  #                 selector       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].exclusion[exclusion.key].selector
  #               }
  #             }
  #           }
  #         }
  #       }
  #     }
  #   }
  # }

  tags = local.cdn_frontdoor_firewall_policy[each.key].tags
}

resource "azurerm_cdn_frontdoor_security_policy" "cdn_frontdoor_security_policy" {
  for_each = var.cdn_frontdoor_security_policy

  name                     = local.cdn_frontdoor_security_policy[each.key].name == "" ? each.key : local.cdn_frontdoor_security_policy[each.key].name
  cdn_frontdoor_profile_id = local.cdn_frontdoor_security_policy[each.key].cdn_frontdoor_profile_id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = local.cdn_frontdoor_security_policy[each.key].security_policies.firewall.cdn_frontdoor_firewall_policy_id

      association {
        patterns_to_match = local.cdn_frontdoor_security_policy[each.key].security_policies.firewall.association.patterns_to_match

        dynamic "domain" {
          for_each = local.cdn_frontdoor_security_policy[each.key].security_policies.firewall.association.domain

          content {
            cdn_frontdoor_domain_id = local.cdn_frontdoor_security_policy[each.key].security_policies.firewall.association.domain[domain.key].cdn_frontdoor_domain_id
          }
        }
      }
    }
  }
}
