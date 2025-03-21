resource "aws_instance" "frontend-vote-result" {
  ami = var.ami_image
  instance_type = var.instance_type
  subnet_id = var.subnet_id_private
  key_name = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [var.vote-result-sg]
  tags = {
    Name = "frontend-vote-result"
  }
}

resource "aws_instance" "backend1-redis-worker" {
  ami = var.ami_image
  instance_type = var.instance_type
  key_name = data.aws_key_pair.key.key_name
  subnet_id = var.subnet_id_private
  vpc_security_group_ids = [var.redis-worker-sg]
  tags = {
    Name = "backend1-redis-worker"
  }
}


resource "aws_instance" "bastion-host" {
  ami = var.ami_image
  instance_type = var.instance_type
  subnet_id = var.subnet_id_public1
  key_name = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [var.bastion-sg]
  tags = {
    Name = "bastion-host"
  }
}
