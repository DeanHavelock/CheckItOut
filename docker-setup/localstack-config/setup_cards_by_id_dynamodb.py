import json, logging, os
import resources as aws
from datetime import datetime, timedelta

logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

def create_cards_table(dynamodb, table_name):
    dynamodb.create_table(
        TableName = table_name,
        AttributeDefinitions=[
            {
                'AttributeName': 'PK', 
                'AttributeType': 'S'
            }, 
            #{
            #    'AttributeName': 'sk', 
            #    'AttributeType': 'S'
            #}
        ],
        KeySchema=[
            {
                'KeyType': 'HASH', 
                'AttributeName': 'PK'
            },
            # {
            #     'KeyType': 'RANGE', 
            #     'AttributeName': 'sk'
            # }
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 1,
            'WriteCapacityUnits': 1
        },
        BillingMode = 'PAY_PER_REQUEST'
    )

    tokens_table_check = dynamodb.describe_table(
        TableName = table_name
    )

    logging.info(f"DynamoDB: Created \"{table_name}\" dynamodb table with status: {tokens_table_check['Table']['TableStatus']}")

def create_card_by_id_details(dynamodb, table_name):
    dynamodb.put_item(
        TableName = table_name,
        Item = {
            'PK': {'S': "3a732400-0672-4f88-8e4f-558f3f34b064"},
            # 'sk': {'S': 'card_by_id'},
            'CardNumber': {'S': "1212121212121212"}, 
        }
    )

def format_time(t):
    s = t.isoformat()
    return s[:-3] + "Z" #Python UTC datetime object's ISO format doesn't include Z (Zulu or Zero offset)

def main(dynamodb):
    table_name = 'cards_by_id'
    create_cards_table(dynamodb, table_name)

    #Creating seed data for card_by_id document
    # create_card_by_id_details(dynamodb, table_name)

