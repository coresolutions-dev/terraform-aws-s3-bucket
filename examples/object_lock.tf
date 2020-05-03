module "object_lock_example" {
  source      = "../"

  object_lock_configuration  = {
    object_lock_enabled = true
    default_mode        = "COMPLIANCE"
    default_days        = 30
  }
}
