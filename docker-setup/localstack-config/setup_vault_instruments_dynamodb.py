import json, logging, os
import resources as aws

logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

def create_vault_instruments_table(dynamodb, table_name):
    dynamodb.create_table(
        TableName = table_name,
        AttributeDefinitions=[
            {
                'AttributeName': 'instrument_key', 
                'AttributeType': 'S'
            }, 
            {
                'AttributeName': 'sort_key', 
                'AttributeType': 'S'
            }
        ],
        KeySchema=[
            {
                'KeyType': 'HASH', 
                'AttributeName': 'instrument_key'
            }, 
            {
                'KeyType': 'RANGE', 
                'AttributeName': 'sort_key'
            }
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 5,
            'WriteCapacityUnits': 5
        },
        BillingMode = 'PAY_PER_REQUEST'
    )

    instruments_table_check = dynamodb.describe_table(
        TableName = table_name
    )

    logging.info(f"DynamoDB: Created \"{table_name}\" dynamodb table with status: {instruments_table_check['Table']['TableStatus']}")

def main(dynamodb):
    table_name = 'vault_instruments_local'
    create_vault_instruments_table(dynamodb, table_name)

