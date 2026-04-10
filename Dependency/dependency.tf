resource "aws_instance" "webserver" {

    ami =    var.instanceami       # copy ami id fomr aws ami catalog
    instance_type = var.instancetype  #use the free tier instancetype
    vpc_security_groups_ids = [var.securitysg  , aws_security_group.webserversg.id, data.aws_security_group_sg_gui.id]  # when using security groups jsut using the security grp of vpc hwere u want the instane to be in, u cant attach security groups of two different VPCs // when we want ot attach the security group its called refrencing
    key_name = var.key # key as in the key pairs 
    #count = var.instance_count # 2 copies get created of the same instance // whenn using output block it cannot get output of 2 instance at a time loop is required to manipulate data 
    disable _api_termination = var.api_termination
    depends _on = [aws_security_group.webserversg] # explicit dependency
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
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {  #inbound traffic 
        from_port = 8080
        to_port = 8080
        protocol = "-1" # -1 denotes we need to implement all traffic protocols 
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "aws_security_group" "sg_gui"{
    name = "redsecurity"
}

