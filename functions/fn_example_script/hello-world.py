import json
import os

def lambda_handler(event, context):
    print('## ENVIRONMENT VARIABLES')
    print(os.environ)
    print('## EVENT')
    print(event)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }