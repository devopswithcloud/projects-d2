# Define the variables that are been called by the GCE 

variable "geczone" {
  default = "us-central1-c"
}

variable "projectid" {
  default = "nice-carving-411801"
}
variable "instances" {
  default = {
    "jenkins-master" = "e2-medium"
    "jenkins-slave" = "e2-medium"
    "ansible" = "e2-medium"
    "sonar" = "e2-medium"
    }
}

variable "ports" {
  default = [80, 8080, 8081, 9000]
}