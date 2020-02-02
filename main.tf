resource "aws_instance" "example" {
  ami           = "ami-0f9ae750e8274075b"
  instance_type = "t1.micro"

  tags = {
    Name = "example"
  }
}

resource "aws_ecr_repository" "example" {
  name = "example"
}

resource "aws_ecr_lifecycle_policy" "example" {
  repository = aws_ecr_repository.example.name

  policy = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "description": "keep last 30 release tagged images",
                "selection": {
                    "tagStatus": "tagged",
                    "tagPrefixList": ["release"],
                    "countType": "imageCountMoreThan",
                    "countNumber": 30
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}