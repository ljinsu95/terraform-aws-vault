## 인스턴스(Vault Server) 생성
### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "vault_raft_amz2" {
  count = var.ec2_count

  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.existing.ids[(tonumber(count.index) + 1) % length(data.aws_subnets.existing.ids)]
  vpc_security_group_ids = toset([aws_security_group.vault_server.id])
  key_name               = var.pem_key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  tags = {
    Name    = "${var.prefix}-Vault-${count.index}"
    service = "${var.tag_name}"
  }
  user_data = templatefile(
    "user_data.tpl", {
      TAG           = var.tag_name
      vault_version = var.vault_version
      vault_license = var.VAULT_LICENSE
  })

  root_block_device {
    volume_type = "gp3"
    volume_size = "10"
    tags = {
      Name = "${var.prefix}_Vault_Volume_${count.index}"
    }
  }

  # credit_specification {
  #   cpu_credits = "standard"
  # }

  lifecycle {
    ignore_changes = [user_data]

    precondition {
      condition     = length(data.aws_subnets.existing.ids) == length(var.aws_subnet_ids)
      error_message = "유효하지 않은 서브넷 ID가 포함되어 있습니다."
    }
  }
}

# # tls_private_key https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key.html
# resource "tls_private_key" "hashicat" {
#   algorithm = "ED25519"
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# locals {
#   private_key_filename = "${var.prefix}-ssh-key.pem"
# }

# resource "aws_key_pair" "hashicat" {
#   key_name   = local.private_key_filename
#   public_key = tls_private_key.hashicat.public_key_openssh
# }
