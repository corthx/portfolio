# One-off migration for the curs3_w4ll -> corthx namespace rename: `project`
# forces replacement, so the resources are forgotten at their old address and
# adopted at the new one instead of being recreated. Delete this file once the
# merge request is applied.

removed {
  from = module.boards

  lifecycle {
    destroy = false
  }
}

import {
  to = module.issue_boards.gitlab_project_issue_board.boards["Development"]
  id = "corthx/portfolio:11659886"
}
