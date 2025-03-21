variable "instance_type" {
    description = "type of the image"
    type= string
    default =  "t3.medium"
    
}
variable "ami_image" {
    description = "ami image of the instances"
    type = string
    default = ""
}

variable "subnet_id_private" {
    description = "private subnet id for the instances"
    type = string
    default = ""
}

variable "subnet_id_public1" {
    description = "public subnet id for lb"
    type = string
    default = ""

}

variable "redis-worker-sg" {
  description = "The ID of the web security group"
  type = string
}

variable "vote-result-sg" {
  description = "The ID of the web security group"
  type = string
}

variable "bastion-sg" {
  description = "The ID of the web security group"
  type = string
}

variable "vpc_id" {
    description = " VPC id of an existing vpc"
    type = string
    default = ""
}
