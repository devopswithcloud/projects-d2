# If you want 

# This Section will create the compute engine instances which are needed for i27 infrastructure. 

# Google Compute Engine 

resource "google_compute_instance" "tf-vm-instances" {
  for_each = var.instances
  name = each.key       #jenkins-master         jenkins-slave       sonar       nexus   
  zone = var.geczone
  machine_type = each.value
  tags = [each.key]  # this can be used , if we want to implement instance level firewalls
  boot_disk {
    initialize_params {
        image  = data.google_compute_image.ubuntu_image.self_link
        #image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240229"
        size = 10
        type  = "pd-balanced"

    }
  }
  network_interface {
    network = "default"
    access_config {
      network_tier = "PREMIUM"
    }
  }
  connection {
    type = "ssh"
    user = "i27k8s10" # Virtual Machine User not the cloud user
    host = self.network_interface[0].access_config[0].nat_ip
    # ssh-keygen -t rsa -f ~/03032024/ssh-key -C i27k8s10
    private_key = file("ssh-key") # Private key
    # Once we generate the public and private key using the above, make sure you copy the public key into GCP
    # Go to GCE > Metadata(project) > ssh-keys > edit > paste the public key 
    # this will make sure, all the instances under the project will be having the pbulic key
    # now, using the private key i can connect to all vm;s under the project 
  }

  provisioner "file" {
    # if ansible machine then execute ansible.sh
    # if not ansible machine then execute empty.sh
    # condition ? Success : Failure 
    source = each.key == "ansible" ? "ansible.sh" : "empty.sh"
    destination = each.key == "ansible" ? "/home/i27k8s10/ansible.sh" : "/home/i27k8s10/empty.sh"
    # this destination is on Google VM 
  }

  # In ansible machine, ansible.sh script should execute. 
  provisioner "remote-exec" {
    inline = [ 
        each.key == "ansible" ? "chmod +x /home/i27k8s10/ansible.sh && sh /home/i27k8s10/ansible.sh" : "echo 'Skipped the Command'"
     ]
  }
  
  # Inorder to communicate to other vms from the ansible controller, i need to have an authentication mechanism 
  # These vms do not have passwords for username (i27k8s10).
  # For that reasom we have already created ssk-key .
  # Now making sure, that key is availble on all the nodes/ansible contrller, so my connetivity has no issues
  provisioner "file" {
    source = "ssh-key"
    destination = "/home/i27k8s10/ssh-key"
  }

}

# Implement data sources , 
data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}
