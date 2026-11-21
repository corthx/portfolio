terraform {
  required_version = ">=1.9, <2.0.0"

  backend "http" {}

  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "19.5.0"
    }
  }
}

provider "gitlab" {
  base_url = "https://gitlab.com"
}

module "boards" {
  source  = "gitlab.com/corthx/issue-board/gitlab"
  version = "0.0.3"

  scope   = "project"
  project = "corthx/portfolio"

  boards = {
    "Development" = {
      lists = ["bug", "scope::front", "scope::infra", "scope::content", "documentation"],
    },
  }
}
