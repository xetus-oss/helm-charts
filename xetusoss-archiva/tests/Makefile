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
	helm lint -f caconfigmap-values.yaml ../

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

deploy-pv-test:
	kubectl create namespace $(TEST_NAMESPACE)

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
	-kubectl delete namespace $(TEST_NAMESPACE)

deploy-caconfigmap-test:
	kubectl create namespace $(TEST_NAMESPACE)
	kubectl apply -n $(TEST_NAMESPACE)\
		-f resources/archiva-test-ca-configmap.yaml

	helm install \
		--namespace $(TEST_NAMESPACE)\
		--name caconfigmap-test\
		-f caconfigmap-values.yaml\
		$(IMAGE_ARGS)\
		../

clean-caconfigmap-test:
	-helm delete --purge caconfigmap-test
	-kubectl delete --namespace $(TEST_NAMESPACE)\
		configmaps/archiva-test-cacerts
	-kubectl delete namespace $(TEST_NAMESPACE)
