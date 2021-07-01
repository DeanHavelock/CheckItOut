import json, logging, os
import resources as aws

logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

def create_vault_account_configurations_table(dynamodb, table_name):
    dynamodb.create_table(
        TableName = table_name,
        AttributeDefinitions=[
            {
                'AttributeName': 'pk', 
                'AttributeType': 'S'
            }, 
            {
                'AttributeName': 'sk', 
                'AttributeType': 'S'
            }
        ],
        KeySchema=[
            {
                'KeyType': 'HASH', 
                'AttributeName': 'pk'
            }, 
            {
                'KeyType': 'RANGE', 
                'AttributeName': 'sk'
            }
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 5,
            'WriteCapacityUnits': 5
        },
        BillingMode = 'PAY_PER_REQUEST'
    )

    configuration_table_check = dynamodb.describe_table(
        TableName = table_name
    )

    logging.info(f"DynamoDB: Created \"{table_name}\" dynamodb table with status: {configuration_table_check['Table']['TableStatus']}")

def create_configuration(dynamodb, table_name, vaultAccountId, keyId, clientId):
    #first document that has the vault account id as the pk
    build_sync = os.environ.get('BUILD_SYNC', False)

    if build_sync:
        dynamodb.put_item(
            TableName=table_name,
            Item={
                'pk': {'S':vaultAccountId},
                'sk': {'S':'configuration'},
                'sync': {'M': {
                        'sync_pull': {'BOOL': True},
                        'merchant_account_id': {'N': '100001'},
                        'business_id': {'N': '100001'},
                        'channel_id': {'N': '100001'},
                    }
                },
                'configuration_state': {'S':'active'},
                'name': {'S':'local_vault_account'},
                'client_id': {'S':clientId},
                'document_type': {'S':'configuration'},
                'created_on': {'S':'2020-01-24T19:25:11.982Z'},
                'keys': {'L': [
                    {'M':
                        {
                            'key_id': {'S':keyId},
                            'hashed_public_key': {'S': 'pdWtfVFpRvQ+TOBxHRWkRQjZjL3yJkBnLdUEOrqHnS+oog2bpNuW5ykIaZt8SKh+BARj+M0sUeK29+4FJK1czg=='}, 
                            'masked_public_key': {'S': '*********************************17a2b8'}, 
                            'encrypted_public_key': {'S': 'IGY5NzY0NTNkNjY0MjQwNjZiNzYwMmZlMWE5ZDgzMGYx7ZAVwEoUxJDbnMPJ1mg0vinLOJam6X4yDVed9O1RXGImojZNoUHXf0Z+RWfBeU3wmp8JQqDLRdsHNdoUYdn3og=='}, 
                            'created_on': {'S':'2020-01-24T19:25:11.982Z'},
                            'key_state': {'S': 'active'} 
                        }
                    },
                    {'M':
                        {
                            "key_id": {'S': 'key_3yj4oqbdodhunfz2wmot2r5t5y' },
                            "hashed_public_key": {'S': 'Lj1VYZaGd01T3LjVNphdSwRyKa5KCWFGrudQMz2r6MOtL5mgcovrX4gl0CBymJ5LJlj8ScnZIAjtffAizPpXFQ==' },
                            "masked_public_key": {'S': '*********************************22ebd4'},
                            "encrypted_public_key": {'S': 'IGY5NzY0NTNkNjY0MjQwNjZiNzYwMmZlMWE5ZDgzMGYxG5VFrrII3figzm8grz9cJ9Gb+jOA25EuKUmm2TUQHs/NtTE++BYHvSH6gWGLA5D58y970fLxzL7YNVuLUmRNVw=='},
                            "created_on":{'S': '2020-01-24T19:25:11.982Z' },
                            "key_state": {'S': 'active' }
                        }
                    }
                ]}
            }
        )
    else :
        dynamodb.put_item(
            TableName=table_name,
            Item={
                'pk': {'S':vaultAccountId},
                'sk': {'S':'configuration'},
                'configuration_state': {'S':'active'},
                'name': {'S':'local_vault_account'},
                'client_id': {'S':clientId},
                'document_type': {'S':'configuration'},
                'created_on': {'S':'2020-01-24T19:25:11.982Z'},
                'keys': {'L': [
                    {'M':
                        {
                            'key_id': {'S':keyId},
                            'hashed_public_key': {'S': 'pdWtfVFpRvQ+TOBxHRWkRQjZjL3yJkBnLdUEOrqHnS+oog2bpNuW5ykIaZt8SKh+BARj+M0sUeK29+4FJK1czg=='}, 
                            'masked_public_key': {'S': '*********************************17a2b8'}, 
                            'encrypted_public_key': {'S': 'IGY5NzY0NTNkNjY0MjQwNjZiNzYwMmZlMWE5ZDgzMGYx7ZAVwEoUxJDbnMPJ1mg0vinLOJam6X4yDVed9O1RXGImojZNoUHXf0Z+RWfBeU3wmp8JQqDLRdsHNdoUYdn3og=='}, 
                            'created_on': {'S':'2020-01-24T19:25:11.982Z'},
                            'key_state': {'S': 'active'} 
                        }
                    },
                    {'M':
                        {
                            "key_id": {'S': 'key_3yj4oqbdodhunfz2wmot2r5t5y' },
                            "hashed_public_key": {'S': 'Lj1VYZaGd01T3LjVNphdSwRyKa5KCWFGrudQMz2r6MOtL5mgcovrX4gl0CBymJ5LJlj8ScnZIAjtffAizPpXFQ==' },
                            "masked_public_key": {'S': '*********************************22ebd4'},
                            "encrypted_public_key": {'S': 'IGY5NzY0NTNkNjY0MjQwNjZiNzYwMmZlMWE5ZDgzMGYxG5VFrrII3figzm8grz9cJ9Gb+jOA25EuKUmm2TUQHs/NtTE++BYHvSH6gWGLA5D58y970fLxzL7YNVuLUmRNVw=='},
                            "created_on":{'S': '2020-01-24T19:25:11.982Z' },
                            "key_state": {'S': 'active' }
                        }
                    }
                ]}
            }
        )

    #second document with the client id as the pk
    dynamodb.put_item(
        TableName=table_name,
        Item={
            'pk': {'S':clientId},
            'sk': {'S':'client_id'},
            'vault_account_id': {'S':vaultAccountId},
            'document_type': {'S':'client_id'},
            'created_on': {'S':'2020-01-24T19:25:11.982Z'}
        }
    )

    #key document
    dynamodb.put_item(
        TableName=table_name,
        Item={
            'pk': {'S':'pkh_pdWtfVFpRvQ+TOBxHRWkRQjZjL3yJkBnLdUEOrqHnS+oog2bpNuW5ykIaZt8SKh+BARj+M0sUeK29+4FJK1czg=='},
            'sk': {'S':'public_key'},
            'key_id': {'S':keyId},
            'vault_account_id': {'S':vaultAccountId},
            'key_state': {'S':'active'},
            'document_type': {'S':'public_key'},
            'created_on': {'S':'2020-01-24T19:25:11.982Z'}
        }
    )

    #key document
    dynamodb.put_item(
        TableName=table_name,
        Item={
            'pk': {'S':'pkh_Lj1VYZaGd01T3LjVNphdSwRyKa5KCWFGrudQMz2r6MOtL5mgcovrX4gl0CBymJ5LJlj8ScnZIAjtffAizPpXFQ=='},
            'sk': {'S':'public_key'},
            'key_id': {'S':'key_3yj4oqbdodhunfz2wmot2r5t5y'},
            'vault_account_id': {'S':vaultAccountId},
            'key_state': {'S':'active'},
            'document_type': {'S':'public_key'},
            'created_on': {'S':'2020-01-24T19:25:11.982Z'}
        }
    )

def main(dynamodb):
    table_name = 'vault_account_configurations_local'
    create_vault_account_configurations_table(dynamodb, table_name)
    #pk_299f3e35-75b8-4910-bc58-4ad77417a2b8
    ##pk_f74ac47a-7a81-46b2-a307-7dcab122ebd4 - second key that won't match the google shared secret.
    create_configuration(dynamodb, table_name, 'vact_pv4252lxn3guxcntd4omswwwee', 'key_nvs3fcnz6bvunhiwxf2ykunfaa', 'cli_axclravnqf5u5ejkweijnp5zc4')
