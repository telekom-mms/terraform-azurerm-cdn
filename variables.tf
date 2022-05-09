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

locals {
  default = {
    # resource definition
    cdn_profile = {
      name = ""
      tags = {}
    }
    cdn_endpoint = {
      name                          = ""
      is_http_allowed               = true
      querystring_caching_behaviour = "IgnoreQueryString"
      tags                          = {}
    }
    cdn_endpoint_custom_domain = {
      name = ""
      cdn_managed_https = {
        certificate_type = ""
        tls_version      = null
      }
      user_managed_https = {
        key_vault_certificate_id = ""
        tls_version              = null
      }
      tags = {}
    }
  }

  # compare and merge custom and default values
  cdn_endpoint_custom_domain_values = {
    for cdn_endpoint_custom_domain in keys(var.cdn_endpoint_custom_domain) :
    cdn_endpoint_custom_domain => merge(local.default.cdn_endpoint_custom_domain, var.cdn_endpoint_custom_domain[cdn_endpoint_custom_domain])
  }

  # merge all custom and default values
  cdn_profile = {
    for cdn_profile in keys(var.cdn_profile) :
    cdn_profile => merge(local.default.cdn_profile, var.cdn_profile[cdn_profile])
  }
  cdn_endpoint = {
    for cdn_endpoint in keys(var.cdn_endpoint) :
    cdn_endpoint => merge(local.default.cdn_endpoint, var.cdn_endpoint[cdn_endpoint])
  }
  cdn_endpoint_custom_domain = {
    for cdn_endpoint_custom_domain in keys(var.cdn_endpoint_custom_domain) :
    cdn_endpoint_custom_domain => merge(
      local.cdn_endpoint_custom_domain_values[cdn_endpoint_custom_domain],
      {
        for config in ["cdn_managed_https", "user_managed_https"] :
        config => merge(local.default.cdn_endpoint_custom_domain[config], local.cdn_endpoint_custom_domain_values[cdn_endpoint_custom_domain][config])
      }
    )
  }
}
