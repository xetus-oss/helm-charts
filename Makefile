#
# A simple makefile that build releases and updates the included yaml file
#
REPO_URL := https://github.com/xetusoss/helm-charts

build-releases: lint
	helm package xetusoss-archiva
	mv xetusoss-archiva*.tgz docs
	helm repo index docs --url $(REPO_URL)

lint:
	@echo "Linting xetusoss-archiva"
	cd xetusoss-archiva/tests &&	make lint
