# ansible-role-edge-server

![checks][checks]

## Table Of Contents

* [About](#about)
* [Usage](#usage)
  * [Requirements](#requirements)
  * [Role Variables](#role-variables)
  * [Role Tags](#role-tags)
  * [Usage Example](#usage-example)
* [Contributing](#contributing)

## About

This [Ansible][ans] role is designed to bootstrap an edge server for [Tapway](https://gotapway.com/solutions) `VisionTrack`/`VehicleTrack` applications. Follow the role's [README](edge-server/README.md) for details.

## Usage

COMING SOON

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

COMING SOON

### CD/CI

- `check` GitHub [workflow][wch].


[ans]: https://docs.ansible.com/
[cc]: https://www.conventionalcommits.org/en/v1.0.0/
[pk]: https://pre-commit.com/#install

[wch]: .github/workflows/checks.yml
[wr]: .github/workflows/release.yml

[checks]: https://github.com/tapway/ansible-role-edge-server/actions/workflows/checks.yml/badge.svg
