output "alb-sg" {
  description = "The ID of the lb security group"
  value       = aws_security_group.alb-sg.id
}
output "redis-worker-sg" {
  description = "The ID of the redis-worker-sg security group"
  value       = aws_security_group.redis-worker-sg.id
}
output "postgres-sg" {
  description = "The ID of the postgres-sg security group"
  value       = aws_security_group.postgres-sg.id
}
output "vote-result-sg" {
  description = "The ID of the vote-result-sg security group"
  value       = aws_security_group.vote-result-sg.id
}

output "bastion-sg" {
  description = "the id of the bastion-sg security group"
  value = aws_security_group.bastion-sg.id
}
