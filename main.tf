terraform {
  required_version = ">=0.13"
}

locals {
  apps_json = templatefile("${path.module}/templates/application.json.tpl", {
      apps = var.applications
  })
  tenant_json = templatefile("${path.module}/templates/tenant.json.tpl", {
      application_payload = local.apps_json
  })

  as3_json = templatefile("${path.module}/templates/as3.json.tpl", {
      tenant_payload = local.tenant_json
  })
}