module "iam_user1" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "litecoin-user"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "iam_group_with_assumable_roles_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"
  version = "~> 4.3"

  name = "production-readonly"

  assumable_roles = [
    "arn:aws:iam::835367859855:role/readonly"
  ]

  group_users = [
    "litecoin-user",
  ]
}

module "iam_assumable_roles" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"
  version = "~> 4.3"

  trusted_role_arns = [
    "arn:aws:iam::684773845799:user/litecoin-user",
  ]

  create_readonly_role       = true
  readonly_role_requires_mfa = false
}