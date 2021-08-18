resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.dev.id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.envname}-bastion-sg"
  }
}
resource "aws_key_pair" "dev" {
  key_name   = "dev"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGfeJ5UFtaOiiOHEEYejhdpDa+ktAG0m5gVNQntMnDlqeS1/J6Bs1hH4ow/qTqj9HJ6fjWbqm5z92P+qJX/thmRCRBz1CouCMLwm1TFYjA14VD7+QjkxuhIZ8Q2zdbWZ0VtY9q5UGcmP27Tvc1sRUKHn+FfzZmqgKPj/e2gEcJSnxPFuIbdAEWPzC2Y+sywNhukPVuaCMcQBVlCFU1wobuRC8C83JfiqcqnsoajOrvbkH0I5IcfhIFuReXLqjLJe+uHkd/DmOAvlzPkdcySsyxnK2mOKQ0J9cGgXWfiyzAmnguW9NpmzA66ZM43ggWQMrO/XlEInkMssOJCiiHVFhlOsrHZvnA+M0/mgjswtzblvn1ekh3G4kLyF1a5RevzWJH7I+KG5xxgvvpn0+rUv0uwuMxz3DIsKTE9KjxLMminjER5PpHsetB03ZdV9dcmqOE1jFZaTar8aTCK7PN1XHcksZCVGASTwLilveH/1B6tGU3d4+7ECvwZzHVOaAv8Jc= K.K.N.R@DESKTOP-EPLDN4E"
}
#ec2
  resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.type
  key_name = aws_key_pair.dev.id
  subnet_id = aws_subnet.public[0].id
  vpc_security_group_ids = ["${aws_security_group.bastion-sg.id}"]
  tags = {
    Name = "${var.envname}-bastion"
  }
}