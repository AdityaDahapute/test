resource "aws_instance" "webserver"{
    ami = "ami-012213231dfsfed231"
    instance_type = "t3.micro"

    provisioner "file"{
        source = "hello.txt"
        destination = "/home/ex2-user/aws/"
    }

    provisioner "local-exex"{
      command  = "echo ${self.private_ip} >> private_ips.txt"
    }
    connection{
        type  = "ssh" 
        user = "ec2-user"
        private_key = file(${path.module}/tf.pem)
        host = self.public_ip
    }

    provisioner "remote-exec"{
        inline = [
            "sudo yum install httpd -y"
            "sudo systemctl start httpd"
            "sudo systemctl enable httpd"
        ]
    }

}

provider "aws" {
    region = "us-east-2"
    profile = "configs" #masking -. in my local system thee is masking done at word cofigs with accss keys in it this is done to keep senitive data safe
}

