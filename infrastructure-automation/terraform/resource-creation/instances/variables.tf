variable "instance_type" {
    description = "type of the image"
    type= string
    default =  "t3.medium"
    
}
variable "ami_image" {
    description = "ami image of the instances"
    type = string
    default = "ami-002ef93757e855243"
}

variable "subnet_id_private" {
    description = "private subnet id for the instances"
    type = string
    default = "subnet-02d12b3194f5405db"
}

variable "subnet_id_public1" {
    description = "public subnet id for lb"
    type = string
    default = "subnet-0cd8249bc3d107934"

}

variable "redis-worker-sg" {
  description = "The ID of the web security group"
  type = string
}
variable "postgres-sg" {
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
    default = "vpc-04eca2941dbdbdd13"
}
