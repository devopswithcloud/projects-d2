## Creating Terraform Manifest files for our Project Implementation.
* Create a Manifest file of terraform
    * `providers.tf`:
    ```bash
    * terraform version
    * WHo is the provider , provider version
    ```
    * `main.tf`: 
    ```bash
    # Resources Needs to be created in GCP
    * VPC
    * Subnets
    * Instance : jenkins-master, jenkins-slave, ansible-controller, sonar, nexus , GKE Cluster
    ```
    * `variables.tf`
    ```bash
    * All data, that is been passed dynamocally. 
    ```
    * `terraform.tfvars`
    ```bash
    * customer specific data will be passed here.
    ```
    * `output.tf`
    ```bash
    # below is the sample one

    #public-ips
    jenkins-master > 34.x.x.x
    variable > public ip


    # private-ips
    jenkins-master > 10.x.x.x
    ```