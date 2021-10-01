variable "tenant_name" {
    description = "AS3 tenant name"
    type = string
}
variable "applications" {
    description = "List of application objects"
    type = list(object({
        name = string
        virtualAddresses = list(string)
        virtualPort = number
        pool_members = list(object({
            serverAddresses = list(string)
            servicePort = number
        }))
    }))
}