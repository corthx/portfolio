output "label_ids" {
  value       = module.project_labels.label_ids
  description = "Map of label name to its GitLab ID"
}
