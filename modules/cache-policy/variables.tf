variable "name" {
  description = ""
  type        = string
}

variable "description" {
  description = ""
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "default_ttl" {
  description = ""
  type        = number
  default     = 86400
  nullable    = false
}

variable "min_ttl" {
  description = ""
  type        = number
  default     = 1
  nullable    = false
}

variable "max_ttl" {
  description = "Defaults to `31536000` (one year)."
  type        = number
  default     = 31536000
  nullable    = false
}

variable "supported_compression_formats" {
  description = "Valid values are `BROTLI` and `GZIP`."
  type        = set(string)
  default     = ["BROTLI", "GZIP"]
  nullable    = false

  validation {
    condition = alltrue([
      for format in var.supported_compression_formats :
      contains(["BROTLI", "GZIP"], format)
    ])
    error_message = "Valid values are `BROTLI` and `GZIP`."
  }
}

variable "cache_keys_in_cookies" {
  description = ""
  type = object({
    behavior = optional(string, "NONE")
    items    = optional(set(string), [])
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["NONE", "WHITELIST", "BLACKLIST", "ALL"], var.cache_keys_in_cookies.behavior)
    error_message = "Valid values for `behavior` are `NONE`, `WHITELIST`, `BLACKLIST` and `ALL`."
  }
}

variable "cache_keys_in_headers" {
  description = ""
  type = object({
    behavior = optional(string, "NONE")
    items    = optional(set(string), [])
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["NONE", "WHITELIST"], var.cache_keys_in_headers.behavior)
    error_message = "Valid values for `behavior` are `NONE` and `WHITELIST`."
  }
}

variable "cache_keys_in_query_strings" {
  description = ""
  type = object({
    behavior = optional(string, "NONE")
    items    = optional(set(string), [])
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["NONE", "WHITELIST", "BLACKLIST", "ALL"], var.cache_keys_in_query_strings.behavior)
    error_message = "Valid values for `behavior` are `NONE`, `WHITELIST`, `BLACKLIST` and `ALL`."
  }
}
