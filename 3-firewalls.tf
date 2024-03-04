# This will create firewalls for the default VPC . 
# If you need to create firewalls in a different vpc, do call that resouce whihc is created in the vpc resource file
resource "google_compute_firewall" "tf-allow-ports" {
  name  = "i27-ports"
  network = "default"
  dynamic "allow" {
    for_each = var.ports
    content {
      protocol = "tcp"
      ports = [allow.value]
    }
  }
  source_ranges = ["0.0.0.0/0"]
}

