provider "openstack" {
  auth_url = "https://auth.cloud.ovh.net/v3"
  alias = "ovh"
}
# If you store credentials here I swear I will find you and destroy you

provider "cloudflare" {
  version = "~> 2.0"
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}