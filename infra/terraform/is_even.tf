# module "is_even" {
#   source   = "./is_even"
#   for_each = toset(["1", "2", "3"])

#   value = tonumber(each.key)
# }

# locals {
#   is_even_results = [for value in ["1", "2", "3"] : {
#     value = value
#     result = module.is_even[value].result
#   }]
# }

# output "is_even_results" {
#   value = local.is_even_results
# }
