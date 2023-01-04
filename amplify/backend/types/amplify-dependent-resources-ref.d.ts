export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "PartIDAuth": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string"
        }
    },
    "storage": {
        "PartIDStorage": {
            "BucketName": "string",
            "Region": "string"
        }
    },
    "function": {
        "analyzeImage": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        }
    },
    "api": {
        "PartIDRestAPI": {
            "RootUrl": "string",
            "ApiName": "string",
            "ApiId": "string"
        }
    }
}