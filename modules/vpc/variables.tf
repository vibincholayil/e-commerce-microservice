variable "region" {
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  type       = list(string)
}

variable "public_subnet_cidrs" {
  type       = list(string)
}

variable "private_subnet_cidrs" {
  type       = list(string)
}