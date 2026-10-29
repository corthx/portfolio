terraform {
  required_version = "1.16.5"

  backend "http" {}

  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      # gitlab_project_service_account_access_token didn't exist before
      # 19.3.0 (19.1.0/19.2.0 had only the group-scoped token resource;
      # 19.0.0 had neither service account resource at all) — floor matches
      # the last of those to land, not just "19.x".
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

module "bot" {
  source  = "gitlab.com/corthx/service-account/gitlab"
  version = "0.0.1"

  gitlab_base_url = local.gitlab_base_url
  project         = "corthx/portfolio"
  name            = "Renovate Bot"
  username        = "portfolio-renovate-bot"
  access_level    = "maintainer"
  token_name      = "Renovate Bot Token used in Portfolio GitLab CI"
  token_scopes    = ["api"]

  token_rotate_before_days       = 14
  token_rotation_expiration_days = 180

  ci_variable_token_name        = "RENOVATE_TOKEN"
  ci_variable_token_hidden      = true
  ci_variable_token_description = "Token used by Renovate to authenticate on GitLab"
  ci_variable_email_name        = "RENOVATE_GIT_AUTHOR_EMAIL"
  ci_variable_email_description = "Email used by Renovate to commit"

  avatar_path = "${path.module}/avatar.png"
}
