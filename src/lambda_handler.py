import json
import boto3
#print(boto3.__version__)
client_bedrock = boto3.client('bedrock-runtime')

def lambda_handler(event, context):
    # TODO implement
    
    input_prompt= event['prompt']
    print(input_prompt)
    
    client_bedrockrequest = client_bedrock.invoke_model(
        contentType='application/json',
        accept='application/json',
        modelId='cohere.command-light-text-v14',
        body=  json.dumps({
        "prompt": input_prompt,
        "temperature": 0.9,
        "p": 0.75,
        "k": 0,
        "max_tokens": 100}))
    #print(client_bedrockrequest)
    
    client_bedrock_byte = client_bedrockrequest['body'].read()
    client_bedrock_string = json.loads(client_bedrock_byte)
    #print(client_bedrock_string)
    
    client_final_response = client_bedrock_string['generations'][0]['text']
    #print(client_final_response)s