# One-off migration for the curs3_w4ll -> corthx namespace rename: `project`
# forces replacement, so the resources are forgotten at their old address and
# adopted at the new one instead of being recreated. Delete this file once the
# merge request is applied.

removed {
  from = module.labels

  lifecycle {
    destroy = false
  }
}

import {
  for_each = {
    "bug"               = 54229771
    "dependencies"      = 54229777
    "documentation"     = 54229767
    "enhancement"       = 54229773
    "scope::content"    = 54229769
    "scope::front"      = 54229770
    "scope::infra"      = 54229774
    "security"          = 54229778
    "severity:critical" = 54229768
    "severity:high"     = 54229776
    "severity:low"      = 54229772
    "severity:moderate" = 54229775
    "tofu:apply"        = 54229766
    "tofu:plan"         = 54229765
  }
  to = module.project_labels.gitlab_project_label.labels[each.key]
  id = "corthx/portfolio:${each.value}"
}
