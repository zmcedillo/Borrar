terraform {
  required_providers {
    random = {
      source  = "registry.opentofu.org/hashicorp/random"
      version = "~> 3.5.0"
    }
    local = {
      source  = "registry.opentofu.org/hashicorp/local"
      version = "~> 2.4.0"
    }
  }
}

variable "api_secret_token" {
  type        = string
  description = "Token de API para integración con servicios externos" 
  sensitive   = true
}

resource "random_string" "app_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "local_file" "config_output" {
  content  = "App ID: app-${random_string.app_suffix.result}\nToken Configurado: ${var.api_secret_token}"
  filename = "${path.module}/app_config.txt"
}
