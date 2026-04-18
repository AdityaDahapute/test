resource "aws_vpc" "cbz_vpc"{
    cidr_block = var.vpc_cidr
    
}
resource "aws_subnet" "cbz_subnetA"{
    vpc_id = aws_vpc.cbz_vpc.id
    cidr_block = var.vpc_cidr
    map_public_ip_on_launch = var.public_ip
    availability_zone = var.az
}

resource "aws_security_group" "webserversg"{

    vpc_id = aws_vpc.cbz_vpc.id 

    ingress {  #inbound traffic 
        from_port = 80
        to_port = 80
        protocol = "tcp"  
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {  #inbound traffic 
        from_port = 8080
        to_port = 8080
        protocol = "tcp"  
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {   #outbound traffic
        from_port = 8080
        to_port = 8080
        protocol = "-1" # -1 denotes we need to implement all traffic protocols 
        cidr_blocks = ["0.0.0.0/0"]
    }

}
