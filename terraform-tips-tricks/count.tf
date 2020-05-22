resource "aws_iam_user" "a_user" {
  count = 3
  name  = "user-${count.index}"
}

variable "user_names" {
  description = "list of IAM users to create"
  type        = list(string)
  default     = ["joe"]
}

resource "aws_iam_user" "users_list" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

output "user-1_arn" {
  value = aws_iam_user.a_user[1].arn
}

output "user_names_arns" {
  value = aws_iam_user.a_user[*].arn
}

//-----------------------------------------
// FOR EACH  (for_each)
//------------------------------------

variable "user_names_dups" {
  type    = list(string)
  default = ["neo1", "loe1", "joe1", "joe1"]
}

resource "aws_iam_user" "for_each_loop" {
  for_each = toset(var.user_names_dups)
  name     = each.value
}

output "for_each_loop_users" {
  value = values(aws_iam_user.for_each_loop)[*].arn
}

//-----------------------------------------
// FOR EACH  (for_each) (block instead of resource )
//------------------------------------
variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default = {
    name1 = "loop"
    name2 = "for_each"
    name3 = "dynamic"
  }
}


//the following code is not complete for "terrform apply"

// resource "aws_autoscaling_group" "example" {

//   min_size = 1
//   max_size = 1

//   dynamic "tag"  {
//     for_each = var.custom_tags
//     content {
//         key                 = tag.key
//         value               = tag.value
//         propagate_at_launch = true
//       }
//     }
// }

//-----------------------------------------
// FOR expression 
//------------------------------------

variable "names" {
  description = "A list of names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}
output "upper_names" {
  value = [for name in var.names : upper(name)]
}

output "tags_map" {
  value = { for tag, value in var.custom_tags : upper(tag) => upper(value) }
}

output "tags_list" {
  value = [for tag, value in var.custom_tags : "${tag} ==> ${value}"]
}