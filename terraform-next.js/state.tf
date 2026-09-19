terraform {
  backend "s3" {
    bucket         = "rr-my-tf-website-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2"

    use_lockfile   = true
  }
}

