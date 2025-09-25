resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  
  tags = merge(
    {
      Name = var.instance_name
    },
    var.additional_tags
  )
}
