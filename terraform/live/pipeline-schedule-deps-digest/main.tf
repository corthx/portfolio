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
