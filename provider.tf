/*
identifies provider specific information
region defaults to us-east-2
input passed from the console and defined in variables.tf
*/
provider "aws" {
  	access_key = "${var.access_key}"
  	secret_key = "${var.secret_key}"
  	region     = "${var.region}"
}