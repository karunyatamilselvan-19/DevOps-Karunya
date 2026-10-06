# DevOps Project

A small app taken through the full DevOps toolchain: Docker, Terraform (AWS), Ansible, Kubernetes, Jenkins, GitHub Actions.

## Structure
```
app/            Python web app (/, /health) + unit tests
docker/         Dockerfile (docker-compose.yml at root)
terraform/      modules/{vpc,ec2}, environments/{dev,prod}
ansible/        roles docker + app, playbooks/site.yml
kubernetes/     base manifests + kustomize overlays dev/prod
jenkins/        Jenkinsfile (test, build, push, deploy)
.github/        GitHub Actions CI
scripts/        build.sh, deploy.sh
```

## 1. Run locally
```
make test
make up            # http://localhost:8080  and /health
```

## 2. Push the image
```
docker login
scripts/build.sh youruser/devops-app v1
docker push youruser/devops-app:v1
```
Then replace `youruser/devops-app` in `terraform/environments/dev/terraform.tfvars`,
`kubernetes/base/deployment.yaml`, `ansible/playbooks/site.yml` and `jenkins/Jenkinsfile`.

## 3. AWS infrastructure (Terraform)
Needs AWS credentials configured (`aws configure`). This creates a VPC and an EC2 instance, which may cost money.
```
cd terraform/environments/dev
cp terraform.tfvars.example terraform.tfvars   # edit values
terraform init
terraform plan
terraform apply
terraform output app_url
terraform destroy      # when finished
```

## 4. Configure with Ansible (optional)
Add the instance IP to `ansible/inventory/hosts.ini`, then:
```
cd ansible
ansible-playbook playbooks/site.yml
```

## 5. Kubernetes
```
scripts/deploy.sh dev      # or prod
kubectl -n dev get svc devops-app
```

## 6. Jenkins
Create a Pipeline job from SCM pointing at `jenkins/Jenkinsfile`, and add a `dockerhub` credential. The agent needs docker, kubectl and kustomize.

## Upload to GitHub
```
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/<username>/<repo>.git
git push -u origin main
```
Authenticate with a Personal Access Token or SSH key. `.gitignore` already excludes state files, `.tfvars` and keys.
