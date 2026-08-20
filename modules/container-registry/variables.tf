# Input variables for the reusable Amazon ECR container registry module.
# Dev, UAT, and Prod environment configurations supply values to this module.

variable "repository_name" {
  description = "Name of the Amazon ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "Whether image tags can be overwritten."
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Whether Amazon ECR scans images when they are pushed."
  type        = bool
  default     = true
}

variable "force_delete" {
  description = "Whether Terraform may delete the repository when it contains images."
  type        = bool
  default     = false
}

variable "untagged_image_expiration_days" {
  description = "Number of days before untagged images are removed."
  type        = number
  default     = 7

  validation {
    condition     = var.untagged_image_expiration_days >= 1
    error_message = "untagged_image_expiration_days must be at least 1."
  }
}

variable "tags" {
  description = "Tags applied to the ECR repository."
  type        = map(string)
  default     = {}
}