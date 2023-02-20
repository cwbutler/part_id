import boto3
from airtable import airtable
import os
import json

db = airtable.Airtable(os.environ['AIRTABLE_BASE_ID'], os.environ['AIRTABLE_API_KEY'])

def handler(event, _):
  try:
    photo=event["queryStringParameters"]["image"]
    labels = fetchCustomLabels(photo=photo)
    label = labels["CustomLabels"][0]
    headers = {
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
    }
    print("response: ", labels)

    if (label):
      print("label: ", label)
      partInfo = fetchPartInfo(name=label["Name"])
      print("part info: ", partInfo)

      return {
        'statusCode': 200,
        'headers': headers,
        'body': json.dumps({ "label": label, "info": partInfo })
      }
    else:
      return {
        'statusCode': 200,
        'headers': headers,
        'body': "No matching part found."
      }
  except Exception as e:
    print("Error fetching labels: ", e)
    return {
      'statusCode': 500,
      'body': json.dumps('Could not retrieve labels!')
    }

def fetchCustomLabels(photo):
    client=boto3.client('rekognition', region_name='us-east-2')
    bucket=os.environ['STORAGE_PARTIDSTORAGE_BUCKETNAME']
    model='arn:aws:rekognition:us-east-2:412989811674:project/SEC-Parts-630-alldatatrained/version/SEC-Parts-630-alldatatrained.2022-06-30T11.42.11/1656603731889'
    min_confidence=0

    print("bucket: ", bucket)
    print("photo: ", photo)
    print("model: ", model)

    #Call DetectCustomLabels
    response = client.detect_custom_labels(
      Image={'S3Object': { 'Bucket': bucket, 'Name': photo }},
      MinConfidence=min_confidence,
      ProjectVersionArn=model,
    )

    return response

def fetchPartInfo(name):
  filter = "{Part Number} = '" + name + "'"
  print("searching airtable with formula: ", filter)
  result = db.get("Parts", max_records=1, filter_by_formula=filter)
  print("search result: ", result["records"])

  if (result["records"]):
    return result["records"][0]["fields"]

  return None