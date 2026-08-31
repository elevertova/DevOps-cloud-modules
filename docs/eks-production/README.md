# Amazon EKS Production Deployment

This folder documents deployment of the FRHN portal to Amazon EKS. Terraform
creates the AWS infrastructure; Kubernetes manifests manage the application.

## Repository layout

- `environments/eks/prod/ecr`: reusable ECR repository with separate state
- `environments/eks/prod/platform`: temporary VPC, EKS cluster, and node group
- `modules/eks-platform`: reusable EKS control plane and managed-node resources
- `kubernetes/frhn-portal`: Namespace, Deployment, and LoadBalancer Service
- `application/frhn-portal`: versioned Nginx application image

## Demonstrations

The deployment supports:

- two healthy replicas
- readiness and liveness probes
- manual scaling
- Pod self-healing
- rolling image update from `eks-v1` to `eks-v2`
- browser access through a Kubernetes LoadBalancer Service

The observability extension adds CloudWatch Container Insights, a dashboard for Pod metrics, a Pod-health alarm with SNS email notification, and CloudTrail evidence of EKS API activity.

After validation and evidence capture, follow `cleanup-runbook.md` to remove temporary billable resources.