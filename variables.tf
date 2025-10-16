variable "cdn_profile" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "cdn_endpoint" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "cdn_endpoint_custom_domain" {
  type        = any
  default     = {}
  description = "resource definition, default settings are defined within locals and merged with var settings"
}
variable "cdn_frontdoor_profile" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_origin_group" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_origin" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_endpoint" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_custom_domain" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_route" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_rule_set" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_rule" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_secret" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_firewall_policy" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "cdn_frontdoor_security_policy" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

locals {
  default = {
    // resource definition
    cdn_profile = {
      name = ""
      tags = {}
    }
    cdn_endpoint = {
      name                          = ""
      is_http_allowed               = null
      is_https_allowed              = null
      is_compression_enabled        = null
      querystring_caching_behaviour = null
      optimization_type             = null
      origin_host_header            = null
      origin = {
        name       = ""
        http_port  = null
        https_port = null
      }
      geo_filter = {
        action = "Block" // define default
      }
      delivery_rule = {
        name = ""
        cache_expiration_action = {
          duration = null
        }
        cache_key_query_string_action = {
          parameters = null
        }
        cookies_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        device_condition = {
          operator         = null
          negate_condition = null
        }
        http_version_condition = {
          operator         = null
          negate_condition = null
        }
        modify_request_header_action = {
          value = null
        }
        modify_response_header_action = {
          value = null
        }
        post_arg_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        query_string_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        remote_address_condition = {
          negate_condition = null
          match_values     = null
        }
        request_body_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        request_header_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        request_method_condition = {
          negate_condition = null
          match_values     = null
        }
        request_scheme_condition = {
          negate_condition = null
          match_values     = null
        }
        request_uri_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        url_file_extension_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        url_file_name_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        url_path_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        url_redirect_action = {
          protocol     = null
          hostname     = null
          path         = null
          fragment     = null
          query_string = null
        }
        url_rewrite_action = {
          preserve_unmatched_path = null
        }
      }
      global_delivery_rule = {
        cache_expiration_action = {
          duration = null
        }
        cache_key_query_string_action = {
          parameters = null
        }
        modify_request_header_action = {
          name  = ""
          value = null
        }
        modify_response_header_action = {
          name  = ""
          value = null
        }
        url_redirect_action = {
          protocol     = null
          hostname     = null
          path         = null
          fragment     = null
          query_string = null
        }
        url_rewrite_action = {
          preserve_unmatched_path = null
        }
      }
      tags = {}
    }
    cdn_endpoint_custom_domain = {
      name = ""
      cdn_managed_https = {
        tls_version = null
      }
      user_managed_https = {
        key_vault_secret_id = null //required
        tls_version         = null
      }
    }
    cdn_frontdoor_profile = {
      name                     = ""
      sku_name                 = "Standard_AzureFrontDoor"
      response_timeout_seconds = null
      tags                     = {}
    }
    cdn_frontdoor_origin_group = {
      name                                                      = ""
      restore_traffic_time_to_healed_or_new_endpoint_in_minutes = null
      session_affinity_enabled                                  = null
      load_balancing = {
        additional_latency_in_milliseconds = null
        sample_size                        = null
        successful_samples_required        = null
      }
      health_probe = {
        request_type = null
        path         = null
      }
    }
    cdn_frontdoor_origin = {
      name                           = ""
      certificate_name_check_enabled = true // define default
      enabled                        = true // created origin should be enabled by default
      http_port                      = null
      https_port                     = null
      origin_host_header             = null
      priority                       = null
      weight                         = null
      private_link = {
        request_message = null
        target_type     = null
      }
    }
    cdn_frontdoor_endpoint = {
      name    = ""
      enabled = null
      tags    = {}
    }
    cdn_frontdoor_custom_domain = {
      name        = ""
      dns_zone_id = null
      tls = {
        certificate_type        = null
        minimum_tls_version     = null
        cdn_frontdoor_secret_id = null
      }
    }
    cdn_frontdoor_route = {
      name                            = ""
      forwarding_protocol             = null
      patterns_to_match               = ["/*"]            // define default
      supported_protocols             = ["Http", "Https"] // define default match all
      cdn_frontdoor_custom_domain_ids = null
      cdn_frontdoor_origin_path       = null
      cdn_frontdoor_rule_set_ids      = null
      enabled                         = null
      https_redirect_enabled          = null
      link_to_default_domain          = false // disable link to default domain
      cache = {
        query_string_caching_behavior = null
        query_strings                 = null
        compression_enabled           = null
        content_types_to_compress     = null
      }
    }
    cdn_frontdoor_rule_set = {
      name = ""
    }
    cdn_frontdoor_rule = {
      name              = ""
      behavior_on_match = "Stop" // defined default
      actions = {
        url_rewrite_action = {
          preserve_unmatched_path = null
        }
        url_redirect_action = {
          redirect_type        = "Found" // defined default
          redirect_protocol    = "Https" // defined default
          destination_path     = null
          query_string         = null
          destination_fragment = null
        }
        route_configuration_override_action = {
          cache_duration                = null
          cdn_frontdoor_origin_group_id = null
          forwarding_protocol           = null
          query_string_caching_behavior = null
          query_string_parameters       = null
          compression_enabled           = null
          cache_behavior                = null
        }
        request_header_action = {
          value = null
        }
        response_header_action = {
          value = null
        }
      }
      conditions = {
        remote_address_condition = {
          operator         = null
          negate_condition = null
          match_values     = null
        }
        request_method_condition = {
          operator         = null
          negate_condition = null
        }
        query_string_condition = {
          operator         = null
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        post_args_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        request_uri_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        request_header_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        request_body_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        request_scheme_condition = {
          operator         = null
          negate_condition = null
          match_values     = null
        }
        url_path_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        url_file_extension_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        url_filename_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        http_version_condition = {
          operator         = null
          negate_condition = null
        }
        cookies_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        is_device_condition = {
          operator         = null
          negate_condition = null
          match_values     = null
        }
        socket_address_condition = {
          operator         = null
          negate_condition = null
          match_values     = null
        }
        client_port_condition = {
          negate_condition = null
          match_values     = null
        }
        server_port_condition = {
          negate_condition = null
        }
        host_name_condition = {
          negate_condition = null
          match_values     = null
          transforms       = null
        }
        ssl_protocol_condition = {
          operator         = null
          negate_condition = null
        }
      }
    }
    cdn_frontdoor_secret = {
      name = ""
    }
    cdn_frontdoor_firewall_policy = {
      name                              = ""
      enabled                           = null
      mode                              = "Prevention" // define default
      redirect_url                      = null
      custom_block_response_status_code = null
      custom_block_response_body        = null
      custom_rule = {
        name                           = ""
        action                         = "Block" // define default
        enabled                        = null
        priority                       = null
        rate_limit_duration_in_minutes = null
        rate_limit_threshold           = null
        match_condition = {
          match_values       = [] // define default
          selector           = null
          negation_condition = null
          transforms         = []
        }
      }
      managed_rule = {
        action    = "Block" // define default
        exclusion = {}
        override = {
          exclusion = {}
          rule = {
            enabled   = true // defined override should be enabled
            exclusion = {}
          }
        }
      }
      tags = {}
    }
    cdn_frontdoor_security_policy = {
      name = ""
      security_policies = {
        firewall = {
          association = {
            patterns_to_match = ["/*"]
            domain            = {}
          }
        }
      }
    }
  }

  // compare and merge custom and default values
  cdn_endpoint_values = {
    for cdn_endpoint in keys(var.cdn_endpoint) :
    cdn_endpoint => merge(local.default.cdn_endpoint, var.cdn_endpoint[cdn_endpoint])
  }
  cdn_endpoint_custom_domain_values = {
    for cdn_endpoint_custom_domain in keys(var.cdn_endpoint_custom_domain) :
    cdn_endpoint_custom_domain => merge(local.default.cdn_endpoint_custom_domain, var.cdn_endpoint_custom_domain[cdn_endpoint_custom_domain])
  }
  cdn_frontdoor_origin_group_values = {
    for cdn_frontdoor_origin_group in keys(var.cdn_frontdoor_origin_group) :
    cdn_frontdoor_origin_group => merge(local.default.cdn_frontdoor_origin_group, var.cdn_frontdoor_origin_group[cdn_frontdoor_origin_group])
  }
  cdn_frontdoor_origin_values = {
    for cdn_frontdoor_origin in keys(var.cdn_frontdoor_origin) :
    cdn_frontdoor_origin => merge(local.default.cdn_frontdoor_origin, var.cdn_frontdoor_origin[cdn_frontdoor_origin])
  }
  cdn_frontdoor_custom_domain_values = {
    for cdn_frontdoor_custom_domain in keys(var.cdn_frontdoor_custom_domain) :
    cdn_frontdoor_custom_domain => merge(local.default.cdn_frontdoor_custom_domain, var.cdn_frontdoor_custom_domain[cdn_frontdoor_custom_domain])
  }
  cdn_frontdoor_route_values = {
    for cdn_frontdoor_route in keys(var.cdn_frontdoor_route) :
    cdn_frontdoor_route => merge(local.default.cdn_frontdoor_route, var.cdn_frontdoor_route[cdn_frontdoor_route])
  }
  cdn_frontdoor_rule_values = {
    for cdn_frontdoor_rule in keys(var.cdn_frontdoor_rule) :
    cdn_frontdoor_rule => merge(local.default.cdn_frontdoor_rule, var.cdn_frontdoor_rule[cdn_frontdoor_rule])
  }
  cdn_frontdoor_firewall_policy_values = {
    for cdn_frontdoor_firewall_policy in keys(var.cdn_frontdoor_firewall_policy) :
    cdn_frontdoor_firewall_policy => merge(local.default.cdn_frontdoor_firewall_policy, var.cdn_frontdoor_firewall_policy[cdn_frontdoor_firewall_policy])
  }
  cdn_frontdoor_security_policy_values = {
    for cdn_frontdoor_security_policy in keys(var.cdn_frontdoor_security_policy) :
    cdn_frontdoor_security_policy => merge(local.default.cdn_frontdoor_security_policy, var.cdn_frontdoor_security_policy[cdn_frontdoor_security_policy])
  }

  // deep merge of all custom and default values
  cdn_profile = {
    for cdn_profile in keys(var.cdn_profile) :
    cdn_profile => merge(local.default.cdn_profile, var.cdn_profile[cdn_profile])
  }
  cdn_endpoint = {
    for cdn_endpoint in keys(var.cdn_endpoint) :
    cdn_endpoint => merge(
      local.cdn_endpoint_values[cdn_endpoint],
      {
        for config in ["origin", "geo_filter"] :
        config => keys(local.cdn_endpoint_values[cdn_endpoint][config]) == keys(local.default.cdn_endpoint[config]) ? {} : {
          for key in keys(local.cdn_endpoint_values[cdn_endpoint][config]) :
          key => merge(local.default.cdn_endpoint[config], local.cdn_endpoint_values[cdn_endpoint][config][key])
        }
      },
      {
        for config in ["delivery_rule"] :
        config => keys(local.cdn_endpoint_values[cdn_endpoint][config]) == keys(local.default.cdn_endpoint[config]) ? {} : {
          for key in keys(local.cdn_endpoint_values[cdn_endpoint][config]) :
          key => merge(
            merge(local.default.cdn_endpoint[config], local.cdn_endpoint_values[cdn_endpoint][config][key]),
            {
              for subconfig in [
                "cache_expiration_action",
                "cache_key_query_string_action",
                "cookies_condition",
                "device_condition",
                "http_version_condition",
                "modify_request_header_action",
                "modify_response_header_action",
                "post_arg_condition",
                "query_string_condition",
                "remote_address_condition",
                "request_body_condition",
                "request_header_condition",
                "request_method_condition",
                "request_scheme_condition",
                "request_uri_condition",
                "url_file_extension_condition",
                "url_file_name_condition",
                "url_path_condition",
                "url_redirect_action",
                "url_rewrite_action",
              ] :
              subconfig => lookup(local.cdn_endpoint_values[cdn_endpoint][config][key], subconfig, {}) == {} ? null : merge(local.default.cdn_endpoint[config][subconfig], local.cdn_endpoint_values[cdn_endpoint][config][key][subconfig])
            }
          )
        }
      },
      {
        for config in ["global_delivery_rule"] :
        config => lookup(var.cdn_endpoint[cdn_endpoint], config, {}) == {} ? null : {
          for subconfig in [
            "cache_expiration_action",
            "cache_key_query_string_action",
            "modify_request_header_action",
            "modify_response_header_action",
            "url_redirect_action",
            "url_rewrite_action",
          ] :
          subconfig => lookup(local.cdn_endpoint_values[cdn_endpoint][config], subconfig, {}) == {} ? null : merge(local.default.cdn_endpoint[config][subconfig], local.cdn_endpoint_values[cdn_endpoint][config][subconfig])
        }
      }
    )
  }
  cdn_endpoint_custom_domain = {
    for cdn_endpoint_custom_domain in keys(var.cdn_endpoint_custom_domain) :
    cdn_endpoint_custom_domain => merge(
      local.cdn_endpoint_custom_domain_values[cdn_endpoint_custom_domain],
      {
        for config in ["cdn_managed_https", "user_managed_https"] :
        config => lookup(var.cdn_endpoint_custom_domain[cdn_endpoint_custom_domain], config, {}) == {} ? null : merge(local.default.cdn_endpoint_custom_domain[config], local.cdn_endpoint_custom_domain_values[cdn_endpoint_custom_domain][config])
      }
    )
  }
  cdn_frontdoor_profile = {
    for cdn_frontdoor_profile in keys(var.cdn_frontdoor_profile) :
    cdn_frontdoor_profile => merge(local.default.cdn_frontdoor_profile, var.cdn_frontdoor_profile[cdn_frontdoor_profile])
  }
  cdn_frontdoor_origin_group = {
    for cdn_frontdoor_origin_group in keys(var.cdn_frontdoor_origin_group) :
    cdn_frontdoor_origin_group => merge(
      local.cdn_frontdoor_origin_group_values[cdn_frontdoor_origin_group],
      {
        for config in ["load_balancing", "health_probe"] :
        config => merge(local.default.cdn_frontdoor_origin_group[config], local.cdn_frontdoor_origin_group_values[cdn_frontdoor_origin_group][config])
      }
    )
  }
  cdn_frontdoor_origin = {
    for cdn_frontdoor_origin in keys(var.cdn_frontdoor_origin) :
    cdn_frontdoor_origin => merge(
      local.cdn_frontdoor_origin_values[cdn_frontdoor_origin],
      {
        for config in ["private_link"] :
        config => merge(local.default.cdn_frontdoor_origin[config], local.cdn_frontdoor_origin_values[cdn_frontdoor_origin][config])
      }
    )
  }
  cdn_frontdoor_endpoint = {
    for cdn_frontdoor_endpoint in keys(var.cdn_frontdoor_endpoint) :
    cdn_frontdoor_endpoint => merge(local.default.cdn_frontdoor_endpoint, var.cdn_frontdoor_endpoint[cdn_frontdoor_endpoint])
  }
  cdn_frontdoor_custom_domain = {
    for cdn_frontdoor_custom_domain in keys(var.cdn_frontdoor_custom_domain) :
    cdn_frontdoor_custom_domain => merge(
      local.cdn_frontdoor_custom_domain_values[cdn_frontdoor_custom_domain],
      {
        for config in ["tls"] :
        config => merge(local.default.cdn_frontdoor_custom_domain[config], local.cdn_frontdoor_custom_domain_values[cdn_frontdoor_custom_domain][config])
      }
    )
  }
  cdn_frontdoor_route = {
    for cdn_frontdoor_route in keys(var.cdn_frontdoor_route) :
    cdn_frontdoor_route => merge(
      local.cdn_frontdoor_route_values[cdn_frontdoor_route],
      {
        for config in ["cache"] :
        config => merge(local.default.cdn_frontdoor_route[config], local.cdn_frontdoor_route_values[cdn_frontdoor_route][config])
      }
    )
  }
  cdn_frontdoor_rule_set = {
    for cdn_frontdoor_rule_set in keys(var.cdn_frontdoor_rule_set) :
    cdn_frontdoor_rule_set => merge(local.default.cdn_frontdoor_rule_set, var.cdn_frontdoor_rule_set[cdn_frontdoor_rule_set])
  }
  cdn_frontdoor_rule = {
    for cdn_frontdoor_rule in keys(var.cdn_frontdoor_rule) :
    cdn_frontdoor_rule => merge(
      local.cdn_frontdoor_rule_values[cdn_frontdoor_rule],
      {
        for config in ["actions"] :
        config => merge(
          {
            for subconfig in ["route_configuration_override_action"] :
            subconfig => lookup(local.cdn_frontdoor_rule_values[cdn_frontdoor_rule][config], subconfig, {}) == {} ? null : merge(local.default.cdn_frontdoor_rule[config][subconfig], local.cdn_frontdoor_rule_values[cdn_frontdoor_rule][config][subconfig])
          },
          {
            for subconfig in [
              "url_rewrite_action",
              "url_redirect_action",
              "request_header_action",
              "response_header_action"
            ] :
            subconfig => lookup(local.cdn_frontdoor_rule_values[cdn_frontdoor_rule][config], subconfig, {}) == {} ? {} : {
              for key in keys(local.cdn_frontdoor_rule_values[cdn_frontdoor_rule][config][subconfig]) :
              key => merge(local.default.cdn_frontdoor_rule[config][subconfig], local.cdn_frontdoor_rule_values[cdn_frontdoor_rule][config][subconfig][key])
            }
          }
        )
      },
      {
        for config in ["conditions"] :
        config => lookup(var.cdn_frontdoor_rule[cdn_frontdoor_rule], config, {}) == {} ? null : {
          for subconfig in [
            "remote_address_condition",
            "request_method_condition",
            "query_string_condition",
            "post_args_condition",
            "request_uri_condition",
            "request_header_condition",
            "request_body_condition",
            "request_scheme_condition",
            "url_path_condition",
            "url_file_extension_condition",
            "url_filename_condition",
            "http_version_condition",
            "cookies_condition",
            "is_device_condition",
            "socket_address_condition",
            "client_port_condition",
            "server_port_condition",
            "host_name_condition",
            "ssl_protocol_condition",
          ] :
          subconfig => lookup(local.cdn_frontdoor_rule_values[cdn_frontdoor_rule][config], subconfig, {}) == {} ? {} : {
            for key in keys(local.cdn_frontdoor_rule_values[cdn_frontdoor_rule][config][subconfig]) :
            key => merge(local.default.cdn_frontdoor_rule[config][subconfig], local.cdn_frontdoor_rule_values[cdn_frontdoor_rule][config][subconfig][key])
          }
        }
      }
    )
  }
  cdn_frontdoor_secret = {
    for cdn_frontdoor_secret in keys(var.cdn_frontdoor_secret) :
    cdn_frontdoor_secret => merge(local.default.cdn_frontdoor_secret, var.cdn_frontdoor_secret[cdn_frontdoor_secret])
  }
  cdn_frontdoor_firewall_policy = {
    for cdn_frontdoor_firewall_policy in keys(var.cdn_frontdoor_firewall_policy) :
    cdn_frontdoor_firewall_policy => merge(
      local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy],
      {
        for config in ["custom_rule"] :
        config => keys(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config]) == keys(local.default.cdn_frontdoor_firewall_policy[config]) ? {} : {
          for key in keys(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config]) :
          key => merge(
            merge(local.default.cdn_frontdoor_firewall_policy[config], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key]),
            {
              for subconfig in ["match_condition"] :
              subconfig => keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key], subconfig, {})) == keys(local.default.cdn_frontdoor_firewall_policy[config][subconfig]) ? {} : {
                for subkey in keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key], subconfig, {})) :
                subkey => merge(local.default.cdn_frontdoor_firewall_policy[config][subconfig], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey])
              }
            }
          )
        }
      },
      {
        for config in ["managed_rule"] :
        config => keys(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config]) == keys(local.default.cdn_frontdoor_firewall_policy[config]) ? {} : {
          for key in keys(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config]) :
          key => merge(
            merge(local.default.cdn_frontdoor_firewall_policy[config], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key]),
            {
              for subconfig in ["override"] :
              subconfig => keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key], subconfig, {})) == keys(local.default.cdn_frontdoor_firewall_policy[config][subconfig]) ? {} : {
                for subkey in keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key], subconfig, {})) :
                subkey => merge(
                  merge(local.default.cdn_frontdoor_firewall_policy[config][subconfig], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey]),
                  {
                    for subsubconfig in ["rule"] :
                    subsubconfig => keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey], subsubconfig, {})) == keys(local.default.cdn_frontdoor_firewall_policy[config][subconfig][subsubconfig]) ? {} : {
                      for subsubkey in keys(lookup(local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey], subsubconfig, {})) :
                      subsubkey => merge(local.default.cdn_frontdoor_firewall_policy[config][subconfig][subsubconfig], local.cdn_frontdoor_firewall_policy_values[cdn_frontdoor_firewall_policy][config][key][subconfig][subkey][subsubconfig][subsubkey])
                    }
                  }
                )
              }
            },
          )
        }
      }
    )
  }
  cdn_frontdoor_security_policy = {
    for cdn_frontdoor_security_policy in keys(var.cdn_frontdoor_security_policy) :
    cdn_frontdoor_security_policy => merge(
      local.cdn_frontdoor_security_policy_values[cdn_frontdoor_security_policy],
      {
        for config in ["security_policies"] :
        config => merge(
          merge(local.default.cdn_frontdoor_security_policy[config], local.cdn_frontdoor_security_policy_values[cdn_frontdoor_security_policy][config]),
          {
            for subconfig in ["firewall"] :
            subconfig => merge(
              merge(local.default.cdn_frontdoor_security_policy[config][subconfig], local.cdn_frontdoor_security_policy_values[cdn_frontdoor_security_policy][config][subconfig]),
              {
                for subsubconfig in ["association"] :
                subsubconfig => merge(local.default.cdn_frontdoor_security_policy[config][subconfig][subsubconfig], local.cdn_frontdoor_security_policy_values[cdn_frontdoor_security_policy][config][subconfig][subsubconfig])
              }
            )
          }
        )
      }
    )
  }
}
