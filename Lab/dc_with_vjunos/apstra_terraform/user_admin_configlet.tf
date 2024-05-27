resource "apstra_configlet" "user_admin" {
  name = "user_admin"
  generators = [
    {
      config_style  = "junos"
      section       = "top_level_hierarchical"
      template_text = <<-EOT
				system {
				    root-authentication {
				        encrypted-password "$1$Jw5Ubokd$OLC5bOaYt.cI5fg0vz6F4."; ## SECRET-DATA
				    }
				    login {
				        user admin {
				            class super-user;
				            authentication {
				                encrypted-password "$1$Jw5Ubokd$OLC5bOaYt.cI5fg0vz6F4."; ## SECRET-DATA
				                ssh-rsa "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBUA+4YJwqE2rqwweZ3NG7GpXF3JqIxFbnDxraW8//QWjHLGVgn+jFbXFB3T/yLYpIRAh8SsAw6M6pZXzGd3oiltENLkoN5YGI1yW0bCTsS/Z4BoW/iuPR2rYQqhA+NPi9OZO/opVbJ+VIdfm+fugWPSVpduBiJN20P9iEF1zCW4EmWZn3qkl25LjVSBVMiwn+crcsCHUub3xDRicgTOOINFo4lZy03Fsa3PoqpxXv18FhNi3pVWmV2n3vIckWt8BbaPWMTFZmERHkVb4Y15GsHwcQxb6gm3h8Do4QgURbujCUJQhpJT4BRdD8kja1NQK4lbcPq6l9rF3YM7aQkscB16nCplWcgdnxI7eN//FA4ovvx7d57i43Y7GzSlQE87kcIDDQ1eCesYOfg9EfqCFSVWV0hbhc2Ap6YCoc0R9POpG1n0LO+o++h0J0bkLUWsIiQLb3LiC91FnP3giK5MEzdJ+maJcjIyGlTth52s01nLdT4gQDgTURqIpfL8L0HWE= irzan@irzan-mbp"; ## SECRET-DATA
				            }
				        }
				    }
				}
      EOT
    }
  ]
}

