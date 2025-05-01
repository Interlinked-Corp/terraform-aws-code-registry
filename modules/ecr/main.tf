data "aws_ecr_lifecycle_policy_document" "il101_ecr_default_policy" {
  rule {
    priority    = 1
    description = "This is the default policy. It will persist at most 5 tags."

    selection {
      tag_status       = "tagged"
      tag_pattern_list = ["latest", "*"]
      count_type       = "imageCountMoreThan"
      count_number     = 5
    }
  }
}

resource "aws_ecr_repository" "il01_api_server" {
  name                 = "il01/api_server"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_ecr_lifecycle_policy" "il01_api_server_lifecycle_policy" {
  repository = aws_ecr_repository.il01_api_server.name
  policy     = data.aws_ecr_lifecycle_policy_document.il101_ecr_default_policy.json
}
