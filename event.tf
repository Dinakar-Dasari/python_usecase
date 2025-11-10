resource "aws_cloudwatch_event_rule" "ec2_auto_stop_rule" {
  name                  = "lambda_ec2_stop"
  description           = "trigger the lambda function"
  schedule_expression   =  "cron(18 15 ? * MON-FRI *)"
}

  # why not "cron(18 15 * * MON-FRI *)"
  # It means every day of the month also saying only MON-FRI, so it's kinda conflicting
  # "?" --> No specific value — ignore this field.
  # it means, Ignore Day-of-Month (because it’s ?) & Apply only Day-of-Week = MON-FRI

resource "aws_cloudwatch_event_target" "ec2_auto_stop_target" {
  rule      = aws_cloudwatch_event_rule.ec2_auto_stop_rule.name
  target_id = "EC2AutoStopLambda"
   arn       = aws_lambda_function.instance_stop.arn  
}  

# Who can call Lambda 
resource "aws_lambda_permission" "allow_cloudwatch_to_call_ec2_auto_stop" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.instance_stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_auto_stop_rule.arn
}

# So the caller (CloudWatch Events) is an AWS-managed service, not a user or IAM principal under your account.
# EventBridge is an AWS service calling another service (Lambda) — and it doesn’t need an IAM role.
