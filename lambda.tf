data "archive_file" "instance_stop" {
  type        = "zip"
  source_file  = "${path.module}/scripts/ec2_auto_stop.py"
  output_path = "${path.module}/ec2_auto_stop.zip"
}

resource "aws_lambda_function" "instance_stop" {
  filename      = data.archive_file.instance_stop.output_path
  function_name = "EC2AutoStop"
  role          = aws_iam_role.lamda_instance_role.arn
  handler       = "ec2_auto_stop.lambda_handler"  # <name_of_the_pyhton_file-<lambda_handler>
  runtime       = "python3.12"
  source_code_hash = data.archive_file.instance_stop.output_base64sha256
  timeout = 60  
  depends_on = [ aws_iam_role.lamda_instance_role]
}