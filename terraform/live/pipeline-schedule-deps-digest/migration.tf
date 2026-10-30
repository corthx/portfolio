# One-off migration for the curs3_w4ll -> corthx namespace rename: `project`
# forces replacement, so the resources are forgotten at their old address and
# adopted at the new one instead of being recreated. Delete this file once the
# merge request is applied.

removed {
  from = module.schedule

  lifecycle {
    destroy = false
  }
}

import {
  to = module.pipeline_schedule.gitlab_pipeline_schedule.schedule
  id = "corthx/portfolio:4474247"
}

import {
  to = module.pipeline_schedule.gitlab_pipeline_schedule_variable.schedule_variables["SCHEDULE_TASK"]
  id = "corthx/portfolio:4474247:SCHEDULE_TASK"
}
