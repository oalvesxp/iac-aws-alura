resource "aws_s3_bucket" "deploy" {
  bucket = "${var.repo_name}-deploy"
}

resource "aws_s3_bucket_object" "docker" {
  depends_on = [
    aws_s3_bucket.deploy
  ]

  bucket = "${var.repo_name}-deploy"
  key    = "${var.repo_name}.zip"
  source = "${var.repo_name}.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${var.repo_name}.zip")
}