resource "aws_iam_policy" "rds_iam_authentication_policy" {
  name = "rds-iam-authentication-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        Effect: "Allow",
        Action: [
          "rds-db:connect"
        ],
        Resource: [
          "arn:aws:rds-db:${var.aws_region}:${data.aws_caller_identity.caller_identity.account_id}:dbuser:*/${var.database_user}"
        ]
      }
    ]
  })
}