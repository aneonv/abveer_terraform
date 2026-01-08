provider "aws" {
  region = "us-east-1"
}
provider "vault" {
   
  address = "http://54.172.241.48:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"
    method = "aws"
    parameters = {
      role_id = "a0e718da-541c-cc2b-e232-1cd9cbe08aa6"
      secret_id = "f79f8d9b-b0e2-c723-6a7f-55d647c707cd"
    }
  }
}
data "vault_kv_secret_v2" "test_kv" {
  mount = "kv"
  name  = "test-secret"
}
resource "aws_instance" "test_instance" {
  ami           = "resolve:ssm:/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
  instance_type = "t3.micro"

  tags = {
    Name   = "test-instance"
    Secret = data.vault_kv_secret_v2.test_kv.data["username"]
  }
}