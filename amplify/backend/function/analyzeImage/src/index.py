import boto3
import os
import json

def handler(event, context):
  print('received event:')
  print(event)

  try:
    bucket=os.environ['STORAGE_PARTIDSTORAGE_BUCKETNAME']
    photo=event["pathParameters"]["image"]
    model='arn:aws:rekognition:us-east-2:412989811674:project/SEC-Parts-630-alldatatrained/version/SEC-Parts-630-alldatatrained.2022-06-30T11.42.11/1656603731889'
    min_confidence=95
    
    labels = fetchCustomLabels(
      model=model,
      bucket=bucket,
      photo=photo,
      min_confidence=min_confidence
    ) 

    return {
      'statusCode': 200,
      'headers': {
          'Access-Control-Allow-Headers': '*',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
      },
      'body': json.dumps(labels["CustomLabels"])
    }
  except Exception as e:
    print(e)
    return {
      'statusCode': 500,
      'body': json.dumps('Could not retrieve labels!')
    }

def fetchCustomLabels(model, bucket, photo, min_confidence):
    client=boto3.client('rekognition')

    #Call DetectCustomLabels
    response = client.detect_custom_labels(
      Image={'S3Object': { 'Bucket': bucket, 'Name': photo }},
      MinConfidence=min_confidence,
      ProjectVersionArn=model,
    )

    # For object detection use case, uncomment below code to display image.
    # display_image(bucket,photo,response)

    return response