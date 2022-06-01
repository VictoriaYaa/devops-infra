resource "aws_cloudwatch_log_group" "aws_log_group" {
  name  = "aws_log_group"
}

resource "aws_cloudwatch_log_stream" "aws_log_stream" {
  name  = "aws_log_stream"
  log_group_name    = aws_cloudwatch_log_group.aws_log_group.name
}