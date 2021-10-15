resource "aws_s3_bucket" "buckets" {
  count  = length(local.bucket_names)
  bucket = local.bucket_names[count.index]
  acl    = "private"

  tags = local.common_tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "bucket_functions" {
  count  = length(local.bucket_functions)
  bucket = local.bucket_functions[count.index]
  acl    = "private"

  tags = local.common_tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "null_resource" "fn_example_script" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "zip -rj ../../functions/fn_example_script.zip ../../functions/fn_example_script"
  }
}