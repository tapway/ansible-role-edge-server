# ansible-role-edge-server

![checks][checks]

## Table Of Contents

* [About](#about)
* [Usage](#usage)
* [Contributing](#contributing)

## About

This [Ansible][ans] role is designed to bootstrap an edge server for [Tapway](https://gotapway.com/solutions) `VisionTrack`/`VehicleTrack` applications. Follow the role's [README](edge-server/README.md) for details.

## Usage

Create `inventory.yml` file with your hosts list from the template below:

```yaml
all:
  hosts:
    tapway:
      ansible_host: <host>
      ansible_user: <user>
      ansible_ssh_private_key_file: private_key  # Should be commented if ansible_ssh_pass uncommented
#      ansible_ssh_pass: <Uncomment and replace with a real value if SSH connection use password instead of the key>
#      ansible_ssh_port: <Uncomment and replace with a real value if not default(22)>
#      ansible_become_pass: <Uncomment and replace with a real value if the user needs a password to be a sudoer>
#    <second host name>:
#      ...
```
and execute:
```shell
docker run  --network host \
  -v ./inventory.yml:/edge-server/tests/inventory.yml \
  -v <path to the SSH key>:/edge-server/tests/private_key \
  cachuperia/ansible-role-edge-server
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


[ans]: https://docs.ansible.com/
[cc]: https://www.conventionalcommits.org/en/v1.0.0/
[pk]: https://pre-commit.com/#install

[wch]: .github/workflows/checks.yml
[wr]: .github/workflows/release.yml

[checks]: https://github.com/tapway/ansible-role-edge-server/actions/workflows/checks.yml/badge.svg
