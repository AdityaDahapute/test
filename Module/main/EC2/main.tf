resource "aws_instance" "webserver"{

    ami = var.webserver_ami
    instancetype = var.webserver_instance_type
    key_name = var.webserver_key_name
    subnet_id = var.webserver_subnetA
    vpc_security_group_ids = [var.webserver_sg]
    disable_api_termination = var.webserver_disable_api_termination
}