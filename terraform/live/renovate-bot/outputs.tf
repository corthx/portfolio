output "username" {
  value       = module.service_account.username
  description = "Username of the created service account"
}

output "service_account_id" {
  value       = module.service_account.service_account_id
  description = "GitLab user ID of the service account"
}
