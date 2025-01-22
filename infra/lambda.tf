data "archive_file" "lambda_zip" {
    type = "zip"
    source_file = "updateVisitorCount.py"
    output_path = "updateVisitorCount.zip"
}

resource "aws_lambda_function" "lambda" {
    filename = "updateVisitorCount.zip"
    function_name = "updateVisitorCount"
    handler = "updateVisitorCount.lambda_handler"
    role = aws_iam_role.lambda_role.arn

    source_code_hash = data.archive_file.lambda_zip.output_base64sha256
    runtime = "python3.13"

    environment {
      variables = {
        DDB_TABLE_NAME = "CHONGYL_RESUME_DATA"
      }
    }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
    name = "/aws/lambda/${aws_lambda_function.lambda.function_name}"

    retention_in_days = 14
}

resource "aws_lambda_permission" "lambda_permission" {
    statement_id = "updateVisitorCount-lambda-permission"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda.function_name
    principal = "apigateway.amazonaws.com"
    
    source_arn = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*/visitorCount"
}