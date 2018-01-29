# tf-aws-vpc-docker-hello-world

> A tool to provision a Scenario 2 VPC in AWS that will run N number of instances, all running the Docker "Hello World" image.

This tool uses [Terraform](https://www.terraform.io/docs/index.html) to create a [Scenario 2 VPC](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Scenario2.html) and based on the requested parameters 'N'; creates N instances in the VPC each running Docker. The [hello-world](https://hub.docker.com/_/hello-world/) image is installed and its output is returned to an output.txt file at run time.

Notes
- Created using the AWS [free tier](https://aws.amazon.com/ec2/?ft=n)
- Uses EC2 t2.micro instances running Amazon Linux AMI 2017.09.1 (HVM), SSD Volume Type (AMI ID as on 1/28/2018: **ami-f63b1193**)
- Default Region and Availability zone: **us-east-2a**
- ~~Scenario 2 VPC created using terraform-aws-modules/vpc/aws~~

The Scenario 2 VPC has the following configuration (defined in the vpc.tf file)
- Main CIDR block: 10.0.0.0/16
- Public CIDR block: 10.0.1.0/24
- Private CIDR block: 10.0.2.0/24
- A NAT gateway

Steps
1. Copy this repository

2. Initialize Terraform
```
terraform init
```

3. Use the following single line command to run the tool
```
terraform apply \
-var 'access_key=<your_access_key>' \
-var 'secret_key=<your_secret_key>' \
-var 'n=<no_of_instances>'

```
Arguments
- access_key: your AWS access key
- secret_key: your AWS secret key
- N: number of instances to be provisioned

4. Destroy the infrastructure
```
terraform destroy  \
-var 'access_key=<your_access_key>' \
-var 'secret_key=<your_secret_key>'
```
DO remember to run terraform destroy to remove all created resources so as to not incur any charges on your AWS account