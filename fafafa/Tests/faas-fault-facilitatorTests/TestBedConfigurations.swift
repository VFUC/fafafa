//
//  TestBedConfigurations.swift
//  
//
//  Created by Jonas Wippermann on 12.02.22.
//

import Foundation

struct TestBedConfigurations {
    /// config verified by successfully deploying using `serverless deploy`
    static let nodeHTTPApiConfig = """
org: wonas
app: testbed-aws-node-http-api
service: aws-node-http-api
frameworkVersion: '3'

provider:
  name: aws
  region: eu-central-1
  iam:
    role:
      name: custom-role-name
      statements:
        - Effect: 'Allow'
          Resource: 'arn:aws:s3:::awstestbed.mybucket/*'
          Action: 's3:GetObject'

functions:
  hello:
    runtime: nodejs14.x
    handler: handler.hello
    architecture: arm64
    memorySize: 512
    maximumRetryAttempts: 1
    environment:
      APP_ENDPOINT: example.com
    events:
      - httpApi:
          path: /
          method: get
    vpc:
      securityGroupIds:
        - sg-01c05c462b5e7bb89
      subnetIds:
        - subnet-00367cabb6c4c3869
  bye:
    runtime: nodejs12.x
    handler: byeHandler.bye
    timeout: 20
    maximumEventAge: 300
    provisionedConcurrency: 1
    reservedConcurrency: 5
    layers:
      - arn:aws:lambda:eu-central-1:799383571723:layer:AWS-SDK-v2_713_0:1
    events:
      - httpApi:
          path: /bye
          method: get

  imageHello:
    image: 799383571723.dkr.ecr.eu-central-1.amazonaws.com/aws-lambda-hello:latest
    events:
      - httpApi:
          path: /image
          method: get

  packagedHello:
    runtime: nodejs14.x
    handler: handler.hello
    package:
      artifact: handler.zip
    events:
      - httpApi:
          path: /packaged
          method: get

"""
}
