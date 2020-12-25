#Cloudflare - needs to be removed before final release
variable "cloudflare_email" {
  type = string
  description = "Cloudflare email address"
}
variable "cloudflare_api_key" {
  type = string
  description = "Cloudlfare API key"
}
variable "domain" {
  type = string
  description = "What it looks like"
}
variable "zone_id" {
  type = string
  description = "The ZONEID that the record will live under"
}

#---



