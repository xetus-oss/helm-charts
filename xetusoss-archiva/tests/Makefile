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
	helm lint -f casecret-values.yaml ../
	helm lint -f old-advanced-jvmExtraOpts-values.yaml ../
	helm lint -f archiva-jvmExtraOpts-values.yaml ../

test-old-advanced-jvmExtraOpts-values:
	helm install ../ \
		--name=ignore \
		--namespace=$(TEST_NAMESPACE) \
		--dry-run \
		--debug \
		-f old-advanced-jvmExtraOpts-values.yaml | \
		grep 'JVM_EXTRA_OPT_FROM_ADVANCED_KEY' > /dev/null

test-archiva-jvmExtraOpts-values:
	helm install ../ \
		--name=ignore \
		--namespace=$(TEST_NAMESPACE) \
		--dry-run \
		--debug \
		-f archiva-jvmExtraOpts-values.yaml | \
		grep 'JVM_EXTRA_OPT_FROM_ARCHIVA_KEY' > /dev/null

deploy-basic-test:
	kubectl create namespace $(TEST_NAMESPACE)
	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name basic-test\
		-f basic-values.yaml\
		$(IMAGE_ARGS)\
		../

clean-basic-test:
	-helm delete --purge basic-test
	-kubectl delete namespace $(TEST_NAMESPACE)

deploy-ingress-test:
	kubectl create namespace $(TEST_NAMESPACE)
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
	-kubectl delete namespace $(TEST_NAMESPACE)

deploy-mysql-test:
	kubectl create namespace $(TEST_NAMESPACE)
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
	-kubectl delete namespace $(TEST_NAMESPACE)

deploy-existing-pvc-test:
	kubectl create namespace $(TEST_NAMESPACE)

	kubectl apply -n $(TEST_NAMESPACE)\
		-f resources/archiva-test-pv-resources.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name existing-pvc-test\
		-f existing-pvc-values.yaml\
		$(IMAGE_ARGS)\
		../

clean-existing-pvc-test:
	-helm delete --purge existing-pvc-test
	-kubectl -n $(TEST_NAMESPACE) delete pvc/archiva-pv-claim
	-kubectl delete pv/archiva-pv
	-kubectl delete namespace $(TEST_NAMESPACE)

deploy-provisoner-pv-test:
	kubectl create namespace $(TEST_NAMESPACE)

	kubectl apply -n $(TEST_NAMESPACE)\
		-f resources/archiva-test-pv-resources.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name provisoner-pv-test\
		-f provisoner-pv-values.yaml\
		$(IMAGE_ARGS)\
		../

clean-provisoner-pv-test:
	-helm delete --purge provisoner-pv-test
	-kubectl delete namespace $(TEST_NAMESPACE)

deploy-casecret-test:
	kubectl create namespace $(TEST_NAMESPACE)
	kubectl apply -n $(TEST_NAMESPACE)\
		-f resources/archiva-test-ca-secret.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name casecret-test\
		-f casecret-values.yaml\
		$(IMAGE_ARGS)\
		../

clean-casecret-test:
	-helm delete --purge casecret-test
	-kubectl delete --namespace $(TEST_NAMESPACE)\
		secrets/archiva-test-cacerts
	-kubectl delete namespace $(TEST_NAMESPACE)
