#1 -this will create a S3 bucket in AWS
resource "aws_s3_bucket_versioning" "terraform_state_s3" {
  bucket = "terraform_state_s3_vic_exam" 
  force_destroy = true

  versioning {
         enabled = true
        }

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
  name         = "tf-up-and-run-locks_vic_exam"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
        attribute {
         name = "LockID"
         type = "S"
      }
}
