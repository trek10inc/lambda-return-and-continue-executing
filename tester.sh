#!/usr/bin/env bash -x

# get the lambda URL
lambda_url=$(aws lambda list-function-url-configs --function-name Trek10-Lambda-Test-Function-With-Url --output text --query 'FunctionUrlConfigs[0].FunctionUrl')

# call the lambda URL
time curl -sS $lambda_url -i | tee result_url.txt

request_id=$(grep Hello result_url.txt | cut -f6 -d' ')

sleep 20
# get the logs
aws logs filter-log-events \
    --log-group-name /aws/lambda/Trek10-Lambda-Test-Function-With-Url \
    --filter-pattern "\"$request_id\"" \
    --output text --query 'events[*].message'


# call the no URL lambda via api
time aws lambda invoke --function-name Trek10-Lambda-Test-Function-With-No-Url result_no_url.txt

request_id=$(grep Hello result_no_url.txt | cut -f6 -d' ')

sleep 20
# get the logs
aws logs filter-log-events \
    --log-group-name /aws/lambda/Trek10-Lambda-Test-Function-With-No-Url \
    --filter-pattern "\"$request_id\"" \
    --output text --query 'events[*].message'
exit
