output "username" {
  description = "Username of the created service account"
  value       = module.bot.username
}

output "service_account_id" {
  description = "GitLab user ID of the service account"
  value       = module.bot.service_account_id
}
