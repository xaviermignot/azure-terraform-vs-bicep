variable "value" {
  type = number
}

output "result" {
  value = var.value % 2 == 0
}
