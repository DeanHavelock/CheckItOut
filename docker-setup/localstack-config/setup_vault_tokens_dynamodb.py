import json, logging, os
import resources as aws
from datetime import datetime, timedelta

logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

def create_tokens_table(dynamodb, table_name):
    dynamodb.create_table(
        TableName = table_name,
        AttributeDefinitions=[
            {
                'AttributeName': 'token_key', 
                'AttributeType': 'S'
            }, 
            {
                'AttributeName': 'sort_order', 
                'AttributeType': 'S'
            }
        ],
        KeySchema=[
            {
                'KeyType': 'HASH', 
                'AttributeName': 'token_key'
            }, 
            {
                'KeyType': 'RANGE', 
                'AttributeName': 'sort_order'
            }
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 5,
            'WriteCapacityUnits': 5
        },
        BillingMode = 'PAY_PER_REQUEST'
    )

    tokens_table_check = dynamodb.describe_table(
        TableName = table_name
    )

    logging.info(f"DynamoDB: Created \"{table_name}\" dynamodb table with status: {tokens_table_check['Table']['TableStatus']}")

def create_ttl(dynamodb, table_name):
    dynamodb.update_time_to_live(
        TableName=table_name,
        TimeToLiveSpecification={
            'AttributeName': 'delete_on',
            'Enabled': True
        }
    )

def create_card_token_document(dynamodb,table_name,pk,expires_on, delete_on):
    dynamodb.put_item(
        TableName=table_name,
        Item={
                'token_key': {'S':pk},
                'sort_order': {'S':'sort_order_0'},
                'document_type': {'S':'active_full_card_token'},
                'expires_on': {'S':format_time(expires_on)},
                'delete_on': {'N':dateToTimestampString(delete_on)},
                'encrypted_token_details': {'S':'IGY5NzY0NTNkNjY0MjQwNjZiNzYwMmZlMWE5ZDgzMGYxAEni26YGb6OWx5jGe87xbqkEuy9JBama6yrPW/MiDCsN663it/xN4jWMmNDI80BnTDc9UjkLkv4kKe5Lnl/VymsQs0gKmZ7nnhi4zOzCGoxDTr7pYiD3M6nPBRzx5Xv+cma+Ly1iW2Gjv7LgGBgUbc1oNi3izoqd3GD/SyTPbwJU1JeWDypGdOV55FcbWWj4Xjqf9u8bg/QJOFtioZo7bdQEjV1n9qxpAr6Yqe2QNgdW5ovoBbM3V8q2Q/QDR+VWJmGHvnRG43aSuJDRRJ9++s7FjxPO1iZws7jOKlHOGTMSHvVeCsWdIzWCwUpLuP5wq6Q2g3akjMHnwHqoZUtjTDyzRhQnhno+5MvSMB2OQ88ayPMlhZfaOwsx5rTDc7Mn'},
                'type': {'S':'card'},
                'vault_id': {'S':'65cbb575-e5c3-4ce6-b04a-12dc0b2973e6'},
            }
    )

def create_expiring_card_token_document(dynamodb,table_name, pk, expires_on, delete_on):
    dynamodb.put_item(
        TableName=table_name,
        Item={
                'token_key': {'S':pk},
                'sort_order': {'S':'sort_order_1'},
                'document_type': {'S':'expired_or_used_full_card_token'},
                'expires_on': {'S':format_time(expires_on)},
                'delete_on': {'N':dateToTimestampString(delete_on)},
            }
    )

