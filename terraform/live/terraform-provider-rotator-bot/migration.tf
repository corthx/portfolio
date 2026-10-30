# One-off migration for the curs3_w4ll -> corthx namespace rename: `project`
# forces replacement, so the bot is forgotten at its old address and adopted
# at the new one instead of being recreated. Delete this file once the merge
# request is applied.
#
# The access token is the exception: an imported token has no value, so a new
# one is created and written to the CI variable, and the old one is revoked.
# The resources are listed one by one because a `removed` block on the whole
# module would override the token's `destroy = true`. The avatar upload re-runs
# with the new token.
#
# The token variable moves from the "*" scope to the terraform-provider-bot
# environment, the only jobs that use it: the "*" copy is deleted and the
# hand-made copy already at that scope is adopted.

removed {
  from = module.bot.gitlab_project_service_account_access_token.rotating

  lifecycle {
    destroy = true
  }
}

removed {
  from = module.bot.gitlab_project_service_account.service_account

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.bot.gitlab_project_membership.gitlab_membership

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.bot.gitlab_project_variable.bot_token

  lifecycle {
    destroy = true
  }
}

removed {
  from = module.bot.null_resource.avatar

  lifecycle {
    destroy = false
  }
}

import {
  to = module.service_account.gitlab_project_service_account.service_account[0]
  id = "corthx/portfolio:43029706"
}

import {
  to = module.service_account.gitlab_project_membership.gitlab_membership[0]
  id = "corthx/portfolio:43029706"
}

import {
  to = module.service_account.gitlab_project_variable.bot_token[0]
  id = "corthx/portfolio:GITLAB_TOFU_PROVIDER_ROTATOR_TOKEN:terraform-provider-bot"
}
