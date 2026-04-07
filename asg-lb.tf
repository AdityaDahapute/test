resource "aws_security_group" "web_sg"{
    name = "web_sg"
    vpc_id = data.aws_vpc.default.id
    ingress{
        from_port = 0
        to_port = 
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    } 
    egress{
        from_port = 0
        to_port = 
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
data "aws_vpc" "default"{
    default = true #finds the metadata for the deafult vpc which the aws creates for every region
}

data "aws_subnets" "default" {
    filter{
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}

resource "aws_lb" "app_lb"{
    name = "simple-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.web_sg.id]
    subnets = data.aws_subnets.default.ids
}

resource "aws_lb_target_group" "tg"{
    name = "simple-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = data.aws_vpc.default.id 

}

resource "aws_lb_listener" "listener"{
    load_balancer_arn = aws_lb.app_lb.arn 
    por = 80
    protocol  = "HTTP"

    default_action{ # used to tell where to forward the traffic coming fromt the loadbalancer
        type = "forward"
        target_group_arn = aws_lb_target_group.tg.arn 
    }
}

resource "aws_launch_template" "example"{
    name_prefix = "simple_template"
    image_id = " place the ami id here"
    instance_type = "t3.micro"

    network_interfaces{
        associatep_public_ip_address = true
        security_groups = [aws_security_group.web_sg.id]
    }
    user_data = base64encode(<<EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        systemctl start httpd
        systemctl enable httpd
        echo "hello from $(hostname -f)" > /var/www/html/index.html 
    EOF 
    )
}

resource "aws_autoscaling_group" "example"{
    desired_capacity = 2
    max_size = 3
    min_size = 1
    vpc_zone_identifier = data.aws_subnets.default.ids
    target_group_arns = ["aws_lb_target_group.tg.arn"]
    health_check_type = "ELB"
    health_check_grace_period = 120

    launch_template{
        id = aws_launch_template.example.id
        version = "$Latest"
    }
}

output "alb_dns_name"{
    value = aws_lb.app_lb.dns_name
}