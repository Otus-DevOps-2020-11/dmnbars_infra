#!/bin/bash
scriptPath="$( cd "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
python $scriptPath/../../inventory_terraform.py prod
