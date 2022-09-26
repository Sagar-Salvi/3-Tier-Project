resource "aws_instance" "web" {
  ami           = "ami-0d5bf08bc8017c83b"
  instance_type = "t2.micro"
  key_name = "terraform"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "WebServer"
  }

  provisioner "file" {
    source = "./terraform.pem"
    destination = "/home/ubuntu/3-tier-AWS/terraform.pem"

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ubuntu"
      private_key = "${file("terraform.pem")}"
    }
  }
}

resource "aws_instance" "db" {
  ami           = "ami-0d5bf08bc8017c83b"
  instance_type = "t2.micro"
  key_name = "terraform"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}
