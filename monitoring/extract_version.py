import sys
import yaml


app = sys.argv[1].strip()


def get_version(app):
    with open('../edge-server/defaults/main.yml', 'r') as file:
        config = yaml.safe_load(file)
        return config.get(app)


version = get_version(app)
print(version)
