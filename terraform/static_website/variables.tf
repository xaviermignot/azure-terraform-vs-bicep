variable "resource_group_name" {
    type = string
    description = "The name of the resource group."
} 

variable "location" {
  type        = string
  default     = "canadaeast"
  description = "The location to use for all resources."
}

variable "project" {
  type        = string
  default     = "tf-vs-bicep"
  description = "The project name used in all resource names."
}

variable "unique_suffix" {
  type = string
  description = "A unique suffix that might be used for globally unique resource names."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply on taggable resources."
}
