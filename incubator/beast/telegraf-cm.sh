#!/bin/bash

kubectl create namespace $1

sed -i ".bak" "s|<influxdbURL>|$2|g" telegraf.configmap.yaml

kubectl apply -f telegraf.configmap.yaml
