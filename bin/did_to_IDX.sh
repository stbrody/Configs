#!/bin/bash

DID=$1

curl https://gateway.ceramic.network/api/v0/streams -X POST -d '{
      "type": 0,
      "genesis": {
        "header": {
          "family": "IDX",
          "controllers": ["'$DID'"]
        }
      },
      "opts": {
        "pin": false,
        "sync": false,
        "anchor": false
      }
    }' -H "Content-Type: application/json"

echo ""
