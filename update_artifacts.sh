cd artifacts/
aws s3 cp . s3://chronojam-coreos --recursive --acl=public-read
cd ..
