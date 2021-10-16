data "archive_file" "hello_world" {
  type        = "zip"
  source_file = "../../functions/fn_example_script/hello-world.py"
  output_path = "../../functions/fn_example_script/hello-world.zip"

}

resource "aws_lambda_function" "decompresss3" {
  filename      = data.archive_file.hello_world.output_path
  function_name = "${local.prefix}_decompressS3"
  role          = aws_iam_role.lambda_decompress.arn
  handler       = "hello-world.handler"
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  #source_code_hash = filebase64sha256("../functions/fn_example_script.zip")
  runtime     = "python3.8"
  timeout     = 900
  memory_size = 10000
  environment {
    variables = {
      key_1 = "value_1"
      key_2 = "value_2"
    }
  }

  tags = local.common_tags

}
