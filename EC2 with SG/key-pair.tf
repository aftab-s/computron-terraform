# Create Key Pair
resource "aws_key_pair" "web_server_key" {
  key_name   = var.key_pair_name
  public_key = var.public_key

  tags = {
    Name = "${var.instance_name}-key"
  }
}
