import boto3
import urllib.request

# Constantes
tmp_folder_path = "/tmp"
bucket_folder = "raw-data"

def get_data(file_url, file_name):
    output_path = f'{tmp_folder_path}/{file_name}'
    urllib.request.urlretrieve(file_url, output_path)
    return output_path

def handler(event, context):

    bucket_name = event['BUCKET']
    file_url = event['FILE_URL']

    file_name = file_url.split('/')[-1]
    file_path = get_data(file_url, file_name)

    s3 = boto3.client("s3")
    object_name = f'{bucket_folder}/{file_name}'
    s3.upload_file(file_path, bucket_name, object_name)

    return {
        'statusCode': 200,
        'body': f"Subiu o arquivo {object_name} para o bucket {bucket_name}. E nois que voa!"
    }