output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_id" {
  value = module.public_subnet.subnet_id
}

output "private_subnet_id" {
  value = module.private_subnet.subnet_id
}

output "internet_gateway" {
  value = module.internet_gateway.igw_id
}

output "public_route_table_id" {
  value = module.public_route_table.route_table_id
}

output "security_group_id" {
  value = module.web_sg.security_group_id
}

output "public_ec2_id" {
  value = module.public_ec2.instance_id
}

output "public_ec2_public_ip" {
  value = module.public_ec2.public_ip
}

output "public_ec2_private_ip" {
  value = module.public_ec2.private_ip
}

output "private_ec2_id" {
  value = module.private_ec2.instance_id
}

output "private_ec2_private_ip" {
  value = module.private_ec2.private_ip
}

output "private_ec2_public_ip" {
  value = module.private_ec2.public_ip
}