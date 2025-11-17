variable "region" { default = "ap-south-1" }
variable "ami_id" { type = string }
variable "instance_type" { default = "t3.small" }
variable "key_name" { type = string }
variable "server1_volume" { default = 20 }
variable "server2_volume" { default = 15 }
variable "server3_volume" { default = 10 }
variable "server4_volume" { default = 10 }