#provider "aws" {
#    region = "us-east-1"
#}

#resource "aws_db_instance" "default" {
#    instance_class = "db.t3.micro"
#    allocated_storage = 5
#    engine = "mariadb"
#    engine_version = "10.6.14"
#    username = "${var.username}"
#    password = "${var.senhabd}"
#    publicly_accessible = true
#}
