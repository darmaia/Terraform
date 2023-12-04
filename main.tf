resource "aws_instance" "example_server" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    subnet_id = var.subnet_id
    associate_public_ip_address = true
  
    tags = {
      Name = "Teste EC2"
    }
}