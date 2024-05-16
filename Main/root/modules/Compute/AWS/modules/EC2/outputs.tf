# Define the AWS provider
provider "aws" {
    region = "us-west-2"  # Update with your desired region
}

# Create a security group for the EC2 instance
resource "aws_security_group" "build_agent_sg" {
    name        = "build-agent-sg"
    description = "Security group for build agent"

    # Allow SSH access from your IP address
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["YOUR_IP_ADDRESS/32"]  # Update with your IP address
    }

    # Allow inbound traffic on the ports required for your CI/CD tools (e.g., Jenkins, GitLab, etc.)
    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow outbound traffic to the internet
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create an EC2 instance
resource "aws_instance" "build_agent" {
    ami           = "ami-0c94855ba95c71c99"  # Update with your desired AMI ID
    instance_type = "t2.micro"  # Update with your desired instance type
    key_name      = "your-key-pair"  # Update with your key pair name

    security_group_ids = [aws_security_group.build_agent_sg.id]

    # Add any additional configuration you need for your build agent (e.g., user data, tags, etc.)
}