test:
	cd app && python3 -m unittest -v

run:
	python3 app/app.py

build:
	docker build -t devops-app -f docker/Dockerfile .

up:
	docker compose up --build

tf-init:
	cd terraform/environments/dev && terraform init

tf-plan:
	cd terraform/environments/dev && terraform plan

tf-apply:
	cd terraform/environments/dev && terraform apply

k8s-dev:
	scripts/deploy.sh dev
