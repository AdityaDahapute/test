provider "aws" {
    region = "us-east-2"
    access_key = "iadowdalknljnsjdalndlkja"
    secret_key = "sadadfefcdafewfdadfewfdfdadadadadada"  # we dont use access keys in the profile the proper way is the below one
}

provider "aws" {
    region = "us-east-2"
    profile = "configs" #masking -. in my local system thee is masking done at word cofigs with accss keys in it this is done to keep senitive data safe
}