
# This section will tell terraform to download the provider plugins 

provider "google" {
  //credentials = file(account.json)
  project = var.projectid
  region = "us-central1"
}