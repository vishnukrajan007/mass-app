output "cluster_id" {
  value = aws_eks_cluster.massapp.id
}

output "node_group_id" {
  value = aws_eks_node_group.massapp.id
}

output "vpc_id" {
  value = aws_vpc.massapp_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.massapp_subnet[*].id
}

