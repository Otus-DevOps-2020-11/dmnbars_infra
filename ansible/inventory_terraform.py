#!/usr/bin/env python
import json
import subprocess
import sys

environment = 'stage'
if len(sys.argv) > 1:
    environment = sys.argv[1]

ips = {
    "external_ip_address_app": "",
    "external_ip_address_db": "",
    "internal_ip_address_db": ""
}

for key in ips:
    result = subprocess.run(f'cd ../terraform/{environment} && terraform output {key}', shell=True, stdout=subprocess.PIPE)
    ips[key] = result.stdout.strip().decode()

inventory = {
    "_meta": {
        "hostvars": {
            "appserver": {
                "ansible_host": ips["external_ip_address_app"],
            },
            "dbserver": {
                "ansible_host": ips["external_ip_address_db"]
            }
        }
    },
    "all": {
        "children": ["app", "db"]
    },
    "app": {
        "hosts": ["appserver"],
        "vars": {
            "db_host": ips["internal_ip_address_db"]
        }
    },
    "db": {
        "hosts": ["dbserver"],
        "vars": {
            "mongo_bind_ip": ips["internal_ip_address_db"]
        }
    }
}

print(json.dumps(inventory, indent=4, sort_keys=True))
