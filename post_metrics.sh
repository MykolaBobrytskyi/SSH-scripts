#!/bin/bash

# Receive Auth Token
token=$(curl -s -X POST "$3/auth/login/" \
	-H "accept: application/json" \
	-H "Content-Type: application/json" \
	-d "{ \"email\": \"$1\", \"password\": \"$2\"}"\
	|jq -e .access_token \
	|xargs)

echo "The token is $token"

# Get Domain ID
curl -s -X GET "$3/api/v1/domains/" \
				-H "accept: application/json" \
       	-H "Authorization: Token $token" > domains.json

domain_id=$(jq . domains.json |grep -B 1 Transaction |grep -E \"id\"\: |awk '{print $2}' |rev |cut -c 2-)

echo "The ID is $domain_id"

rm ./domains.json

# Post metrics
version=$(jq -e .version ./mrnn/metrics.json |xargs)
validation_metrics=$(jq -rce . ./mrnn/metrics.json |cat)

echo "The version is $domain_id"
echo $validation_metrics

curl -X POST "$3/v1/naas_models/" \
		-H "accept: application/json" \
		-H "Content-Type: application/json" \
		-H "Authorization: Token $token" \
		-d "{ \"version\": \"$version\", \"validation_metrics\": $validation_metrics, \"domain\": \"$domain_id\"}"
