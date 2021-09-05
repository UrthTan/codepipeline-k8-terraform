############## Cluster ###################

resource "aws_security_group" "eks_cluster_security_group" {
  name        = var.cluster_name
  description = "eks cluster for worker nodes"
  vpc_id      = aws_vpc.my_vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_security_group_rule" "eks_cluster_ingress_workstation_https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with cluster API server"
  security_group_id = aws_security_group.eks_cluster_security_group.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
}

resource "aws_eks_cluster" "my_eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.k8_cluster.arn
  vpc_config {
    security_group_ids = [aws_security_group.eks_cluster_security_group.id]
    subnet_ids         = aws_subnet.my_vpc_subnets[*].id
  }
  depends_on = [
    aws_iam_policy_attachment.node-AmazonEKSClusterPolicy,
    aws_iam_policy_attachment.node-AmazonEKSVPCResourceController
  ]
}
############## Worker Node ###############

resource "aws_eks_node_group" "name" {
  cluster_name        = aws_eks_cluster.my_eks_cluster.name
  node_group_name     = var.node_name
  node_role_arn       = aws_iam_role.k8_node.arn
  subnet_ids          = aws_subnet.my_vpc_subnets[*].id
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  depends_on = [
    aws_iam_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly
  ]
}