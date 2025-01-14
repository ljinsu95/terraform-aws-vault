output "vault_public_ip" {
  value = aws_instance.vault_raft_amz2.*.public_ip
}

output "sg_vault_server" {
  value = aws_security_group.vault_server
}

output "aws_subnets" {
  value = data.aws_subnets.existing
}