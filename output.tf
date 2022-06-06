output "region" {
  description = "AWS region"
  value = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value = var.cluster_name
}

output "endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}