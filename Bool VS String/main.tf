resource "local_file" "devops" {
  filename = var.file_name
  content  = var.content
}