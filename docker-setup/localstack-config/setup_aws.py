import os
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
import resources as aws

# import setup_vault_tokens_dynamodb 
import setup_cards_by_id_dynamodb
# import setup_vault_instruments_dynamodb
# import setup_vault_account_configurations_dynamodb
# import setup_sqs
# import setup_s3

def check_localstack(endpoint):
    session = requests.Session()
    retry = Retry(total=10, backoff_factor=0.05)
    adapter = HTTPAdapter(max_retries=retry)
    session.mount('http://', adapter)
    session.mount('https://', adapter)

    endpoint = os.environ.get('ENDPOINT_URL', 'localhost')
    session.get(f'http://{endpoint}:8080')

def create_dynamodb():
    key_id = os.environ.get('AWS_SECRET_KEY_ID', 'xxx')
    session = aws.create_session(
        key_id,
        os.environ.get('AWS_SECRET_ACCESS_KEY', 'xxx'),
        os.environ.get('REGION_NAME', 'eu-west-2')
    )

    return aws.create_client(session, 'dynamodb', key_id, '4569')

if __name__== "__main__":
    endpoint = os.environ.get('ENDPOINT_URL', 'localhost')
    check_localstack(endpoint)

    dynamodb = create_dynamodb()

    # setup_vault_tokens_dynamodb.main(dynamodb)
    setup_cards_by_id_dynamodb.main(dynamodb)
    # setup_vault_instruments_dynamodb.main(dynamodb)
    # setup_vault_account_configurations_dynamodb.main(dynamodb)

    # setup_sqs.main()
    # setup_s3.main()
