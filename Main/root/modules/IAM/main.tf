module "azure_iam" {
    source = "./azure_iam"
    azure_ad_group_name = var.azure_ad_group_name
    azure_role_name     = var.azure_role_name
    azure_scope         = var.azure_scope
}


module "aws_iam" {
    source = "./aws_iam"
    aws_iam_group_name = var.aws_iam_group_name
    aws_iam_policy     = var.aws_iam_policy
}