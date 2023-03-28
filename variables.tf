variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/22"
  description = "VPC CIDR Block"
}

variable "public-subnet" {
  type = string
  default = "10.0.0.0/23"
  description = "Public Subnet CIDR Block"
}

variable "private-subnet" {
  type = string
  default = "10.0.2.0/23"
  description = "Private Subnet CIDR Block"
}

