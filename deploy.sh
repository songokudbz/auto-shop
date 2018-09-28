#!/usr/bin/env bash

set +
aws s3 sync ./dist/terraform/ s3://carshop.timafe.net/ --region=eu-central-1 --delete --profile=car-shop-manager
set -
