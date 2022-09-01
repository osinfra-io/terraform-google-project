terraform {
  backend "gcs" {
    bucket = "terraform-child-modules-github-actions-state"
  }
}
