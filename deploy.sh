#!/usr/bin/env bash
ng build --prod
set +
aws s3 sync ./dist/terraform/ s3://carshop.timafe.net/ --region=eu-central-1 --delete --profile=car-shop-manager
set -
