variable "prefix" {
  description = "prefix"
  default     = "tf-vault-server"
}

#################################################
# 민감 변수 값
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS ACCESS KEY"
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS SECRET ACCESS KEY"
  sensitive   = true
}

variable "VAULT_LICENSE" {
  type        = string
  description = "License for the Vault"
  sensitive   = true
}
#################################################

#################################################
# AWS 리소스 참조 값
variable "aws_region" {
  description = "aws region"
  default     = "ca-central-1"
}

variable "aws_vpc_id" {
  type        = string
  description = "AWS VPC ID"
}

variable "aws_subnet_ids" {
  type        = list(string)
  description = "인스턴스 배포 대상 서브넷 ID 리스트"
}
#################################################

#################################################
# EC2 인스턴스 설정 값
variable "ec2_count" {
  type        = number
  description = "EC2 갯수 설정"
  default     = 3
}

variable "instance_type" {
  type        = string
  description = "x86 instance type"
  default     = "t3.micro"
}

variable "architecture" {
  type        = string
  description = "ec2에 사용되는 아키텍쳐 명 (x86 / arm)"
  default     = "x86"
}

variable "pem_key_name" {
  type        = string
  description = "ec2에 사용되는 pem key 명"
  default     = ""
}

variable "tag_name" {
  type        = string
  description = "vault_auto_join을 위한 태그 명"
  default     = "vault_auto_join"
}

variable "vault_version" {
  type        = string
  description = "Vault Version (예시 : x.y.z)"
  default     = "1.18.1"
}




#################################################
# 인스턴스 프로파일 및 보안 그룹
variable "instance_profile_policies" {
  type        = list(string)
  description = "인스턴스 프로파일에 할당될 정책"
  default = [
    "ec2:DescribeInstances",
    "iam:GetInstanceProfile",
    "iam:GetUser",
    "iam:ListRoles",
    "iam:GetRole"
  ]
}

variable "ingress_list" {
  type = map(object(
    {
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }
  ))
  description = "보안 그룹 인바운드 규칙"
  default = {
    "ssh" = {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    "vault" = {
      from_port   = 8200
      to_port     = 8201
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
#################################################

