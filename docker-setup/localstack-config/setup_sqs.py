import json, logging, os
import resources as aws

logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

def main():
    key_id = os.environ.get('AWS_SECRET_KEY_ID', 'xxx')
    session = aws.create_session(
        key_id,
        os.environ.get('AWS_SECRET_ACCESS_KEY', 'xxx'),
        os.environ.get('REGION_NAME', 'eu-west-2')
    )

    suffix = os.environ.get('SUFFIX', '-local')

     ## Create SQS queues
    sqs = aws.create_client(session, 'sqs', key_id, '4576')
    aws.create_sqs_queue(sqs, f'gateway-vault{suffix}')
    aws.create_sqs_queue(sqs, f'vault-tokens{suffix}')
    aws.create_sqs_queue(sqs, f'vault-instrument-importer{suffix}')
    aws.create_sqs_queue(sqs, f'vault-instrument-importer-dead-letter{suffix}')
    aws.create_sqs_queue(sqs, f'vault-instrument-importer-prio{suffix}')
    aws.create_sqs_queue(sqs, f'vault-instrument-importer-prio-dead-letter{suffix}')

    build_sync = os.environ.get('BUILD_SYNC', False)

    if build_sync:
        aws.create_sqs_queue(sqs, f'vault-sync{suffix}')
        aws.create_sqs_queue(sqs, f'vault-sync-dead-letter{suffix}')
    