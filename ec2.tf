resource "aws_instance" "SRV1" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.small"
    subnet_id = "subnet-08cae06e825cf78b8"
    associate_public_ip_address = true
    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 30
    }
    tags = {
        Name = "SRV1"
    }
   #lifecycle {
    #ignore_changes = all
  #}
}
