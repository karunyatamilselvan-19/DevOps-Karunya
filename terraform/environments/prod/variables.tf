variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "key_name" {
  type    = string
  default = null
}
variable "ssh_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
variable "docker_image" {
  type    = string
  default = "nginx:alpine"
}
variable "container_port" {
  type    = number
  default = 80
}
