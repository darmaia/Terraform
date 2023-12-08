provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example_server" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    subnet_id = "subnet-91935fce"
    associate_public_ip_address = true
    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 20
    }
}

resource "aws_db_instance" "default" {
    instance_class = "db.t3.micro"
    allocated_storage = 5
    engine = "mariadb"
    engine_version = "10.6.14"
    username = "${var.username}"
    password = "${var.senhabd}"
    publicly_accessible = true
}