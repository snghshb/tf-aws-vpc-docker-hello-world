/*
Elastic IP assignation. One IP as only one NAT is defined

resource "aws_eip" "nat" {
  count = "${var.n}"
  #count = 1

  vpc = true
}

---VPC using the terraform module terraform-aws-modules/vpc/aws


module "vpc" {
	source = "terraform-aws-modules/vpc/aws"

	name = "tool-vpc"
	cidr = "10.0.0.0/16"

	azs = ["us-east-2a"]
	private_subnets = ["10.0.1.0/24"]
	public_subnets = ["10.0.2.0/24"]

	enable_nat_gateway = true
	single_nat_gateway = true
	enable_vpn_gateway = true

	external_nat_ip_ids = ["${aws_eip.nat.*.id}"]
	
	tags = {
		Terraform = "true"
		Environment = "dev"
	}

}

*/
# ****************************
# new declaration

#Internet VPC
resource "aws_vpc" "main" {
	cidr_block ="10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "main"
    }
}

# Subnets
resource "aws_subnet" "main-public-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2a"

    tags {
        Name = "main-public-1"
    }
}

resource "aws_subnet" "main-private-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2a"
    tags {
        Name = "main-private-1"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "main-gw" {
    vpc_id = "${aws_vpc.main.id}"
    tags {
        Name = "main"
    }
}

# route tables
resource "aws_route_table" "main-public-1" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main-gw.id}"
    }
    tags {
        Name = "main-public"
    }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
    subnet_id = "${aws_subnet.main-public-1.id}"
    route_table_id = "${aws_route_table.main-public-1.id}"
}