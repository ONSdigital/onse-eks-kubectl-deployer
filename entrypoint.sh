#!/usr/bin/env bash

kubectl config \
  set-cluster kubernetes \
  --server=$KUBERNETES_SERVER \
  --certificate-authority=<(echo $KUBERNETES_CA)
