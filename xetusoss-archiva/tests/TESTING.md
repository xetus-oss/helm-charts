## Chart Testing

This folder contains a series of manually-ran scenario tests used to ensure this chart works as expected and a Makefile which should make running them against a test cluster.

## Prerequisites

You will need `make`, `helm`, and `kubectl` installed and `kubectl` will need to be configured to use to the kubernetes cluster to test with.

_All commands should be ran from the `tests/` directory_

## Basic Test

An easy smoke test. Just deploy a release and ensure the archiva pod becomes ready.

```
# Deploy the test release
make deploy-basic-test

# Check the release status using
helm -n test status basic-test

# Clean up the test release
make clean-basic-test
```

## Ingress Test

Tests the proxy and ingress configuration together to ensure they work all the way out to deployment.

```
# Deploy the test release
make deploy-ingress-test

# Check the release status using
helm -n test status ingress-test

# Issue the following command, replacing CLUSTER_INGRESS_HTTPS_FROTNEND with the right host or ip.
curl -k -H'Host: archiva.test' CLUSTER_INGRESS_HTTPS_FROTNEND

# Clean up the test release
make clean-ingress-test
```

## MySQL Test

Tests that the `userdb` configuration works with `userdb.type=mysql`.

```
# Deploy the test release
make deploy-mysql-test

# Check the release status using
helm -n test status mysql-test

# Clean up the test release
make clean-mysql-test
```

## Existing PVC Test

Tests that an existing PVC can be used, when configured.

```
# Deploy the test release
make deploy-existing-pvc-test

# Check the release status using
helm -n test status existing-pvc-test

# Clean up the test release
make clean-existing-pvc-test
```

## Provisioner created PVC test

Tests that an existing PVC can be used, when configured.

```
# Deploy the test release
make deploy-provisoner-pv-test

# Check the release status using
helm -n test status provisoner-pv-test

# Clean up the test release
make clean-provisoner-pv-test
```

## CACerts Secret Test

Tests that releases which specify the `archiva.caCertsSecret` deploy correctly.

```
# Deploy the test release
make deploy-casecret-test

# Check the release status using
helm -n test status casecret-test

# Clean up the test release
make clean-casecret-test
```

## PriorityClass Test

Tests that the priortiy class feature works as expected.

```
# Deploy the test release
make deploy-priorityclass-test

# Check the release status using
helm -n test status priorityclass-test

# Clean up the test release
make clean-priorityclass-test

```