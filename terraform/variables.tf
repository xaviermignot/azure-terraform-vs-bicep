variable "location" {
  type        = string
  default     = "canadaeast"
  description = "The location to use for all resources."
}

variable "project" {
  type        = string
  default     = "tf-vs-bicep-terraform"
  description = "The project name used in all resource names."
}
