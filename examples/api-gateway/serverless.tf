# Create Lambda function
data "archive_file "lambda_zip_file" {
  type = "zip"
  source_file = "lambda/index.js"
  output_path = "lambda/index.zip"
}

resource "aws_iam_role" "lambda_role" {
  assume_role_policy = file("lambda-policy.json")
  name = "lambda_role"
}

resource "aws_lambda_function" "ankh_lambda_function" {
  function_name = "DemoLambdaFunction"
  filename = "lambda/index.zip"
  role = aws_iam_role.lambda_role.arncheck
  handler = "index.handler"
  runtime = "nodejs20.x"
  timeout = 30
  source_code_hash = "data.archive.file.lambda_zip_file.output_base64sha256"
}
