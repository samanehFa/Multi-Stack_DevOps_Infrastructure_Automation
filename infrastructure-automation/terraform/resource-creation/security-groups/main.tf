
#Application Load Balancer Security Group

resource "aws_security_group" "alb-sg" {
  name        = "lb-sg"
  vpc_id      = var.vpc_id

  tags = {
    Name = "alb_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-HTTP_lb" {
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port  = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow-HTTPS_lb" {
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port  = 443
  ip_protocol = "tcp"
  to_port = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_lb" {
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Redis/Worker Security Group
resource "aws_security_group" "redis-worker-sg" {
  name   = "redis-worker-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "redis_worker_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_redis_from_vote_result" {
  security_group_id = aws_security_group.redis-worker-sg.id
  referenced_security_group_id = aws_security_group.vote-result-sg.id
  from_port         = 6379
  ip_protocol       = "tcp"
  to_port           = 6379
}

resource "aws_vpc_security_group_egress_rule" "allow_postgres_outbound_from_worker" {
  security_group_id = aws_security_group.redis-worker-sg.id
  referenced_security_group_id = aws_security_group.postgres-sg.id
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_redis_worker" {
  security_group_id = aws_security_group.redis-worker-sg.id
  referenced_security_group_id = aws_security_group.bastion-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "redis_worker_allow_outbound" {
  security_group_id = aws_security_group.redis-worker-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Postgres Security Group
resource "aws_security_group" "postgres-sg" {
  name   = "postgres-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "postgres_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgres_from_worker" {
  security_group_id = aws_security_group.postgres-sg.id
  referenced_security_group_id = aws_security_group.redis-worker-sg.id
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgres_from_vote_result" {
  security_group_id = aws_security_group.postgres-sg.id
  referenced_security_group_id = aws_security_group.vote-result-sg.id
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_postgres" {
  security_group_id = aws_security_group.postgres-sg.id
  referenced_security_group_id = aws_security_group.bastion-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "postgres_allow_outbound" {
  security_group_id = aws_security_group.postgres-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Vote/Result Security Group
resource "aws_security_group" "vote-result-sg" {
  name   = "vote-result-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "vote_result_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_alb" {
  security_group_id = aws_security_group.vote-result-sg.id
  referenced_security_group_id = aws_security_group.alb-sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_alb_8080" {
  security_group_id = aws_security_group.vote-result-sg.id
  referenced_security_group_id = aws_security_group.alb-sg.id
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "allow_redis_outbound" {
  security_group_id = aws_security_group.vote-result-sg.id
  referenced_security_group_id = aws_security_group.redis-worker-sg.id
  from_port         = 6379
  ip_protocol       = "tcp"
  to_port           = 6379
}

resource "aws_vpc_security_group_egress_rule" "allow_postgres_outbound" {
  security_group_id = aws_security_group.vote-result-sg.id
  referenced_security_group_id = aws_security_group.postgres-sg.id
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_vote_result" {
  security_group_id = aws_security_group.vote-result-sg.id
  referenced_security_group_id = aws_security_group.bastion-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "vote_result_allow_outbound" {
  security_group_id = aws_security_group.vote-result-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#bastion Host Security Group
resource "aws_security_group" "bastion-sg" {
  name   = "bastion-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "bastion_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_internet" {
    security_group_id = aws_security_group.bastion-sg.id
    cidr_ipv4         = "0.0.0.0/0"
    from_port         = 22
    ip_protocol       = "tcp"
    to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "bastion_to_vote_result" {
  security_group_id = aws_security_group.bastion-sg.id
  referenced_security_group_id = aws_security_group.vote-result-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "bastion_to_redis_worker" {
  security_group_id = aws_security_group.bastion-sg.id
  referenced_security_group_id = aws_security_group.redis-worker-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "bastion_to_postgres" {
  security_group_id = aws_security_group.bastion-sg.id
  referenced_security_group_id = aws_security_group.postgres-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "bastion_allow_outbound" {
  security_group_id = aws_security_group.bastion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}