resource "aws_instance" "webserver" {

    ami =    var.instanceami       # copy ami id fomr aws ami catalog
    instance_type = var.instancetype  #use the free tier instancetype
    vpc_security_groups_ids = [var.securitysg  , aws_security_group.webserversg.id]  # when using security groups jsut using the security grp of vpc hwere u want the instane to be in, u cant attach security groups of two different VPCs // when we want ot attach the security group its called refrencing
    key_name = var.key # key as in the key pairs 
    
    tags = {
        Name = "hello worlds"
        purpose = "learning-terraform"
    }
    user_data = <<-EOF
                #!/bin/bash
                sudo -i
                apt install apache2 -y
                systemctl start apache2
                EOF 
}

resource "aws_security_group" " webserversg"{

    egress {   #outbound traffic
        from_port = 8080
        to_port = 8080
        protocol = "-1" # -1 denotes we need to implement all traffic protocols 
        cidr_block = ["0.0.0.0/0"]
    }

    ingress {  #inbound traffic 
        from_port = 8080
        to_port = 8080
        protocol = "-1" # -1 denotes we need to implement all traffic protocols 
        cidr_block = ["0.0.0.0/0"]
    }
}
