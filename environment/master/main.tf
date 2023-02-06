terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  project = var.project
  region  = var.region
}

resource "google_sql_database" "database" {
  name     = "my-database_test"
  instance = google_sql_database_instance.instance.name
  data base_script {
    statement = data.template_file.sql_file.rendered 
  }
    
}


resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance_test"
  region           = "us-west1"
  database_version = "POSTGRES_14"
  settings {
    tier = "db-f1-micro"
  }

}

data "template_file" "sql_file" {
   template = "${file("D:\\GCP_Terraform_Testing\\table.sql")}"
}

resource "google_sql_user" "users" {
  name     = "root_test"
  password = "root_test"
  instance = google_sql_database_instance.instance.name
}
