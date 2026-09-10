resource "tls_private_key" "project" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "project" {
  key_name   = var.key_name
  public_key = tls_private_key.project.public_key_openssh

  tags = {
    Name = "project-KP"
  }
}

resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.project.private_key_pem
  filename        = "${path.module}/project-KP.pem"
  file_permission = "0600"
}