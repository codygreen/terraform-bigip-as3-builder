variable "tenant_name" {
    description = "AS3 tenant name"
    type = string
}
variable "applications_http" {
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
    default = []
}

variable "applications_https" {
    description = "List of HTTPS application objects"
    type = list
    default = []
}