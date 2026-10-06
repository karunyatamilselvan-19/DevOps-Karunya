variable "name" { type = string }
variable "vpc_id" { type = string }
variable "subnet_id" { type = string }
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "key_name" {
  description = "Existing EC2 key pair name (optional, needed for SSH/Ansible)"
  type        = string
  default     = null
}
variable "ssh_cidr" {
  description = "CIDR allowed to SSH. Set to your IP, e.g. 1.2.3.4/32"
  type        = string
  default     = "0.0.0.0/0"
}
variable "docker_image" {
  description = "Container image to run on boot"
  type        = string
  default     = "nginx:alpine"
}
variable "container_port" {
  type    = number
  default = 80
}
