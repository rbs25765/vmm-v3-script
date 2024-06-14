resource "apstra_asn_pool" "ASN_DC1_Spine" {
  name = "ASN_DC1_Spine"
  ranges = [
    {
      first = 4200001001
      last = 4200001010
    }
  ]
}
resource "apstra_asn_pool" "ASN_DC1_Leaf" {
  name = "ASN_DC1_Leaf"
  ranges = [
    {
      first = 4200001101
      last = 4200001110
    }
  ]
}
resource "apstra_asn_pool" "ASN_DC2" {
  name = "ASN_DC2"
  ranges = [
    {
      first = 4200002001
      last = 4200002010
    }
  ]
}

resource "apstra_asn_pool" "ASN_DC3_Spine" {
  name = "ASN_DC3_Spine"
  ranges = [
    {
      first = 4200003001
      last = 4200003010
    }
  ]
}
resource "apstra_asn_pool" "ASN_DC3_Leaf" {
  name = "ASN_DC3_Leaf"
  ranges = [
    {
      first = 4200003101
      last = 4200003110
    }
  ]
}
resource "apstra_ipv4_pool" "DC1_fabric_link" {
  name = "DC1_fabric_link"
  subnets = [
    { network = "10.1.0.0/24" }
  ]
}
resource "apstra_ipv4_pool" "DC1_Spine_loopback" {
  name = "DC1_Spine_loopback"
  subnets = [
    { network = "10.1.1.0/24" }
  ]
}
resource "apstra_ipv4_pool" "DC1_Leaf_loopback" {
  name = "DC1_Leaf_loopback"
  subnets = [
    { network = "10.1.2.0/24" }
  ]
}
resource "apstra_ipv4_pool" "DC1_VRF_loopback" {
  name = "DC1_VRF_loopback"
  subnets = [
    { network = "10.1.3.0/24" }
  ]
}
resource "apstra_ipv4_pool" "DC2_fabric_link" {
  name = "DC2_fabric_link"
  subnets = [
    { network = "10.2.0.0/24" }
  ]
}
resource "apstra_ipv4_pool" "DC2_Leaf_loopback" {
  name = "DC2_Leaf_loopback"
  subnets = [
    { network = "10.2.2.0/24" }
  ]
}
resource "apstra_ipv4_pool" "DC2_VRF_loopback" {
  name = "DC2_VRF_loopback"
  subnets = [
    { network = "10.2.3.0/24" }
  ]
}

resource "apstra_ipv4_pool" "DC3_fabric_link" {
  name = "DC3_fabric_link"
  subnets = [
    { network = "10.3.0.0/24" }
  ]
}
resource "apstra_ipv4_pool" "DC3_Spine_loopback" {
  name = "DC3_Spine_loopback"
  subnets = [
    { network = "10.3.1.0/24" }
  ]
}
resource "apstra_ipv4_pool" "DC3_Leaf_loopback" {
  name = "DC3_Leaf_loopback"
  subnets = [
    { network = "10.3.2.0/24" }
  ]
}
resource "apstra_ipv4_pool" "DC3_VRF_loopback" {
  name = "DC3_VRF_loopback"
  subnets = [
    { network = "10.3.3.0/24" }
  ]
}

resource "apstra_ipv6_pool" "DC1_fabric_link" {
  name = "DC1_fabric_link"
  subnets = [
    { network = "fc00:dead:beef:1000::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC1_Spine_loopback" {
  name = "DC1_Spine_loopback"
  subnets = [
    { network = "fc00:dead:beef:1001::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC1_Leaf_loopback" {
  name = "DC1_Leaf_loopback"
  subnets = [
    { network = "fc00:dead:beef:1002::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC1_VRF_loopback" {
  name = "DC1_VRF_loopback"
  subnets = [
    { network = "fc00:dead:beef:1003::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC2_fabric_link" {
  name = "DC2_fabric_link"
  subnets = [
    { network = "fc00:dead:beef:2000::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC2_Leaf_loopback" {
  name = "DC2_Leaf_loopback"
  subnets = [
    { network = "fc00:dead:beef:2002::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC2_VRF_loopback" {
  name = "DC2_VRF_loopback"
  subnets = [
    { network = "fc00:dead:beef:2003::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC3_fabric_link" {
  name = "DC3_fabric_link"
  subnets = [
    { network = "fc00:dead:beef:3000::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC3_Spine_loopback" {
  name = "DC3_Spine_loopback"
  subnets = [
    { network = "fc00:dead:beef:3001::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC3_Leaf_loopback" {
  name = "DC3_Leaf_loopback"
  subnets = [
    { network = "fc00:dead:beef:3002::/64" }
  ]
}
resource "apstra_ipv6_pool" "DC3_VRF_loopback" {
  name = "DC3_VRF_loopback"
  subnets = [
    { network = "fc00:dead:beef:3003::/64" }
  ]
}