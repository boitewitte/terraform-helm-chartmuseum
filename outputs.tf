output "helm_release" {
  value = helm_release.chartmuseum
}

output "validate_set" {
  value = local.set
}

output "validate_set_string" {
  value = local.set_string
}

output "validate_set_sensitive" {
  value = local.set_sensitive
}
