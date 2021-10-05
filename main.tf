terraform {
  required_version = ">=0.13"
}



locals {
  tenant = merge({class = "Tenant"},{for app in var.applications:
              app.name => {
                class = "Application"
                service = {
                  class = "Service_HTTP"
                  virtualAddresses = app.virtualAddresses
                  virtualPort = app.virtualPort
                  pool = "web_pool"
                }
                web_pool = {
                  class = "Pool"
                  monitors = ["http"]
                  members = [
                    for pool in app.pool_members:
                    {
                      servicePort = pool.servicePort
                      serverAddresses = pool.serverAddresses
                    }
                  ]
                }
              }
            })

  payload = jsonencode({
      "$schema" = "https://raw.githubusercontent.com/F5Networks/f5-appsvcs-extension/master/schema/latest/as3-schema.json",
      class = "AS3"
      action = "deploy"
      persist = true
      declaration = {
        class = "ADC"
        schemaVersion = "3.0.0"
        id = "1234556"
        label = "some ole label"
        remark = "a remark"
        controls = {
          trace = true
        }
        "${var.tenant_name}" = local.tenant
      }
  })

  cleanpayload = {
      "$schema" = "https://raw.githubusercontent.com/F5Networks/f5-appsvcs-extension/master/schema/latest/as3-schema.json",
      class = "AS3"
      action = "deploy"
      persist = true
      declaration = {
        class = "ADC"
        schemaVersion = "3.0.0"
        id = "1234556"
        label = "some ole label"
        remark = "a remark"
        controls = {
          trace = true
        }
        "${var.tenant_name}" = merge({class = "Tenant"},{for app in var.applications:
              app.name => {
                class = "Application"
                service = {
                  class = "Service_HTTP"
                  virtualAddresses = app.virtualAddresses
                  virtualPort = app.virtualPort
                  pool = "web_pool"
                }
                web_pool = {
                  class = "Pool"
                  monitors = ["http"]
                  members = [
                    for pool in app.pool_members:
                    {
                      servicePort = pool.servicePort
                      serverAddresses = pool.serverAddresses
                    }
                  ]
                }
              }
            })
      }
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