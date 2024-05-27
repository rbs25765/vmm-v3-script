terraform {
   required_providers {
     apstra = {
       source = "Juniper/apstra"
     }
   }
}
provider "apstra" {
    url = "https://127.0.0.1:9191"
    tls_validation_disabled = true
    blueprint_mutex_enabled = false
    experimental = true
}

