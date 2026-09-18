
terraform {
  backend "s3" {
    bucket       = "nextjs-portfolio-richard-2026"
    key          = "portfolio/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}