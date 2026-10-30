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
  description   = "📦 Renovate"
  cron          = "0 */4 * * *" # every 4 hours, Paris time
  cron_timezone = "Europe/Paris"

  variables = {
    SCHEDULE_TASK = "renovate"
  }
}
