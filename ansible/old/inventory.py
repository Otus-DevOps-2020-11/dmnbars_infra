#!/usr/bin/env python
import json

f = open("inventory.json", "r")
data = json.load(f)

inventory = {
    "_meta": {"hostvars": {}},
    "all": {"children": []},
}

all_hosts = data["all"]["children"]
for group in all_hosts:
    group_hosts = all_hosts[group]["hosts"]
    inventory["all"]["children"].append(group)
    inventory[group] = {"hosts": []}

    for host in all_hosts[group]["hosts"]:
        inventory["_meta"]["hostvars"][host] = group_hosts[host]
        inventory[group]["hosts"].append(host)

print(json.dumps(inventory, indent=4, sort_keys=True))
