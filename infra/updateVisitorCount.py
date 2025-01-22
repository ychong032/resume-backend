import boto3
import os

table_name = os.environ['DDB_TABLE_NAME']
dynamodb = boto3.resource('dynamodb').Table(table_name)

def lambda_handler(event, context):
    response = dynamodb.update_item(
        Key={
            'DATA_NAME': 'VISITOR_COUNT'
        },
        UpdateExpression='SET #v = #v + :inc',
        ExpressionAttributeNames={
            '#v': 'VALUE'
        },
        ExpressionAttributeValues={
            ':inc': 1
        },
        ReturnValues='UPDATED_NEW'
    )

    return response['Attributes']
