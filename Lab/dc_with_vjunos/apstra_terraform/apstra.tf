terraform {
   required_providers {
     apstra = {
       source = "Juniper/apstra"
     }
   }
}
provider "apstra" {
    url = "https://172.16.10.2"
    tls_validation_disabled = true
    blueprint_mutex_enabled = false
    experimental = true
}

