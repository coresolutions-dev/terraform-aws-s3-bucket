module "website_example" {
    source      = "../"
    website_index_document = "index.html"
    website_error_document = "error.html"
}