def create_card_digital_wallet_token_document(dynamodb,table_name,pk,expires_on, delete_on):
    dynamodb.put_item(
        TableName=table_name,
        Item={
                'token_key': {'S':pk},
                'sort_order': {'S':'sort_order_0'},
                'document_type': {'S':'active_full_card_token'},
                'expires_on': {'S':format_time(expires_on)},
                'delete_on': {'N':dateToTimestampString(delete_on)},
                'encrypted_token_details': {'S':'IGY5NzY0NTNkNjY0MjQwNjZiNzYwMmZlMWE5ZDgzMGYxGaqeOZGCKk61CFxn25rztcAtvkMZPi/dyDXUl4OO2tgTuph8OWVQN+1v2w+lcBjjlfwSIT9/T5bBWe/iqBJBNEiriMreVUJgT5yv6rLRb4z+2VgnfcPxnVmdE/9WJ8ZJFMZNRDaj+qLbr3jQI6KqTMadNufzNkcnOxma+xU5tF+T2IFh9dvkUE1knuK/NumdGW2MDU7uWS7J6pnU8efOf5BJ0c+CmzjWda10CsksAuMdZFvO3jhiyYC7s8lQMLEQWu7j5/Pl469aO3PvsJTxq/f9iBjtRA9nq9Axt5b5+/oMEs95yKpW3TLutuhXjSGqL5R1QV2ofP5ScMuoEUt+v/E0XeBP2Q6AgUwfqk3UhEuUidy0KAV1b39y9HTospjt'},
                'type': {'S':'card'},
                'vault_id': {'S':'5b83fbc4-c8a7-466b-a009-ba4050376e1a'},
                'eci_indicator': {'S':'07'},
                'cryptogram': {'S':'cryptogram'}
            }
    )

def create_expiring_card_digital_wallet_token_document(dynamodb,table_name, pk, expires_on, delete_on):
    dynamodb.put_item(
        TableName=table_name,
        Item={
                'token_key': {'S':pk},
                'sort_order': {'S':'sort_order_1'},
                'document_type': {'S':'expired_or_used_full_card_token'},
                'expires_on': {'S':format_time(expires_on)},
                'delete_on': {'N':dateToTimestampString(delete_on)},
            }
    )

def dateToTimestampString(date):
    return str(int(date.timestamp()))

def format_time(t):
    s = t.isoformat()
    return s[:-3] + "Z" #Python UTC datetime object's ISO format doesn't include Z (Zulu or Zero offset)

def main(dynamodb):
    table_name = 'vault_tokens_local'
    create_tokens_table(dynamodb, table_name)
    create_ttl(dynamodb, table_name)

    now = datetime.utcnow()
    in_sixty_mins = (now + timedelta(seconds=3600))
    in_fifteen_mins = (now + timedelta(seconds=900))

    #Not used but expired token
    create_expiring_card_token_document(
        dynamodb, 
        table_name, 
        'vact_eklgihgahppe7jirmp3jgcx654_tok_72nodsvgoorunloidgxwcsimwa', 
        now,
        in_sixty_mins
    )

    #Creating a token to be used in the SDK tests
    create_card_token_document(
        dynamodb,
        table_name,
        'vact_v7qyygurrbfuxhw7ueg73h33xi_tok_pbn5wtu6ljzelgcnmstp3pglny',
        in_fifteen_mins,
        in_sixty_mins
    )

    create_expiring_card_token_document(
        dynamodb, 
        table_name, 
        'vact_v7qyygurrbfuxhw7ueg73h33xi_tok_pbn5wtu6ljzelgcnmstp3pglny',
        in_fifteen_mins,
        in_sixty_mins
    )

    #Creating a token for digital wallets to be used in the SDK tests
    create_card_digital_wallet_token_document(
        dynamodb,
        table_name,
        'vact_v7qyygurrbfuxhw7ueg73h33xi_tok_coxjpprjcjiu3blmc55x53xuia',
        in_fifteen_mins,
        in_sixty_mins
    )

    create_expiring_card_digital_wallet_token_document(
        dynamodb, 
        table_name, 
        'vact_v7qyygurrbfuxhw7ueg73h33xi_tok_coxjpprjcjiu3blmc55x53xuia',
        in_fifteen_mins,
        in_sixty_mins
    )


