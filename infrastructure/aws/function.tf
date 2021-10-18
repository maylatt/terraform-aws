data "archive_file" "extract_data" {
  type        = "zip"
  source_file = "../../functions/fn_example_script/extract-data.py"
  output_path = "../../functions/fn_example_script/extract-data.zip"

}

resource "aws_lambda_function" "extract_data" {
  filename      = data.archive_file.extract_data.output_path
  function_name = local.lambda_function_name
  role          = aws_iam_role.lambda_extract.arn
  handler       = "extract-data.handler"
  tags          = local.common_tags
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  #source_code_hash = filebase64sha256("../functions/fn_example_script.zip")
  runtime     = "python3.8"
  timeout     = 30
  memory_size = 128

  depends_on = [
    aws_iam_role_policy_attachment.lambda_attach,
    aws_cloudwatch_log_group.lambda,
  ]
}
