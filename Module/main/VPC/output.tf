output "vpc_id"{
    value = aws_vpc.cbz_vpc.id
}
output "subnet_id"{
    value = aws_subent.cbz_subnetA.id
}
output "webserversg"{
    value = aws_security_group.webserversg.id 
}

output "webserversg_arn"{
    value = aws_security_group.webserversg.arn
}