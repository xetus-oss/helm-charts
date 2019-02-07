#
# A simple Makefile for manual chart testing.
#
TEST_NAMESPACE := test
IMAGE_ARGS=
ifneq ($(ARCHIVA_REPO),)
	IMAGE_ARGS="--set image.repo=$(ARCHIVA_REPO)"
endif

ifneq ($(ARCHIVA_TAG),)
	IMAGE_ARGS += "--set image.tag=$(ARCHIVA_TAG)"
endif

showvars:
	@echo IMAGE_ARGS=$(IMAGE_ARGS)

lint:
	helm lint ../
	helm lint -f basic-values.yaml ../
	helm lint -f ingress-values.yaml ../
	helm lint -f pv-values.yaml ../
	helm lint -f ingress-values.yaml ../

deploy-basic-test:
	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name basic-test\
		-f basic-values.yaml\
		$(IMAGE_ARGS)\
		../

clean-basic-test:
	-helm delete --purge basic-test

deploy-ingress-test:
	kubectl apply \
		--namespace $(TEST_NAMESPACE)\
		-f resources/archiva-test-tls-secret.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name ingress-test\
		-f ingress-values.yaml\
		$(IMAGE_ARGS)\
		../

clean-ingress-test:
	-kubectl delete secret/archiva-test-tls-secret --namespace $(TEST_NAMESPACE)
	-helm delete --purge ingress-test

deploy-mysql-test:
	helm repo update
	helm install \
		--namespace $(TEST_NAMESPACE)\
		--set mysqlUser=archiva \
		--set mysqlPassword=archiva \
		--set mysqlDatabase=archiva \
		--name archiva-db stable/mysql

	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name mysql-test\
		-f mysql-values.yaml\
		$(IMAGE_ARGS)\
		../

clean-mysql-test:
	-helm delete --purge mysql-test
	-helm delete --purge archiva-db

deploy-pv-test:
	kubectl apply -n $(TEST_NAMESPACE)\
		-f resources/archiva-test-pv-resources.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name pv-test\
		-f pv-values.yaml\
		$(IMAGE_ARGS)\
		../

clean-pv-test:
	-helm delete --purge pv-test
	-kubectl -n $(TEST_NAMESPACE) delete pvc/archiva-pv-claim
	-kubectl delete pv/archiva-pv