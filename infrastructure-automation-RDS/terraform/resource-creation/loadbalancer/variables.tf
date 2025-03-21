variable "alb-sg" {
  description = "The ID of the web security group"
  type = string
}

variable "frontend-vote-result" {
    description = "frontend-vote-result instance id"
    type = string
}

variable "vpc_id" {
    description = " VPC id of an existing vpc"
    type = string
    default = ""
}


variable "subnet_id_public1" {
    description = "public subnet id for lb"
    type = string
    default = ""

}

variable "subnet_id_public2" {
    description = "public subnet id for lb"
    type = string
    default = ""
}