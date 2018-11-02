#!/usr/bin/env bash

set -x
aws dynamodb put-item \
    --table-name madaras-cars  \
    --item \
      '{"id": {"N": "1"}, "carName": {"S": "Octavia"}, "carModel": {"S": "Skoda"}}' \
    --return-consumed-capacity TOTAL \
    --profile=car-shop-manager \
    --region=eu-central-1
aws dynamodb put-item \
    --table-name madaras-cars  \
    --item \
      '{"id": {"N": "2"}, "carName": {"S": "Fabia"}, "carModel": {"S": "Skoda"}}' \
    --return-consumed-capacity TOTAL \
    --profile=car-shop-manager \
    --region=eu-central-1
aws dynamodb put-item \
    --table-name madaras-cars  \
    --item \
      '{"id": {"N": "3"}, "carName": {"S": "Rapid"}, "carModel": {"S": "Skoda"}}' \
    --return-consumed-capacity TOTAL \
    --profile=car-shop-manager \
    --region=eu-central-1
set +x
