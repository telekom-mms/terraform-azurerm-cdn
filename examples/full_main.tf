module "cdn" {
  source = "registry.terraform.io/telekom-mms/cdn/azurerm"
  cdn_profile = {
    cdnp-mms = {
      location            = "westeurope"
      resource_group_name = "rg-mms-github"
      sku                 = "Standard_Microsoft"
      tags = {
        project     = "mms-github"
        environment = terraform.workspace
        managed-by  = "terraform"
      }
    }
  }
  cdn_endpoint = {
    cdne-mms = {
      resource_group_name = module.cdn.cdn_profile["cdnp-mms"].resource_group_name
      location            = module.cdn.cdn_profile["cdnp-mms"].location
      profile_name        = module.cdn.cdn_profile["cdnp-mms"].name
      origin = {
        telekom-mms = {
          host_name = "origin.telekom-mms.com"
        }
      }
      global_delivery_rule = {
        cache_expiration_action = {
          behavior = "Override"
          duration = "00:05:00"
        }
      }
      tags = {
        project     = "mms-github"
        environment = terraform.workspace
        managed-by  = "terraform"
      }
    }
  }
  cdn_endpoint_custom_domain = {
    telekom-mms = {
      cdn_endpoint_id = module.cdn.cdn_endpoint["cdne-mms"].id
      host_name       = "telekom-mms.com"
      cdn_managed_https = {
        certificate_type = "Dedicated"
        protocol_type    = "ServerNameIndication"
      }
    }
  }
  cdn_frontdoor_profile = {
    afd-mms = {
      resource_group_name = "rg-mms-github"
      sku_name            = "Premium_AzureFrontDoor" // Premium because we want also managed WAF rules
      tags = {
        project     = "mms-github"
        environment = terraform.workspace
        managed-by  = "terraform"
      }
    }
  }
  cdn_frontdoor_origin_group = {
    non-backend = {
      cdn_frontdoor_profile_id = module.cdn.cdn_frontdoor_profile["afd-mms"].id
    }
  }
  cdn_frontdoor_origin = {
    non-backend = {
      cdn_frontdoor_origin_group_id  = module.cdn.cdn_frontdoor_origin_group["non-backend"].id
      host_name                      = "0.0.0.0"
      certificate_name_check_enabled = false
    }
  }
  cdn_frontdoor_endpoint = {
    non-backend = {
      name                     = "fde-non-backend"
      cdn_frontdoor_profile_id = module.cdn.cdn_frontdoor_profile["afd-mms"].id
      tags = {
        project     = "mms-github"
        environment = terraform.workspace
        managed-by  = "terraform"
      }
    }
  }
  cdn_frontdoor_custom_domain = {
    "telekom-mms-com" = {
      cdn_frontdoor_profile_id = module.cdn.cdn_frontdoor_profile["afd-mms"].id
      host_name                = "telekom-mms.com"
    }
  }
  cdn_frontdoor_route = {
    non-backend = {
      cdn_frontdoor_endpoint_id       = module.cdn.cdn_frontdoor_endpoint["non-backend"].id
      cdn_frontdoor_origin_group_id   = module.cdn.cdn_frontdoor_origin_group["non-backend"].id
      cdn_frontdoor_origin_ids        = [module.cdn.cdn_frontdoor_origin["non-backend"].id]
      cdn_frontdoor_custom_domain_ids = [module.cdn.cdn_frontdoor_custom_domain["telekom-mms-com"].id]
      cache = {
        query_string_caching_behavior = "IgnoreQueryString"
      }
    }
  }
  cdn_frontdoor_rule_set = {
    nonbackend = {
      cdn_frontdoor_profile_id = module.cdn.cdn_frontdoor_profile["afd-mms"].id
    }
  }
  cdn_frontdoor_rule = {
    rewrite = {
      cdn_frontdoor_rule_set_id = module.cdn.cdn_frontdoor_rule_set["nonbackend"].id
      order                     = 0
      actions = {
        url_redirect_action = {
          destination_hostname = "www.telekom-mms.com"
        }
      }
      conditions = {
        request_header_condition = {
          header_name  = "Host"
          match_values = ["telekom-mms.com"]
          operator     = "Equal"
        }
      }
    }
  }
  cdn_frontdoor_firewall_policy = {
    fdfpmms = {
      resource_group_name = "rg-mms-github"
      sku_name            = module.cdn.cdn_frontdoor_profile["afd-mms"].sku_name
      custom_rule = {
        frontend = {
          priority = 100
          type     = "MatchRule"
          match_condition = {
            ip_access = {
              match_values       = ["127.0.0.2"]
              match_variable     = "SocketAddr"
              operator           = "IPMatch"
              negation_condition = true
            }
          }
        }
      }
      managed_rule = {
        BotManagerRuleSet = {
          type    = "Microsoft_BotManagerRuleSet"
          version = "1.0"
        }
      }
      tags = {
        project     = "mms-github"
        environment = terraform.workspace
        managed-by  = "terraform"
      }
    }
  }
  cdn_frontdoor_security_policy = {
    default = {
      cdn_frontdoor_profile_id = module.cdn.cdn_frontdoor_profile["afd-mms"].id
      security_policies = {
        firewall = {
          cdn_frontdoor_firewall_policy_id = module.cdn.cdn_frontdoor_firewall_policy["fdfpmms"].id
          association = {
            domain = {
              "www-telekom-mms-com" = {
                cdn_frontdoor_domain_id = module.cdn.cdn_frontdoor_custom_domain["telekom-mms-com"].id
              }
            }
          }
        }
      }
    }
  }
}
