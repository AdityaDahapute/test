 vpc_cidr = "172.30.0.0/16"
    vpc_subnetA = "172.30.128.0/20"
    public_ip = true
    az = "us-east-1a"

 webserver_ami = "ami-0dsdajnnbjwdnlkja"
    webserver_key_name = "ubuntu"
    webserver_instance_type = "t3.small"
    webserver_disable_api_termination = false
    webserver_sg = module.vpc.webserversg.id
    webserver_subnetA = module.vpc.subnet_id 

