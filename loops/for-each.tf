resource "aws_instance" "webserver"{
    for-each = toset(var.aws_ami) #typecasting
    ami = each.value 
    instance_type = "t3.micro"

}

variable "aws_ami" {
    default = ["ami-0c2313212232", "ami-231030uh1u8" , "ami-129109201"]
} 

output "aws_public_ip"  {
    value = [for ami in var.aws_ami:
            aws_instance.webserver[ami].public_ip]
}