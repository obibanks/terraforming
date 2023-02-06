# INSTANCES #
resource "aws_instance" "apache" {
  count                  = var.instance.count
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnets[(count.index % var.vpc_subnet_count)].id
  vpc_security_group_ids = [aws_security_group.apache-sg.id]

  tags = {
    Name = "apache-${count.index + 1}"
  }
}

resource "local_file" "ip_address" {
    filename             = "~/Desktop/AltSchool assignment/Terraform files/host-inventory"
    content              = <<EOT
${aws_instance.apache-1.public_ip}
${aws_instance.apache-2.public_ip}
${aws_instance.apache-3.public_ip}
    EOT
}

resource "aws_route53_zone" "apache_zone" {
    name                 = "obioma.me"
}

resource "aws_route53_record" "apache_record" {
    zone_id              = aws_route53_zone.apache_zone.zone_id
    name                 = "terraform-test"
    type                 = "A"
    ttl                  = "300"
    records              = [aws_lb.apache.dns_name]
}

resource "aws_key_pair" "deployer" {
    key_name             = "meineKey"
    public_key           = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2IoJg8xeXA/lJHYq+JFh/4FgBfVEZzwDZKGEhwwOBFInZ2rMEwV8kwY9wLI2RJsAAskrqxu1oYto2zBARcbQ8nyzyZX2vB9bIm2AtSVCAoyR6ITGqexfFHGTfM7WFWQ26NznNH8dgjaPnIENVjaXcINOJl5rXMK+SmC44/OsDDz9hMIRJaMWn4GqeoWTyKjRKGrt6nqLHxixFw50B+3Q6p4ommgErVK1dmR9xZQDd8JZUtV9+9qVRKHHpTu7tKH7qKLwDXBgYTxsmj76hrhZSGwHH2fWUoGYg4GdzTpq0fs3SeBHFdaT4NIHuDb9HszP9JoTHsdq6DhNZMgF9AFvP3QacwZboYhou/U7dzxgd1TmDoMBN9WzvWJrxl9Q4NKzl+lXIXmAkB3qLdbyXovlQiLfMRUz1BppNoogeW2ioX0Hn5y7RodFzYtgYwD3HGwkPVc58XXaMjqqqRZ3+skgcZopcgwckXLbHVfXcxJzj/KxkzduLl8OHrd93E2Q0Nh8= HP@LAPTOP-A3EESUM7"
}
