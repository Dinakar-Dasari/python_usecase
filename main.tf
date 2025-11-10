resource "aws_instance" "test_instance" {
  count                     =   length(var.instance_name)
  ami                       =   var.ami
  instance_type             =   var.instance
  subnet_id                 =   "subnet-070a8260c319f0823"
  vpc_security_group_ids    =   [var.security_group_id]
  tags ={
    Name = var.instance_name[count.index] ,
    Auto-instance-scheduler = "yes" ,
    environment = "dev"
  }  

}

# resource "aws_ec2_tag" "name" {
#   count       = length(var.instance_name)
#   resource_id = aws_instance.test_instance[count.index].id
#   key         = "Name"
#   value       = var.instance_name[count.index]
# }

# resource "aws_ec2_tag" "auto_instance_scheduler" {
#   count = length(var.instance_name)
#   resource_id = aws_instance.test_instance[count.index].id
#   key         = "Auto-instance-scheduler"
#   value       = "yes"
# }

# resource "aws_ec2_tag" "environment" {
#   count = length(var.instance_name)
#   resource_id = aws_instance.test_instance[count.index].id
#   key         = "environment"
#   value       = "dev"
# }