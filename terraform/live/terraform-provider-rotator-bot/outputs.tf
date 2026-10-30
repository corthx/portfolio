output "username" {
  description = "Username of the created service account"
  value       = module.service_account.username
}

output "service_account_id" {
  description = "GitLab user ID of the service account"
  value       = module.service_account.service_account_id
}
