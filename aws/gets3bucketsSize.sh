#!/bin/bash

#note aws key should be setup already in your environment

bucketlist="$(aws s3api list-buckets --query "Buckets[].Name" | cut -d\" -f2 | cut -d[ -f1 | cut -d] -f1)"

for bucket in $bucketlist; do
    size=$(aws s3 ls s3://$bucket --recursive | awk 'BEGIN {total=0}{total+=$3}END{print total/1024/1024" MB"}')
    echo $bucket current size: $size
done
