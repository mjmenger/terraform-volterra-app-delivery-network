terraform {
  required_version = ">= 0.13.1"

  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.4.0"
    }
    local = ">= 2.0"
    null  = ">= 3.0"
  }
}
