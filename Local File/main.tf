# resource "local_file" "devops" {
#     filename = var.file_name
#     content = "Terraform is awesome!"
# }

resource "local_file" "cloud" {
    filename = var.file_name
    content = "AWS is great!"
}