resource "local_file" "devops" {
  filename = var.file_name
  content  = var.content
}

resource "local_file" "cloud" {
  filename = "cloud.txt"
  content  = "AWS is great!"
}