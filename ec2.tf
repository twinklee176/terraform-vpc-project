resource "aws_instance" "frontend" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<h1>Frontend Server</h1>" > /var/www/html/index.html
EOF

  tags = {
    Name = "frontend-server"
  }
}

resource "aws_instance" "backend" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = var.key_name

  associate_public_ip_address = false

  user_data = <<EOF
#!/bin/bash
yum update -y

# install apache properly
yum install -y httpd

# start service
systemctl enable httpd
systemctl start httpd

# test page
echo "Backend Working OK" > /var/www/html/index.html
EOF

  tags = {
    Name = "backend-server"
  }
}