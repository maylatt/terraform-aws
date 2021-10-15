resource "aws_glue_crawler" "glue_crawler" {
  count         = length(local.database_names)
  database_name = local.database_names[count.index]
  name          = "${local.prefix}-${local.database_names[count.index]}_crawler"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${local.bucket_names[count.index]}"
  }

  tags = local.common_tags

}