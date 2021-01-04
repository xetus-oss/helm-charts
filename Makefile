#
# A simple makefile that build releases and updates the included yaml file
#
REPO_URL := https://xetus-oss.github.com/helm-charts

build-releases: lint
	@echo "Packaging xetusoss-archiva"
	helm package xetusoss-archiva
	mv xetusoss-archiva*.tgz docs

	@echo "Packaging alertmanager-logging-receiver"
	helm package alertmanager-logging-receiver
	mv alertmanager-logging-receiver*.tgz docs

	@echo "Rebuilding chart repo index"
	helm repo index docs --url $(REPO_URL)

lint:
	@echo "** Linting xetusoss-archiva **\n"
	cd xetusoss-archiva/tests && make lint

	@echo "\n\n** Linting alertmanager-logging-receiver **\n"
	cd alertmanager-logging-receiver/tests && make lint
