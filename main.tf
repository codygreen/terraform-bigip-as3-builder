terraform {
  required_version = ">=0.13"
}

# for debug purposes 
resource "local_file" "as3" {
    content     = local.as3_json
    filename = "${path.module}/as3.json"
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
