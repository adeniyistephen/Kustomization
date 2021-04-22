SHELL := /bin/bash

#==============================================
#build docker
shipa:
	docker build \
		-f dockerfile \
		-t shipa:1.0 \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` \
		.
# ==============================================================
# Running from within k8s/dev

kind-up:
	kind create cluster --image kindest/node:v1.20.2 --name shipa-cluster --config kind-config.yaml

kind-down:
	kind delete cluster --name shipa-cluster

kind-load:
	kind load docker-image shipa:1.0 --name shipa-cluster

kind-shipa:
	kustomize build . | kubectl apply -f -

kind-status:
	kubectl get nodes
	kubectl get pods --watch	

kind-logs:
	kubectl logs -lapp=shipa --all-containers=true -f --tail=100

kind-status-full:
	kubectl describe pod -lapp=shipa

kind-namespace:
	kubectl create -f ./my-namespace.yaml	