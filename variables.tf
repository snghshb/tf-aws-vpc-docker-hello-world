/*
values passed from the console for access_key and secret_key
region set to us-east-2
*/
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-2"
}
variable "n" {
	default = "1"
}
variable "bootstrap_path" {
	description = "Script to install Docker"
	default = "run-docker-hello-world.sh"
}