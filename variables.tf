variable "region" {
  default = "us-east-1"
}
variable "cluster_name" {
  default = "codepipeline-k8-terraform-cluster"
  type    = string
}

variable "node_name" {
  default = "codepipeline-k8-terraform-node"
  type    = string
}