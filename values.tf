locals {
  values_default = yamlencode({
    "pyroscope" : {
      "serviceAccount" : {
        "create" : var.service_account_create
        "annotations" : {
          "eks.amazonaws.com/role-arn" : local.irsa_role_create ? aws_iam_role.this[0].arn : ""
        }
      }
    }
  })
}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    local.values_default,
    var.values
  ])
}
