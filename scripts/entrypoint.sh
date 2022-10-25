#!/bin/bash

python3 user-documentation/scripts/link-docs.py

echo "I have built the User Documentation"

mkdocs "$@"