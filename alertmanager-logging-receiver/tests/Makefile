#
# A simple Makefile for manual chart testing.
#
TEST_NAMESPACE := test

.PHONY: help
help: Makefile
	@echo
	@echo " Available Targets"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' | sed -e 's/^/ /'

## lint: lint each of the tests
lint:
	helm lint ../

## deploy-basic-test: deploy the basic test release to the k8s cluster
deploy-basic-test:
	kubectl create namespace $(TEST_NAMESPACE)
	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name basic-test\
		$(IMAGE_ARGS)\
		../

## clean-basic-test: purge the basic test release from the k8s cluster
clean-basic-test:
	-helm delete --purge basic-test
	-kubectl delete namespace $(TEST_NAMESPACE)

