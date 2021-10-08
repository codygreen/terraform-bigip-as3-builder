terraform {
  required_version = ">=0.13"
}

resource random_id declaration_id {
  byte_length = 16
}

locals {

  applications_http = {for app in var.applications_http:
              app.name => {
                class   = "Application"
                service = {
                  class            = "Service_HTTP"
                  virtualAddresses = app.virtualAddresses
                  virtualPort      = app.virtualPort
                  pool             = "web_pool"
                }
                web_pool = {
                  class    = "Pool"
                  monitors = ["http"]
                  members  = [
                    for pool in app.pool_members:
                    {
                      servicePort     = pool.servicePort
                      serverAddresses = pool.serverAddresses
                    }
                  ]
                }
              }
            }
  
  applications_https = {for app in var.applications_https:
              app.name => {
                class   = "Application"
                service = {
                  class            = "Service_HTTP"
                  virtualAddresses = app.virtualAddresses
                  virtualPort      = app.virtualPort
                  pool             = "web_pool"
                }
                web_pool = {
                  class    = "Pool"
                  monitors = ["http"]
                  members  = [
                    for pool in app.pool_members:
                    {
                      servicePort     = pool.servicePort
                      serverAddresses = pool.serverAddresses
                    }
                  ]
                }
              }
            }

  virtual_servers = merge(local.applications_http,local.applications_https)

  tenant = {
    "${var.tenant_name}" = merge({class = "Tenant"},local.virtual_servers)
  }
  
  declaration_header = {
    class = "ADC"
    schemaVersion = "3.0.0"
    id = random_id.declaration_id.hex
    label = "some ole label"
    remark = "a remark"
    controls = {
      trace = true
    }  
  }
  cleanpayload = {
      "$schema" = "https://raw.githubusercontent.com/F5Networks/f5-appsvcs-extension/master/schema/latest/as3-schema.json",
      class = "AS3"
      action = "deploy"
      persist = true
      declaration = merge(
        local.declaration_header, 
        local.tenant
      )
  }


}

output "as3" {
  value = local.cleanpayload
}

# for debug purposes 
resource "local_file" "as3" {
    content     = jsonencode(local.cleanpayload)
    filename = "${path.module}/as3.json"
}