resource "local_file" "files-example" {
  filename = var.file_name
  content = "Some content"
}
