resource "aws_dynamodb_table" "resume_data" {
    name = "CHONGYL_RESUME_DATA"
    hash_key = "DATA_NAME"

    attribute {
      name = "DATA_NAME"
      type = "S"
    }

    billing_mode = "PAY_PER_REQUEST"
}

# resource "aws_dynamodb_table_item" "visitor_count" {
#     table_name = aws_dynamodb_table.resume_data.name
#     hash_key = aws_dynamodb_table.resume_data.hash_key

#     item = <<ITEM
#     {
#         "DATA_NAME": {"S": "VISITOR_COUNT"},
#         "VALUE": {"N": "0"}
#     }
#     ITEM
# }