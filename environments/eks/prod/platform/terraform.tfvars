aws_region         = "us-west-2"
project_name       = "FRHN-Portal"
environment        = "prod"
cluster_name       = "frhn-prod-eks"
kubernetes_version = "1.35"
vpc_cidr           = "10.4.0.0/16"
notification_email = "elelev@gmail.com"

public_subnets = {
  a = {
    cidr = "10.4.1.0/24"
    az   = "us-west-2a"
  }
  b = {
    cidr = "10.4.2.0/24"
    az   = "us-west-2b"
  }
}

private_subnets = {
  a = {
    cidr = "10.4.11.0/24"
    az   = "us-west-2a"
  }
  b = {
    cidr = "10.4.12.0/24"
    az   = "us-west-2b"
  }
}

node_instance_types = ["t3.medium"]
node_desired_size   = 2
node_min_size       = 2
node_max_size       = 3

tags = {
  OwnerTeam   = "FRHN-CloudEngineers"
  Application = "FRHN-Portal"
  Workload    = "Web-Portal"
}
