

provider "aws" {
    region = "us-east-2"
    profile = "configs" #masking -. in my local system thee is masking done at word cofigs with accss keys in it this is done to keep senitive data safe
}

terraform{
    backend "s3" {
        bucket = "cbzbatch45" #name of the bucket
        key = "terraform.tfstate" # which file to be kept a sbackup in s3 bucket 
        dynamodb_table = "cbz24"
        region = "us-east-1"
        profile = "configs"
        shared_credentials_files = ["/home/adity/.aws/credentials"]
    }
}