data "aws_canonical_user_id" "current_user" {}

module "grants_example" {
  source      = "../"

  grants = [{
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  },
  {
    type        = "Group"
    permissions = ["READ", "WRITE"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }]
}
