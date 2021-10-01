# terraform-bigip-as3-builder
Example module to compile an AS3 declaration per tenants and applications

# Demo
Tenant data is stored in the data directory.  To build an AS3 declaration for a specific tenant run the following command:

```bash
terraform plan -var-file ./data/tenant2/terraform.tfvars
```