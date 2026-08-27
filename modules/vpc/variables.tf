variable "name_prefix" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnets" {
  type = map(object({ cidr = string, az = string }))
}
variable "private_subnets" {
  type = map(object({ cidr = string, az = string }))
}
variable "enable_nat_gateway" {
  type    = bool
  default = true
}
variable "public_subnet_tags" {
  description = "Additional tags applied to every public subnet."
  type        = map(string)
  default     = {}
}
variable "private_subnet_tags" {
  description = "Additional tags applied to every private subnet."
  type        = map(string)
  default     = {}
}
variable "tags" {
  type    = map(string)
  default = {}
}
