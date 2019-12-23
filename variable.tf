variable "do_token" {
  description = "access to API DO"
}

variable "access_key" {
  description = "This is the AWS access key"
}

variable "secret_key" {
  description = "This is the AWS secret key"
}

variable "region" {
  description = "This is the AWS region"
}

variable "vscale_msk" {
  description = "vscale MSK data"
  default     = "msk0"
}

variable "image" {
  type   =  "list"
  default = ["ubuntu_18.04_64_001_master", "centos_7_64_001_master"]
}

variable "test" {
  description  =  "count"
  default = "2"
}

variable "group_name" {
  default = "centos"
}
variable "ansible_user" {
  description = "This connections user ansible-playbook"
  default     = "root"
}

variable "private_key" {
  description = "This private key to acceess Vcale"
}

variable "vscale_rplan" {
  type = "map"
  default = {
    "s"   = "small"
    "m"   = "medium"
    "l"   = "large"
    "xl"  = "huge"
    "xxl" = "monster"
  }
}

variable "devs" {
  default = ["dev1.SBabanin4", "dev2.SBabanin4"]
}


