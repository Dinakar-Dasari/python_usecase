# Request a spot instance at $0.03
resource "aws_spot_instance_request" "test_instance" {
  count = length(var.instance_name)
  ami                       =   var.ami
  instance_type             =   var.instance
  wait_for_fulfillment      =   true  
  spot_type                 =   "persistent"  
  subnet_id                 =   "subnet-070a8260c319f0823"
  vpc_security_group_ids    =   [var.security_group_id]
#   tags = {
#         Name                    = "ec2_test_instance"
#         Auto-instance-scheduler = "yes"
#         Environment             = "dev"
#   }

}

resource "aws_ec2_tag" "name" {
  count = length(var.instance_name)
  resource_id = aws_spot_instance_request.test_instance[count.index].spot_instance_id
  key         = "Name"
  value       = var.instance_name[count.index]
}

resource "aws_ec2_tag" "auto_instance_scheduler" {
  count = length(var.instance_name)
  resource_id = aws_spot_instance_request.test_instance[count.index].spot_instance_id
  key         = "Auto-instance-scheduler"
  value       = "yes"
}

resource "aws_ec2_tag" "environment" {
  count = length(var.instance_name)
  resource_id = aws_spot_instance_request.test_instance[count.index].spot_instance_id
  key         = "environment"
  value       = "dev"
}