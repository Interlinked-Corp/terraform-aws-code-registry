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

// api server which hours all API endpoints
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


// analyzer container which runs the models and generates AI responses
resource "aws_ecr_repository" "il01_analyzer" {
  name                 = "il01/analyzer"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_ecr_lifecycle_policy" "il01_analyzer_lifecycle_policy" {
  repository = aws_ecr_repository.il01_analyzer.name
  policy     = data.aws_ecr_lifecycle_policy_document.il101_ecr_default_policy.json
}

// harvester container to fetch data from various channels
resource "aws_ecr_repository" "il01_harvester" {
  name                 = "il01/harvester"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_ecr_lifecycle_policy" "il01_harvester_lifecycle_policy" {
  repository = aws_ecr_repository.il01_harvester.name
  policy     = data.aws_ecr_lifecycle_policy_document.il101_ecr_default_policy.json
}
