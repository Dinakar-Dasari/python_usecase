variable "security_group_id" {
  default = "sg-0065fcf40f33776a5"
}

variable "instance" {
    type = string
    default = "t3.micro"
}

variable "ami" {
  type    = string
  default = "ami-0c02fb55956c7d316"
}

variable "instance_name" {
  default = ["ec2_test_instance_1", "ec2_test_instance_2"]
}