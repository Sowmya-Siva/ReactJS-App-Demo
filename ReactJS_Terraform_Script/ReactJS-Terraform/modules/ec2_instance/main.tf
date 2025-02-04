resource "aws_instance" "app" {
  ami           = "ami-12345678"  # Replace with actual AMI ID
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo docker login -u AWS -p $(aws ecr get-login-password --region ${var.aws_region}) https://${var.ecr_repo_url}
              sudo docker pull ${var.ecr_repo_url}:latest
              sudo docker run -d -p 80:80 ${var.ecr_repo_url}:latest
              EOF
}
