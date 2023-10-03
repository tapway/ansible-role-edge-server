# Tests

## CPU AMD64

### Prerequisites

- Vagrant.
- Virtualbox.

### Test

Execute `make test-cpu`.

## GPU AMD64

### Prerequisites

- An AWS account.

### Test

- Launch EC2 instance.

![AWS console](../../docs/gpu_instance.png)

- Change [inventory](inventory.yml) `ec2-focal64` instance IP to the actual.
- Execute `make test-gpu`.
- Delete EC2 instance.
