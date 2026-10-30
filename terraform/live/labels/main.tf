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
  project = "corthx/portfolio"
}

provider "gitlab" {
  base_url = "https://gitlab.com"
}

module "project_labels" {
  source  = "gitlab.com/corthx/label/gitlab"
  version = "0.0.3"

  project = local.project

  labels = {
    "bug" = {
      description = "Something isn't working as expected",
      color       = "#d9534f",
    },
    "dependencies" = {
      description = "Related to dependency updates or version bumps",
      color       = "#0366d6",
    },
    "documentation" = {
      description = "Improvements or additions to docs",
      color       = "#0075ca",
    },
    "enhancement" = {
      description = "New feature or improvement to existing functionality",
      color       = "#5cb85c",
    },
    "scope::content" = {
      color = "#009966",
    },
    "scope::front" = {
      color = "#6699cc",
    },
    "scope::infra" = {
      color = "#ed9121",
    },
    "security" = {
      description = "Pull requests that address a security vulnerability",
      color       = "#ee0701",
    },
    "severity:critical" = {
      color = "#ff0000",
    },
    "severity:high" = {
      color = "#ed9121",
    },
    "severity:low" = {
      color = "#00b140",
    },
    "severity:moderate" = {
      color = "#eee600",
    },
    "tofu:apply" = {
      description = "Applying this label on MR exposes a manual apply for all lives",
      color       = "#7B42BC", # Terraform's brand purple
    },
    "tofu:plan" = {
      description = "Applying this label on MR triggers plan for all lives",
      color       = "#7B42BC", # Terraform's brand purple
    },
  }
}
