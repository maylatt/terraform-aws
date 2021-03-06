resource "aws_glue_catalog_database" "consumer" {
  name = var.database_name
}

resource "aws_glue_crawler" "consumer" {
  name          = "${local.prefix}-${var.database_name}_crawler"
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.consumer.name
  tags          = local.common_tags

  s3_target {
    path = "s3://${local.bucket_name}/consumer-zone"
  }
}
