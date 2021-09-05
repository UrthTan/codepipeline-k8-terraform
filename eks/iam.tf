############## Cluster ###################

resource "aws_iam_role" "k8_cluster" {
  name               = var.cluster_name
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy_document.json
}

resource "aws_iam_policy_attachment" "node-AmazonEKSClusterPolicy" {
  name       = "node-AmazonEKSClusterPolicy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles      = [aws_iam_role.k8_cluster.name]
}

resource "aws_iam_policy_attachment" "node-AmazonEKSVPCResourceController" {
  name       = "node-AmazonEKSVPCResourceController"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  roles      = [aws_iam_role.k8_cluster.name]
}

############## Worker Node ###############

resource "aws_iam_role" "k8_node" {
  name               = var.node_name
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy_document.json
}

resource "aws_iam_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  name       = "node-AmazonEKSWorkerNodePolicy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  roles      = [aws_iam_role.k8_node.name]
}

resource "aws_iam_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  name       = "node-AmazonEKS_CNI_Policy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  roles      = [aws_iam_role.k8_node.name]
}

resource "aws_iam_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  name       = "node-AmazonEC2ContainerRegistryReadOnly"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  roles      = [aws_iam_role.k8_node.name]
}
