# ansible-role-edge-server

![checks][ch] ![release][r] ![publish][p]

## Table Of Contents

* [About](#about)
* [Usage](#usage)
* [Contributing](#contributing)

## About

This [Ansible][ans] role is designed to bootstrap an edge server for [Tapway](https://gotapway.com/solutions) `VisionTrack`/`VehicleTrack` applications. Follow the role's [README](edge-server/README.md) for details.

## Tests

Create `inventory.yml` file with your hosts list from the template below:

```yaml
all:
  hosts:
    edge-server:
      portainer_password: <password>
      manager_cloud_api_url: <Tapway cloud API URL>
      ansible_host: <host>
      ansible_user: <user>
      ansible_ssh_private_key_file: private_key  # Should be commented if ansible_ssh_pass uncommented
#      ansible_ssh_pass: <Uncomment and replace with a real value if SSH connection use password instead of the key>
#      ansible_ssh_port: <Uncomment and replace with a real value if not default(22)>
#      ansible_become_pass: <Uncomment and replace with a real value if the user needs a password to be a sudoer>
```
### Playbook

```shell
ANSIBLE_CONFIG=./edge-server/tests/ansible.cfg ansible-playbook -i inventory.yml ./edge-server/tests/playbook.yml
```

### Docker image

Build image

```shell
docker build -t gotapway/ansible-role-edge-server:local .
```

#### SSH key

```shell
docker run --rm \
  -v ./inventory.yml:/edge-server/tests/inventory.yml \
  -v <path to the key>:/edge-server/tests/private_key \
  gotapway/ansible-role-edge-server:local
```

#### SSH password

```shell
docker run --rm \
  -v ./inventory.yml:/edge-server/tests/inventory.yml \
  gotapway/ansible-role-edge-server:local
```

## Contributing

Commit message style - [Conventional Commits][cc].

### Setup Local Environment

```shell
git clone git@github.com:tapway/ansible-role-edge-server.git
cd ansible-role-edge-server
make init
```

Run `make` to list all available targets.

### Testing

Execute `make test` for minimal docker image test or `make -C edge-server tests` for more tests.

### CD/CI

- `check` GitHub [workflow][wch].
- `release` GitHub [workflow][wr]. Release commit types: `fix`, `feat`.
- `publish` GitHub [workflow][wp].


[ans]: https://docs.ansible.com/
[cc]: https://www.conventionalcommits.org/en/v1.0.0/
[pk]: https://pre-commit.com/#install

[wch]: .github/workflows/checks.yml
[wr]: .github/workflows/release.yml
[wp]: .github/workflows/publish.yml


[ch]: https://github.com/tapway/ansible-role-edge-server/actions/workflows/checks.yml/badge.svg
[r]: https://github.com/tapway/ansible-role-edge-server/actions/workflows/release.yml/badge.svg
[p]: https://github.com/tapway/ansible-role-edge-server/actions/workflows/publish.yml/badge.svg
