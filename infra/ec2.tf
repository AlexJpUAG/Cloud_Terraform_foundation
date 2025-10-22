# Security group for EC2
resource "aws_security_group" "web_sg" {
  name_prefix = "photo-app-sg-"
  description = "Allow HTTP and SSH"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "photo-app-sg"
  }
}

# EC2 instance
resource "aws_instance" "photo_app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3 git
              yum install -y python3-pip
              pip3 install flask boto3
              cd /home/ec2-user
              git clone https://github.com/AlexJpUAG/Cloud_Terraform_foundation.git
              cd Cloud_Terraform_foundation/app
              nohup flask run --host=0.0.0.0 --port=80 > /home/ec2-user/flask.log 2>&1 &
              EOF

  tags = {
    Name = var.instance_name
  }
}
