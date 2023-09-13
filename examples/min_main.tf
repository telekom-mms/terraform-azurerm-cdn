module "cdn" {
  source = "registry.terraform.io/telekom-mms/cdn/azurerm"
  cdn_profile = {
    cdnp-mms = {
      location            = "westeurope"
      resource_group_name = "rg-mms-github"
      sku                 = "Standard_Microsoft"
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
    }
  }
  cdn_endpoint_custom_domain = {
    telekom-mms = {
      cdn_endpoint_id = module.cdn.cdn_endpoint["cdne-mms"].id
      host_name       = "telekom-mms.com"
    }
  }
  cdn_frontdoor_profile = {
    afd-mms = {
      resource_group_name = "rg-mms-github"
    }
  }
  cdn_frontdoor_origin_group = {
    non-backend = {
      cdn_frontdoor_profile_id = module.cdn.cdn_frontdoor_profile["afd-mms"].id
    }
  }
  cdn_frontdoor_origin = {
    non-backend = {
      cdn_frontdoor_origin_group_id = module.cdn.cdn_frontdoor_origin_group["non-backend"].id
      host_name                     = "0.0.0.0"
    }
  }
  cdn_frontdoor_endpoint = {
    "fde-non-backend" = {
      cdn_frontdoor_profile_id = module.cdn.cdn_frontdoor_profile["afd-mms"].id
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
      cdn_frontdoor_endpoint_id       = module.cdn.cdn_frontdoor_endpoint["fde-non-backend"].id
      cdn_frontdoor_origin_group_id   = module.cdn.cdn_frontdoor_origin_group["non-backend"].id
      cdn_frontdoor_origin_ids        = [module.cdn.cdn_frontdoor_origin["non-backend"].id]
      cdn_frontdoor_custom_domain_ids = [module.cdn.cdn_frontdoor_custom_domain["telekom-mms-com"].id]
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
    }
  }
  cdn_frontdoor_firewall_policy = {
    fdfpmms = {
      resource_group_name = "rg-mms-github"
      sku_name            = module.cdn.cdn_frontdoor_profile["afd-mms"].sku_name
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
