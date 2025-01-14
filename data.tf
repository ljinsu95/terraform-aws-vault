## VPC 조회
### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "existing" {
  id = var.aws_vpc_id
}

## 서브넷 아이디로 서브넷 목록 조회
data "aws_subnets" "existing" {
  filter {
    name   = "subnet-id"
    values = var.aws_subnet_ids
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

# 아마존 리눅스 2 이미지 조회
### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*"]
  }
}
# 아마존 리눅스 2023 이미지 조회
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023.6*"]
  }
}
