terraform {
  backend "s3" {
    bucket = "terraformcardupbackend"
    key    = "MY.tfstae"
    region = "ap-southeast-1"
    dynamodb_table = "cardupterraformlock"
    encrypt        = true
  }
}