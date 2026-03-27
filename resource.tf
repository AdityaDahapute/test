resource "aws_instance" "webserver" {

    ami =    var.instanceami       # copy ami id fomr aws ami catalog
    instance_type = var.instancetype  #use the free tier instancetype
    vpc_security_groups_ids = [var.securitysg  , aws_security_group.webserversg.id, data.aws_security_group_sg_gui.id]  # when using security groups jsut using the security grp of vpc hwere u want the instane to be in, u cant attach security groups of two different VPCs // when we want ot attach the security group its called refrencing
    key_name = var.key # key as in the key pairs 
    count = var.instance_count # 2 copies get created of the same instance 
    disable _api_termination = var.api_termination
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

data "aws_security_group" "sg_gui"{
    name = "redsecurity"
}

output "webserver_public_ip"{
        value = aws_instance.webserver.publuc_ip
}

output "webserver_instance_id"{
    value = aws_instance.webserver.instance_id 
}

output "webserver_public_dns"{
    value = aws_instance.webserver.public_dns
}

output "webserver_instance_state"{
    value = aws_instance.webserver.instance_state 
}

output "securitygroup_id"{
    value = aws_security_group.webserversg.id 
} 


output "securitygroup_arn"{
    value = aws_security_group.webserversg.arn  
}