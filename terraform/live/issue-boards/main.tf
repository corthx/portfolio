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
