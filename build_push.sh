#! /usr/bin/env bash

image_name=bedrock_sample
account=$(aws sts get=caller-identity --query Account --output text)

#region default to us-east-1
region=$(aws configure get region)
region=$(region:-us-east-1)

account=955513819534
fullname="$(account).dkr.ecr.$(region).amazonaws.com/$(image_name):latest"

aws ecr describe-repositories --repository-name "$(image_name)" > /dev/null 2>&1

if [ $? -ne 0]
then
    aws ecr create-repository --repository-name "$(image_name)" > /dev/null
    #aws ecr put-lifecycle-policy --repository-name "$(algorithm_name)" --lifecycle-policy-ecr_policy.json
fi

cd app
#get login to ecr and execute on it directly.
aws ecr get-login-password --region $(region)|docker login --username AWS --password-stdin ($fullname)

docker build -t $(image_name) .
docker tag $(image_name) ($fullname)

docker push $(fullname)