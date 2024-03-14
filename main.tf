/**
* # cdn
*
* This module manages the hashicorp/azurerm cdn resources.
* For more information see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs > cdn
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

  name                          = local.cdn_endpoint[each.key].name == "" ? each.key : local.cdn_endpoint[each.key].name
  location                      = local.cdn_endpoint[each.key].location
  resource_group_name           = local.cdn_endpoint[each.key].resource_group_name
  profile_name                  = local.cdn_endpoint[each.key].profile_name
  is_http_allowed               = local.cdn_endpoint[each.key].is_http_allowed
  is_https_allowed              = local.cdn_endpoint[each.key].is_https_allowed
  content_types_to_compress     = local.cdn_endpoint[each.key].content_types_to_compress
  is_compression_enabled        = local.cdn_endpoint[each.key].is_compression_enabled
  querystring_caching_behaviour = local.cdn_endpoint[each.key].querystring_caching_behaviour
  optimization_type             = local.cdn_endpoint[each.key].optimization_type
  origin_host_header            = local.cdn_endpoint[each.key].origin_host_header
  origin_path                   = local.cdn_endpoint[each.key].origin_path
  probe_path                    = local.cdn_endpoint[each.key].probe_path

  dynamic "origin" {
    for_each = local.cdn_endpoint[each.key].origin

    content {
      name       = local.cdn_endpoint[each.key].origin[origin.key].name == "" ? origin.key : local.cdn_endpoint[each.key].origin[origin.key].name
      host_name  = local.cdn_endpoint[each.key].origin[origin.key].host_name
      http_port  = local.cdn_endpoint[each.key].origin[origin.key].http_port
      https_port = local.cdn_endpoint[each.key].origin[origin.key].https_port
    }
  }

  dynamic "geo_filter" {
    for_each = local.cdn_endpoint[each.key].geo_filter

    content {
      relative_path = local.cdn_endpoint[each.key].geo_filter[geo_filter.key].relative_path
      action        = local.cdn_endpoint[each.key].geo_filter[geo_filter.key].action
      country_codes = local.cdn_endpoint[each.key].geo_filter[geo_filter.key].country_codes
    }
  }

  dynamic "delivery_rule" {
    for_each = local.cdn_endpoint[each.key].delivery_rule

    content {
      name = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].name == "" ? delivery_rule.key : local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].name
      // first rule should start with 1
      order = index(keys(local.cdn_endpoint[each.key].delivery_rule), delivery_rule.key) == 0 ? 1 : local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].order

      dynamic "cache_expiration_action" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cache_expiration_action == null ? [] : [0]

        content {
          behavior = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cache_expiration_action.behavior
          duration = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cache_expiration_action.duration
        }
      }

      dynamic "cache_key_query_string_action" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cache_key_query_string_action == null ? [] : [0]

        content {
          behavior   = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cache_key_query_string_action.behavior
          parameters = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cache_key_query_string_action.parameters
        }
      }

      dynamic "cookies_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cookies_condition == null ? [] : [0]

        content {
          selector         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cookies_condition.selector
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cookies_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cookies_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cookies_condition.match_values
          transforms       = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].cookies_condition.transforms
        }
      }

      dynamic "device_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].device_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].device_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].device_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].device_condition.match_values
        }
      }

      dynamic "http_version_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].http_version_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].http_version_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].http_version_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].http_version_condition.match_values
        }
      }

      dynamic "modify_request_header_action" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].modify_request_header_action == null ? [] : [0]

        content {
          action = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].modify_request_header_action.action
          name   = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].modify_request_header_action.name
          value  = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].modify_request_header_action.value
        }
      }

      dynamic "modify_response_header_action" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].modify_response_header_action == null ? [] : [0]

        content {
          action = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].modify_response_header_action.action
          name   = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].modify_response_header_action.name
          value  = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].modify_response_header_action.value
        }
      }

      dynamic "post_arg_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].post_arg_condition == null ? [] : [0]

        content {
          selector         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].post_arg_condition.selector
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].post_arg_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].post_arg_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].post_arg_condition.match_values
          transforms       = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].post_arg_condition.transforms
        }
      }

      dynamic "query_string_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].query_string_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].query_string_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].query_string_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].query_string_condition.match_values
          transforms       = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].query_string_condition.transforms
        }
      }

      dynamic "remote_address_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].remote_address_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].remote_address_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].remote_address_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].remote_address_condition.match_values
        }
      }

      dynamic "request_body_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_body_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_body_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_body_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_body_condition.match_values
          transforms       = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_body_condition.transforms
        }
      }

      dynamic "request_header_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_header_condition == null ? [] : [0]

        content {
          selector         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_header_condition.selector
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_header_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_header_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_header_condition.match_values
          transforms       = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_header_condition.transforms
        }
      }

      dynamic "request_method_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_method_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_method_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_method_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_method_condition.match_values
        }
      }

      dynamic "request_scheme_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_scheme_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_scheme_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_scheme_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_scheme_condition.match_values
        }
      }

      dynamic "request_uri_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_uri_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_uri_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_uri_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_uri_condition.match_values
          transforms       = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].request_uri_condition.transforms
        }
      }

      dynamic "url_file_extension_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_extension_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_extension_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_extension_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_extension_condition.match_values
          transforms       = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_extension_condition.transforms
        }
      }

      dynamic "url_file_name_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_name_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_name_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_name_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_name_condition.match_values
          transforms       = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_file_name_condition.transforms
        }
      }

      dynamic "url_path_condition" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_path_condition == null ? [] : [0]

        content {
          operator         = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_path_condition.operator
          negate_condition = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_path_condition.negate_condition
          match_values     = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_path_condition.match_values
          transforms       = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_path_condition.transforms
        }
      }

      dynamic "url_redirect_action" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_redirect_action == null ? [] : [0]

        content {
          redirect_type = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_redirect_action.redirect_type
          protocol      = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_redirect_action.protocol
          hostname      = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_redirect_action.hostname
          path          = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_redirect_action.path
          fragment      = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_redirect_action.fragment
          query_string  = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_redirect_action.query_string
        }
      }

      dynamic "url_rewrite_action" {
        for_each = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_rewrite_action == null ? [] : [0]

        content {
          source_pattern          = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_rewrite_action.source_pattern
          destination             = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_rewrite_action.destination
          preserve_unmatched_path = local.cdn_endpoint[each.key].delivery_rule[delivery_rule.key].url_rewrite_action.preserve_unmatched_path
        }
      }
    }
  }

  dynamic "global_delivery_rule" {
    for_each = local.cdn_endpoint[each.key].global_delivery_rule == null ? [] : [0]

    content {
      dynamic "cache_expiration_action" {
        for_each = local.cdn_endpoint[each.key].global_delivery_rule.cache_expiration_action == null ? [] : [0]

        content {
          behavior = local.cdn_endpoint[each.key].global_delivery_rule.cache_expiration_action.behavior
          duration = local.cdn_endpoint[each.key].global_delivery_rule.cache_expiration_action.duration
        }
      }

      dynamic "cache_key_query_string_action" {
        for_each = local.cdn_endpoint[each.key].global_delivery_rule.cache_key_query_string_action == null ? [] : [0]

        content {
          behavior   = local.cdn_endpoint[each.key].global_delivery_rule.cache_key_query_string_action.behavior
          parameters = local.cdn_endpoint[each.key].global_delivery_rule.cache_key_query_string_action.parameters
        }
      }

      dynamic "modify_request_header_action" {
        for_each = local.cdn_endpoint[each.key].global_delivery_rule.modify_request_header_action == null ? [] : [0]

        content {
          action = local.cdn_endpoint[each.key].global_delivery_rule.modify_request_header_action.action
          name   = local.cdn_endpoint[each.key].global_delivery_rule.modify_request_header_action.name == "" ? modify_request_header_action.key : local.cdn_endpoint[each.key].global_delivery_rule.modify_request_header_action.name
          value  = local.cdn_endpoint[each.key].global_delivery_rule.modify_request_header_action.value
        }
      }

      dynamic "modify_response_header_action" {
        for_each = local.cdn_endpoint[each.key].global_delivery_rule.modify_response_header_action == null ? [] : [0]

        content {
          action = local.cdn_endpoint[each.key].global_delivery_rule.modify_response_header_action.action
          name   = local.cdn_endpoint[each.key].global_delivery_rule.modify_response_header_action.name == "" ? modify_request_header_action.key : local.cdn_endpoint[each.key].global_delivery_rule.modify_response_header_action.name
          value  = local.cdn_endpoint[each.key].global_delivery_rule.modify_response_header_action.value
        }
      }

      dynamic "url_redirect_action" {
        for_each = local.cdn_endpoint[each.key].global_delivery_rule.url_redirect_action == null ? [] : [0]

        content {
          redirect_type = local.cdn_endpoint[each.key].global_delivery_rule.url_redirect_action.redirect_type
          protocol      = local.cdn_endpoint[each.key].global_delivery_rule.url_redirect_action.protocol
          hostname      = local.cdn_endpoint[each.key].global_delivery_rule.url_redirect_action.hostname
          path          = local.cdn_endpoint[each.key].global_delivery_rule.url_redirect_action.path
          fragment      = local.cdn_endpoint[each.key].global_delivery_rule.url_redirect_action.fragment
          query_string  = local.cdn_endpoint[each.key].global_delivery_rule.url_redirect_action.query_string
        }
      }

      dynamic "url_rewrite_action" {
        for_each = local.cdn_endpoint[each.key].global_delivery_rule.url_rewrite_action == null ? [] : [0]

        content {
          source_pattern          = local.cdn_endpoint[each.key].global_delivery_rule.url_rewrite_action.source_pattern
          destination             = local.cdn_endpoint[each.key].global_delivery_rule.url_rewrite_action.destination
          preserve_unmatched_path = local.cdn_endpoint[each.key].global_delivery_rule.url_rewrite_action.preserve_unmatched_path
        }
      }
    }
  }

  tags = local.cdn_endpoint[each.key].tags
}

resource "azurerm_cdn_endpoint_custom_domain" "cdn_endpoint_custom_domain" {
  for_each = var.cdn_endpoint_custom_domain

  name            = local.cdn_endpoint_custom_domain[each.key].name == "" ? each.key : local.cdn_endpoint_custom_domain[each.key].name
  cdn_endpoint_id = local.cdn_endpoint_custom_domain[each.key].cdn_endpoint_id
  host_name       = local.cdn_endpoint_custom_domain[each.key].host_name

  dynamic "cdn_managed_https" {
    for_each = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https == null ? [] : [0]

    content {
      certificate_type = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.certificate_type
      protocol_type    = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.protocol_type
      tls_version      = local.cdn_endpoint_custom_domain[each.key].cdn_managed_https.tls_version
    }
  }

  dynamic "user_managed_https" {
    for_each = local.cdn_endpoint_custom_domain[each.key].user_managed_https == null ? [] : [0]

    content {
      key_vault_certificate_id = local.cdn_endpoint_custom_domain[each.key].user_managed_https.key_vault_certificate_id
      key_vault_secret_id      = local.cdn_endpoint_custom_domain[each.key].user_managed_https.key_vault_secret_id
      tls_version              = local.cdn_endpoint_custom_domain[each.key].user_managed_https.tls_version
    }
  }
}

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
    for_each = length(compact(values(local.cdn_frontdoor_origin_group[each.key].health_probe))) > 0 ? [0] : []

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
    for_each = length(compact(values(local.cdn_frontdoor_origin[each.key].private_link))) > 0 ? [0] : []

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
    for_each = length(compact(flatten(values(local.cdn_frontdoor_route[each.key].cache)))) > 0 ? [0] : []

    content {
      query_string_caching_behavior = local.cdn_frontdoor_route[each.key].cache.query_string_caching_behavior
      query_strings                 = local.cdn_frontdoor_route[each.key].cache.query_strings
      compression_enabled           = local.cdn_frontdoor_route[each.key].cache.compression_enabled
      content_types_to_compress     = local.cdn_frontdoor_route[each.key].cache.content_types_to_compress
    }
  }
}

resource "azurerm_cdn_frontdoor_rule_set" "cdn_frontdoor_rule_set" {
  for_each = var.cdn_frontdoor_rule_set

  name                     = local.cdn_frontdoor_rule_set[each.key].name == "" ? each.key : local.cdn_frontdoor_rule_set[each.key].name
  cdn_frontdoor_profile_id = local.cdn_frontdoor_rule_set[each.key].cdn_frontdoor_profile_id
}

resource "azurerm_cdn_frontdoor_rule" "cdn_frontdoor_rule" {
  for_each = var.cdn_frontdoor_rule

  name                      = local.cdn_frontdoor_rule[each.key].name == "" ? each.key : local.cdn_frontdoor_rule[each.key].name
  cdn_frontdoor_rule_set_id = local.cdn_frontdoor_rule[each.key].cdn_frontdoor_rule_set_id
  order                     = local.cdn_frontdoor_rule[each.key].order
  behavior_on_match         = local.cdn_frontdoor_rule[each.key].behavior_on_match

  actions {
    dynamic "url_rewrite_action" {
      for_each = local.cdn_frontdoor_rule[each.key].actions.url_rewrite_action

      content {
        source_pattern          = local.cdn_frontdoor_rule[each.key].actions.url_rewrite_action[url_rewrite_action.key].source_pattern
        destination             = local.cdn_frontdoor_rule[each.key].actions.url_rewrite_action[url_rewrite_action.key].destination
        preserve_unmatched_path = local.cdn_frontdoor_rule[each.key].actions.url_rewrite_action[url_rewrite_action.key].preserve_unmatched_path
      }
    }

    dynamic "url_redirect_action" {
      for_each = local.cdn_frontdoor_rule[each.key].actions.url_redirect_action

      content {
        redirect_type        = local.cdn_frontdoor_rule[each.key].actions.url_redirect_action[url_redirect_action.key].redirect_type
        destination_hostname = local.cdn_frontdoor_rule[each.key].actions.url_redirect_action[url_redirect_action.key].destination_hostname
        redirect_protocol    = local.cdn_frontdoor_rule[each.key].actions.url_redirect_action[url_redirect_action.key].redirect_protocol
        destination_path     = local.cdn_frontdoor_rule[each.key].actions.url_redirect_action[url_redirect_action.key].destination_path
        query_string         = local.cdn_frontdoor_rule[each.key].actions.url_redirect_action[url_redirect_action.key].query_string
        destination_fragment = local.cdn_frontdoor_rule[each.key].actions.url_redirect_action[url_redirect_action.key].destination_fragment
      }
    }

    dynamic "route_configuration_override_action" {
      for_each = local.cdn_frontdoor_rule[each.key].actions.route_configuration_override_action == null ? [] : [0]

      content {
        cache_duration                = local.cdn_frontdoor_rule[each.key].actions.route_configuration_override_action.cache_duration
        cdn_frontdoor_origin_group_id = local.cdn_frontdoor_rule[each.key].actions.route_configuration_override_action.cdn_frontdoor_origin_group_id
        forwarding_protocol           = local.cdn_frontdoor_rule[each.key].actions.route_configuration_override_action.forwarding_protocol
        query_string_caching_behavior = local.cdn_frontdoor_rule[each.key].actions.route_configuration_override_action.query_string_caching_behavior
        query_string_parameters       = local.cdn_frontdoor_rule[each.key].actions.route_configuration_override_action.query_string_parameters
        compression_enabled           = local.cdn_frontdoor_rule[each.key].actions.route_configuration_override_action.compression_enabled
        cache_behavior                = local.cdn_frontdoor_rule[each.key].actions.route_configuration_override_action.cache_behavior
      }
    }

    dynamic "request_header_action" {
      for_each = local.cdn_frontdoor_rule[each.key].actions.request_header_action

      content {
        header_action = local.cdn_frontdoor_rule[each.key].actions.request_header_action[request_header_action.key].header_action
        header_name   = local.cdn_frontdoor_rule[each.key].actions.request_header_action[request_header_action.key].header_name
        value         = local.cdn_frontdoor_rule[each.key].actions.request_header_action[request_header_action.key].value
      }
    }

    dynamic "response_header_action" {
      for_each = local.cdn_frontdoor_rule[each.key].actions.response_header_action

      content {
        header_action = local.cdn_frontdoor_rule[each.key].actions.response_header_action[response_header_action.key].header_action
        header_name   = local.cdn_frontdoor_rule[each.key].actions.response_header_action[response_header_action.key].header_name
        value         = local.cdn_frontdoor_rule[each.key].actions.response_header_action[response_header_action.key].value
      }
    }
  }

  dynamic "conditions" {
    for_each = local.cdn_frontdoor_rule[each.key].conditions == null ? [] : [0]

    content {
      dynamic "remote_address_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.remote_address_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.remote_address_condition[remote_address_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.remote_address_condition[remote_address_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.remote_address_condition[remote_address_condition.key].match_values
        }
      }

      dynamic "request_method_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.request_method_condition

        content {
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.request_method_condition[request_method_condition.key].match_values
          operator         = local.cdn_frontdoor_rule[each.key].conditions.request_method_condition[request_method_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.request_method_condition[request_method_condition.key].negate_condition
        }
      }

      dynamic "query_string_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.query_string_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.query_string_condition[query_string_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.query_string_condition[query_string_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.query_string_condition[query_string_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.query_string_condition[query_string_condition.key].transforms
        }
      }

      dynamic "post_args_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.post_args_condition

        content {
          post_args_name   = local.cdn_frontdoor_rule[each.key].conditions.post_args_condition[post_args_condition.key].post_args_name
          operator         = local.cdn_frontdoor_rule[each.key].conditions.post_args_condition[post_args_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.post_args_condition[post_args_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.post_args_condition[post_args_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.post_args_condition[post_args_condition.key].transforms
        }
      }

      dynamic "request_uri_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.request_uri_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.request_uri_condition[request_uri_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.request_uri_condition[request_uri_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.request_uri_condition[request_uri_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.request_uri_condition[request_uri_condition.key].transforms
        }
      }

      dynamic "request_header_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.request_header_condition

        content {
          header_name      = local.cdn_frontdoor_rule[each.key].conditions.request_header_condition[request_header_condition.key].header_name
          operator         = local.cdn_frontdoor_rule[each.key].conditions.request_header_condition[request_header_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.request_header_condition[request_header_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.request_header_condition[request_header_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.request_header_condition[request_header_condition.key].transforms
        }
      }

      dynamic "request_body_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.request_body_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.request_body_condition[request_body_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.request_body_condition[request_body_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.request_body_condition[request_body_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.request_body_condition[request_body_condition.key].transforms
        }
      }

      dynamic "request_scheme_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.request_scheme_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.request_scheme_condition[request_scheme_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.request_scheme_condition[request_scheme_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.request_scheme_condition[request_scheme_condition.key].match_values
        }
      }

      dynamic "url_path_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.url_path_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.url_path_condition[url_path_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.url_path_condition[url_path_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.url_path_condition[url_path_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.url_path_condition[url_path_condition.key].transforms
        }
      }

      dynamic "url_file_extension_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.url_file_extension_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.url_file_extension_condition[url_file_extension_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.url_file_extension_condition[url_file_extension_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.url_file_extension_condition[url_file_extension_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.url_file_extension_condition[url_file_extension_condition.key].transforms
        }
      }

      dynamic "url_filename_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.url_filename_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.url_filename_condition[url_filename_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.url_filename_condition[url_filename_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.url_filename_condition[url_filename_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.url_filename_condition[url_filename_condition.key].transforms
        }
      }

      dynamic "http_version_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.http_version_condition

        content {
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.http_version_condition[http_version_condition.key].match_values
          operator         = local.cdn_frontdoor_rule[each.key].conditions.http_version_condition[http_version_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.http_version_condition[http_version_condition.key].negate_condition
        }
      }

      dynamic "cookies_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.cookies_condition

        content {
          cookie_name      = local.cdn_frontdoor_rule[each.key].conditions.cookies_condition[cookies_condition.key].cookie_name
          operator         = local.cdn_frontdoor_rule[each.key].conditions.cookies_condition[cookies_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.cookies_condition[cookies_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.cookies_condition[cookies_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.cookies_condition[cookies_condition.key].transforms
        }
      }

      dynamic "is_device_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.is_device_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.is_device_condition[is_device_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.is_device_condition[is_device_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.is_device_condition[is_device_condition.key].match_values
        }
      }

      dynamic "socket_address_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.socket_address_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.socket_address_condition[socket_address_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.socket_address_condition[socket_address_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.socket_address_condition[socket_address_condition.key].match_values
        }
      }

      dynamic "client_port_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.client_port_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.client_port_condition[client_port_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.client_port_condition[client_port_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.client_port_condition[client_port_condition.key].match_values
        }
      }

      dynamic "server_port_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.server_port_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.client_port_condition[server_port_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.client_port_condition[server_port_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.client_port_condition[server_port_condition.key].match_values
        }
      }

      dynamic "host_name_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.host_name_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.host_name_condition[host_name_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.host_name_condition[host_name_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.host_name_condition[host_name_condition.key].match_values
          transforms       = local.cdn_frontdoor_rule[each.key].conditions.host_name_condition[host_name_condition.key].transforms
        }
      }

      dynamic "ssl_protocol_condition" {
        for_each = local.cdn_frontdoor_rule[each.key].conditions.ssl_protocol_condition

        content {
          operator         = local.cdn_frontdoor_rule[each.key].conditions.ssl_protocol_condition[ssl_protocol_condition.key].operator
          negate_condition = local.cdn_frontdoor_rule[each.key].conditions.ssl_protocol_condition[ssl_protocol_condition.key].negate_condition
          match_values     = local.cdn_frontdoor_rule[each.key].conditions.ssl_protocol_condition[ssl_protocol_condition.key].match_values
        }
      }
    }
  }
}

resource "azurerm_cdn_frontdoor_secret" "cdn_frontdoor_secret" {
  for_each = var.cdn_frontdoor_secret

  name                     = local.cdn_frontdoor_secret[each.key].name == "" ? each.key : local.cdn_frontdoor_secret[each.key].name
  cdn_frontdoor_profile_id = local.cdn_frontdoor_secret[each.key].cdn_frontdoor_profile_id

  secret {
    customer_certificate {
      key_vault_certificate_id = local.cdn_frontdoor_secret[each.key].secret.customer_certificate.key_vault_certificate_id
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

  dynamic "custom_rule" {
    for_each = local.cdn_frontdoor_firewall_policy[each.key].custom_rule

    content {
      name                           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].name == "" ? custom_rule.key : local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].name
      action                         = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].action
      enabled                        = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].enabled
      priority                       = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].priority
      type                           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].type
      rate_limit_duration_in_minutes = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].rate_limit_duration_in_minutes
      rate_limit_threshold           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].rate_limit_threshold

      dynamic "match_condition" {
        for_each = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition

        content {
          match_variable     = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].match_variable
          match_values       = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].match_values
          operator           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].operator
          selector           = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].selector
          negation_condition = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].negation_condition
          transforms         = local.cdn_frontdoor_firewall_policy[each.key].custom_rule[custom_rule.key].match_condition[match_condition.key].transforms
        }
      }
    }
  }

  dynamic "managed_rule" {
    for_each = local.cdn_frontdoor_firewall_policy[each.key].managed_rule

    content {
      type    = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].type
      version = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].version
      action  = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].action

      dynamic "exclusion" {
        for_each = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].exclusion

        content {
          match_variable = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].exclusion[exclusion.key].match_variable
          operator       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].exclusion[exclusion.key].operator
          selector       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].exclusion[exclusion.key].selector
        }
      }

      dynamic "override" {
        for_each = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override

        content {
          rule_group_name = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule_group_name

          dynamic "exclusion" {
            for_each = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].exclusion

            content {
              match_variable = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].exclusion[exclusion.key].match_variable
              operator       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].exclusion[exclusion.key].operator
              selector       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].exclusion[exclusion.key].selector
            }
          }

          dynamic "rule" {
            for_each = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule

            content {
              rule_id = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].rule_id
              action  = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].action
              enabled = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].enabled

              dynamic "exclusion" {
                for_each = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].exclusion

                content {
                  match_variable = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].exclusion[exclusion.key].match_variable
                  operator       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].exclusion[exclusion.key].operator
                  selector       = local.cdn_frontdoor_firewall_policy[each.key].managed_rule[managed_rule.key].override[override.key].rule[rule.key].exclusion[exclusion.key].selector
                }
              }
            }
          }
        }
      }
    }
  }

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
