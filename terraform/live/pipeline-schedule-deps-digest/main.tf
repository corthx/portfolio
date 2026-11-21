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

module "schedule" {
  source  = "gitlab.com/corthx/pipeline-schedule/gitlab"
  version = "0.0.3"

  project       = "corthx/portfolio"
  description   = "📋 Dependency digest"
  cron          = "30 9 * * 1" # every Monday 09:30, Paris time
  cron_timezone = "Europe/Paris"

  variables = {
    SCHEDULE_TASK = "deps-digest"
  }
}
