terraform {
  required_version = "1.16.5"

  backend "http" {}

  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "19.4.1"
    }
  }
}

locals {
  gitlab_base_url = "https://gitlab.com"
}

provider "gitlab" {
  base_url = local.gitlab_base_url
}

module "service_account" {
  source  = "gitlab.com/corthx/service-account/gitlab"
  version = "0.0.3"

  gitlab_base_url = local.gitlab_base_url
  project         = "corthx/portfolio"
  name            = "Terraform Provider Bot"
  username        = "portfolio-terraform-provider-bot"
  access_level    = "maintainer"
  token_name      = "Terraform Provider Bot Token used in Portfolio GitLab CI"
  token_scopes    = ["api"]

  token_rotate_before_days       = 14
  token_rotation_expiration_days = 180

  ci_variable_token_name        = "GITLAB_TOFU_PROVIDER_TOKEN"
  ci_variable_token_hidden      = true
  ci_variable_token_description = "Token used by CI to authenticate the Terraform provider"

  avatar_path = "${path.module}/avatar.png"
}
