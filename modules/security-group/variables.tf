variable "vpc_id" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "ssh_allowed_cidrs" {
  description = "List of CIDR blocks allowed to SSH (port 22). Restrict to your own IP."
  type        = list(string)
}