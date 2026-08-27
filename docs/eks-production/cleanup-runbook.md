# EKS Production Cleanup Runbook

Use this runbook only after the live demonstration and all evidence capture are
complete. Run commands with the Production SSO profile in `us-west-2`.

## Resources retained

- S3 backend bucket `frhn-prod-app-bucket`
- ECR repository `frhn-prod-portal` and tagged application images
- Existing ACM certificate, Route 53 hosted zone, and GitHub Actions role

## 1. Remove the Kubernetes load balancer first

```powershell
kubectl delete -f .\kubernetes\frhn-portal\service.yaml
kubectl get service -n frhn-prod
```

Wait until the Service is gone. Verify that Kubernetes did not leave an Elastic
Load Balancer before destroying the VPC:

```powershell
aws elb describe-load-balancers `
  --profile AdministratorAccess-330907589313 `
  --region us-west-2 `
  --query "LoadBalancerDescriptions[?contains(DNSName, 'elb.amazonaws.com')].{Name:LoadBalancerName,DNS:DNSName}" `
  --output table
```

## 2. Remove the application workload

```powershell
kubectl delete -f .\kubernetes\frhn-portal\deployment.yaml
kubectl delete -f .\kubernetes\frhn-portal\namespace.yaml
```

## 3. Review the infrastructure destruction plan

From `environments\eks\prod\platform`:

```powershell
terraform plan -destroy -var-file="terraform.tfvars"
```

Confirm that the plan does not include the retained ECR repository or S3 state
bucket.

## 4. Destroy the temporary EKS platform

```powershell
terraform destroy -var-file="terraform.tfvars"
```

Type `yes` only after reviewing the resource list.

## 5. Verify that billable resources are gone

Check the AWS Console and CLI for:

- EKS cluster and managed node group
- EC2 worker instances and Auto Scaling group
- Classic or Network Load Balancer
- NAT Gateway and its Elastic IP
- EBS volumes
- VPC, subnets, route tables, Internet Gateway, ENIs, and security groups

Do not destroy the separate ECR Terraform root. Its repository is intentionally
retained for the next EKS project.
