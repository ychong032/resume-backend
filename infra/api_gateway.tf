resource "aws_apigatewayv2_api" "api_gateway" {
  name          = "DynamoDBOperations"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins     = ["https://www.chongyl.com"]
    allow_methods     = ["PATCH"]
    max_age           = 300
    allow_credentials = false
  }
}

resource "aws_apigatewayv2_route" "api_route" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "PATCH /visitorCount"
  target    = "integrations/${aws_apigatewayv2_integration.api_integration.id}"
}

resource "aws_apigatewayv2_integration" "api_integration" {
  api_id                 = aws_apigatewayv2_api.api_gateway.id
  integration_type       = "AWS_PROXY"
  integration_method     = "PATCH"
  integration_uri        = aws_lambda_function.lambda.arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "$default"
  auto_deploy = true
}