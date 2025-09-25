resource "local_file" "devops" {
    filename = var.file_name
    content = "Terraform is awesome!"
}

resource "local_file" "cloud" {
    filename = "cloud.txt"
    content = "AWS is great!"
}