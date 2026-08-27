# EKS Production Evidence Checklist

Capture screenshots after the application is validated and before cleanup.

| Evidence | Filename |
| --- | --- |
| EKS cluster showing Active | `P4-01-eks-cluster-active-console.png` |
| Healthy application Pods | `P4-02-kubectl-pods-running.png` |
| Application loaded in browser | `P4-03-frhn-application-browser.png` |
| Completed rolling update | `P4-04-rolling-update-terminal.png` |
| Two worker nodes showing Ready | `P4-05-kubectl-nodes-ready.png` |
| Deployment and LoadBalancer Service | `P4-06-kubernetes-workloads.png` |
| Readiness and liveness probes | `P4-07-health-probes.png` |
| Scaling from two to three Pods | `P4-08-replica-scaling.png` |
| Pods distributed across nodes | `P4-09-pod-node-distribution.png` |
| ECR images tagged `eks-v1` and `eks-v2` | `P4-10-ecr-image-versions.png` |
| Terraform plan summary | `P4-11-terraform-plan-summary.png` |
| Replacement Pod after manual deletion | `P4-12-pod-self-healing.png` |
| Terraform destroy complete | `P4-13-terraform-destroy-complete.png` |
| EKS cluster removed | `P4-14-eks-cluster-removed.png` |
| Load balancer removed | `P4-15-load-balancer-removed.png` |
| NAT Gateway removed | `P4-16-nat-gateway-removed.png` |
| Worker instances terminated | `P4-17-worker-instances-terminated.png` |
| Elastic IP released | `P4-18-elastic-ip-released.png` |
| No unexpected EBS volumes | `P4-19-ebs-volumes-clean.png` |
