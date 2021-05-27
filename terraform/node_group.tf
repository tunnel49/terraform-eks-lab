resource "aws_eks_node_group" "eks_nodegroup1" {
  cluster_name    = aws_eks_cluster.eks_cluster1.name
  node_group_name = "eks_cluster_nodes"
  node_role_arn   = aws_iam_role.eks_node_group_role1.arn
  subnet_ids      = aws_subnet.eks_subnet1[*].id

  scaling_config {
    desired_size = 1
    max_size = 1
    min_size = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_role1-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_node_group_role1-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_node_group_role1-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "eks_node_group_role1" {
  name = "eks-node-group-role1"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_group_role1-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role1.name
}

resource "aws_iam_role_policy_attachment" "eks_node_group_role1-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role1.name
}

resource "aws_iam_role_policy_attachment" "eks_node_group_role1-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role1.name
}

