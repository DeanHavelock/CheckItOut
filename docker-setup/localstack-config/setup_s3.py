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

     ## Create S3 buckets
    s3 = aws.create_client(session, 's3', key_id, '4572')
    aws.create_bucket(s3, f'gateway-vault{suffix}')