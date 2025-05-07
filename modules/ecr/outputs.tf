output "il01_api_server_repository_url" {
  description = "ecr url of the api server"
  value       = aws_ecr_repository.il01_api_server.repository_url
}