## Chart Testing

This folder contains a series of manually-ran scenario tests used to ensure this
chart works as expected and a Makefile to facilitate running the tests against a
Kubernetes cluster.

## Prerequisites

You will need `make`, `helm`, and `kubectl` installed and `kubectl` will need to
be configured to use to the kubernetes cluster to test with.

_All commands should be run from the `tests/` directory._

## Basic Test

An easy smoke test. Just deploy a release and ensure the pod becomes ready.

```
# Deploy the test release
make deploy-basic-test

# Check the release status using
helm status basic-test

# Clean up the test release
make clean-basic-test
```