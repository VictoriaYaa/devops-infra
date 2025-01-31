#1 -this will create a S3 bucket in AWS
resource "aws_s3_bucket" "terraform_state_s3" {

  bucket = "terraform-vic-s3-bucket" 
  force_destroy = true
# Enable versioning to see full revision history of our state files
  versioning {
         enabled = true
        }

# Enable server-side encryption by default
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}



# 2 - this Creates Dynamo Table
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-up-and-run-locks-vic-NEW"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
        attribute {
         name = "LockID"
         type = "S"
      }
}


#Step 3 - Creates S3 backend
terraform {
  backend "s3" {
    bucket         = "terraform-vic-s3-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-up-and-run-locks-vic"
    encrypt        = true
    }
}