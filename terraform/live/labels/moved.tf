# One-off: the corthx migration adopted these resources under a temporary
# module name. This moves them back to the original one. Delete this file
# once the merge request is applied.
moved {
  from = module.project_labels
  to   = module.labels
}
