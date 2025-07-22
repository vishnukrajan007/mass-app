provider "aws" {
  region = "ap-south-1" # Change if needed
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0f918f7e67a3323f0" # Amazon Linux 2 (us-east-1)
  instance_type = "t2.medium"
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install java-openjdk11 -y
              wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              yum install jenkins -y
              systemctl enable jenkins
              systemctl start jenkins
              yum install git -y
              EOF

  tags = {
    Name = "JenkinsServer"
  }
}

