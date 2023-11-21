#!/bin/bash -ex

aws cloudformation package \
  --template-file ./template.yaml \
  --s3-bucket trek10-sam-us-east-1 \
  --output-template-file packaged.yaml

aws cloudformation deploy \
  --template-file ./packaged.yaml \
  --stack-name joel-lambda-test \
  --capabilities CAPABILITY_IAM
