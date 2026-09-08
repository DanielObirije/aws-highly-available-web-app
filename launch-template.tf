data "aws_ami" "ubuntu_sql" {
  most_recent = true
  owners      = ["061579646519"]

  filter {
    name   = "image-id"
    values = ["ami-091b599f5f318ddd2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "ena-support"
    values = ["true"]
  }
}

resource "aws_launch_template" "main" {
    name = "${var.project_name}-lt"
    
    image_id = "ami-091b599f5f318ddd2"
    instance_type = var.instance_type
    key_name = var.key_name

    vpc_security_group_ids = [aws_security_group.web.id]

    network_interfaces {
      associate_carrier_ip_address = true
      security_groups = [aws_security_group.web.id]
    }
    
    user_data = base64decode(
    <<-EOF
       #!/bin/bash

       apt update -y
       apt upgrade -y

       apt install -y apache2

       systemctl enable apache2
       systemctl start apache2

       cat > /var/www/html/index.html <<HTML
        <!DOCTYPE html>
        <html>
        <head>
            <title>Project Web Server</title>
        </head>
        <body>
            <h1>Hello from AWS EC2</h1>
            <p>Instance is running successfully.</p>
        </body>
        </html>
        HTML
     EOF
    )
}