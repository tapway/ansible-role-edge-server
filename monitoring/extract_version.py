import yaml

with open('../edge-server/defaults/main.yml', 'r') as file:
    config = yaml.safe_load(file)
    netdata_version = config.get('netdata_version')
    print(netdata_version)
