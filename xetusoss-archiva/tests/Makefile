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
	helm lint -f provisoner-pv-values.yaml ../
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
		-f basic-values.yaml\
		$(IMAGE_ARGS)\
		basic-test\
		../

clean-basic-test:
	-helm uninstall --namespace=$(TEST_NAMESPACE) basic-test
	-kubectl delete namespace $(TEST_NAMESPACE)

test-ingress-values:
	helm install \
		--namespace $(TEST_NAMESPACE)\
		--dry-run \
		--debug \
		-f ingress-values.yaml\
		$(IMAGE_ARGS)\
		ingress-test\
		../

deploy-ingress-test:
	kubectl create namespace $(TEST_NAMESPACE)
	kubectl apply \
		--namespace $(TEST_NAMESPACE)\
		-f resources/archiva-test-tls-secret.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		-f ingress-values.yaml\
		$(IMAGE_ARGS)\
		ingress-test\
		../

clean-ingress-test:
	-kubectl delete secret/archiva-test-tls-secret --namespace $(TEST_NAMESPACE)
	-helm uninstall --namespace $(TEST_NAMESPACE) ingress-test
	-kubectl delete namespace $(TEST_NAMESPACE)


deploy-mysql-test:
	kubectl create namespace $(TEST_NAMESPACE)
	helm repo update
	helm install \
		--namespace $(TEST_NAMESPACE)\
		--set auth.username=archiva \
		--set auth.password=archiva \
		--set auth.database=archiva \
		archiva-db bitnami/mysql

	helm install \
		--namespace $(TEST_NAMESPACE)\
		-f mysql-values.yaml\
		$(IMAGE_ARGS)\
		mysql-test\
		../

clean-mysql-test:
	-helm uninstall --namespace $(TEST_NAMESPACE) mysql-test
	-helm uninstall --namespace $(TEST_NAMESPACE) archiva-db
	-kubectl delete namespace $(TEST_NAMESPACE)

deploy-existing-pvc-test:
	kubectl create namespace $(TEST_NAMESPACE)

	kubectl apply -n $(TEST_NAMESPACE)\
		-f resources/archiva-test-pv-resources.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		-f existing-pvc-values.yaml\
		$(IMAGE_ARGS)\
		existing-pvc-test\
		../

clean-existing-pvc-test:
	-helm uninstall --namespace $(TEST_NAMESPACE) existing-pvc-test
	-kubectl -n $(TEST_NAMESPACE) delete pvc/archiva-pv-claim
	-kubectl delete pv/archiva-pv
	-kubectl delete namespace $(TEST_NAMESPACE)

deploy-provisoner-pv-test:
	kubectl create namespace $(TEST_NAMESPACE)

	kubectl apply -n $(TEST_NAMESPACE)\
		-f resources/archiva-test-pv-resources.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		-f provisoner-pv-values.yaml\
		$(IMAGE_ARGS)\
		provisoner-pv-test\
		../

clean-provisoner-pv-test:
	-helm uninstall --namespace $(TEST_NAMESPACE) provisoner-pv-test
	-kubectl delete namespace $(TEST_NAMESPACE)

deploy-casecret-test:
	kubectl create namespace $(TEST_NAMESPACE)
	kubectl apply -n $(TEST_NAMESPACE)\
		-f resources/archiva-test-ca-secret.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		-f casecret-values.yaml\
		$(IMAGE_ARGS)\
		casecret-test\
		../

clean-casecret-test:
	-helm uninstall --namespace $(TEST_NAMESPACE) casecret-test
	-kubectl delete --namespace $(TEST_NAMESPACE)\
		secrets/archiva-test-cacerts
	-kubectl delete namespace $(TEST_NAMESPACE)


deploy-priorityclass-test:
	kubectl create namespace $(TEST_NAMESPACE)
	kubectl apply \
		-f resources/archiva-test-priority-class.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		-f priorityclass-values.yaml\
		$(IMAGE_ARGS)\
		priorityclass-test\
		../

clean-priorityclass-test:
	-helm uninstall --namespace $(TEST_NAMESPACE) priorityclass-test
	-kubectl delete\
		-f resources/archiva-test-priority-class.yaml
	-kubectl delete namespace $(TEST_NAMESPACE)

