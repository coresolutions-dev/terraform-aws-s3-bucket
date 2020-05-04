## Examples

Full examples can be found in the corresponding TF files

### Basic:
```sh
module "basic" {
    source = "../"
}
```

### Replication:
```sh
module "replication_example" {
  source     = "../"
  versioning = true

  replication_rules = [{
    status = "Enabled"

    destination = {
      bucket        = module.destination_bucket.bucket_arn
      storage_class = "STANDARD"
    }
  }
}

module "destination_bucket" {
  source     = "../"
  versioning = true
}
```

### Lifecycle Rules:
```sh
module "lifecycle_rules_example" {
  source      = "../"

  lifecycle_rules = [{
    enabled = true

    transitions = [{
      days          = 30
      storage_class = "STANDARD_IA"
    },
    {
      days          = 60
      storage_class = "GLACIER"
    }]
  }]
}
```

### Object Locking:
```sh
module "object_lock_example" {
  source      = "../"

  object_lock_configuration  = {
    object_lock_enabled = true
  }
}
```

### Website Configuration:
```sh
module "website_example" {
    source      = "../"
    website_index_document = "index.html"
    website_error_document = "error.html"
}
```

### CORS Rules:
```sh
module "cors_rules_example" {
  source      = "../"

  cors_rules = [{
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://example1.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  },
  {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["https://example2.com"]
  }]
}
```

### Custom KMS Key:
```sh
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
}

module "custom_kms_key_example" {
    source      = "../"
    bucket_name = "custom-kms-bucket"
    encryption  = true
    kms_key     = aws_kms_key.mykey.arn
}
```