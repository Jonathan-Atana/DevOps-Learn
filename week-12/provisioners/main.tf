/* ============================================================================
 * Note:
 * It is generally not good practice to use provisioners, as much possible!
 * ============================================================================
 */

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "main" {
  ami = "ami-0e58b56aa4d64231b"
  instance_type = "t2.micro"

  /* provisioner "file" {
    source = "text.txt"
    destination = "/tmp"
  } */
}

resource "null_resource" "main" {
  provisioner "file" {
    source = "text.txt"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y"
    ]
  }

  provisioner "local-exec" {
    command = "sleep 4"
  }
}
# Provisioners (local-exec, remote-exec, file)