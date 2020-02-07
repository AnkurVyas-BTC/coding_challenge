echo "\n Creating Package"
sam package --template-file template.yaml --output-template-file packaged-template.yaml --s3-bucket codingchallenge-btc

echo "\n Deploying Package"
sam deploy --template-file packaged-template.yaml --stack-name codingchallenge-btc --capabilities CAPABILITY_IAM

echo "\n Deployed."
