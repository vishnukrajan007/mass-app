output "jenkins_instance_ip" {
  value = aws_instance.jenkins_server.public_ip
}

