variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}
variable "ssh_allowed_cidrs" {
  type = list(string)
}