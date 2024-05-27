resource "apstra_logical_device" "ald1" {
  name = "AOS-10x1"
  panels = [
    {
      rows = 1
      columns = 10
      port_groups = [
        {
          port_count = 10
          port_speed = "1G"
          port_roles = ["superspine", "spine", "leaf", "peer", "access", "generic","unused"]
        },
      ]
    }
  ]
}
