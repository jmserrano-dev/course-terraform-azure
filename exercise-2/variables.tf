variable "tier" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "https" {
  type    = bool
  default = true
}
