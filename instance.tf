/*
selects t2.micro instance, running Amazon Linux AMI 2017.09.1 (HVM), SSD Volume Type
*/
resource "aws_instance" "example" {
	count = "${var.n}"
	ami = "ami-f63b1193"
  	instance_type = "t2.micro"
  	subnet_id = "${aws_subnet.main-private-1.id}"
  	user_data = "${file("${var.bootstrap_path}")}"

  	#saves the IP address in ip_address.txt
  	provisioner "local-exec" {
    	command = "docker run hello-world >> output.txt"
  	}
}

#resource "aws_eip" "ip" {
#  	instance = "${aws_instance.example.id}"
#}


#will output the ip address on the console
#output "ip" {
#  	value = "${aws_eip.ip.public_ip}"
#}