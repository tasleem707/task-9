provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_container_cluster" "primary" {
  name                     = "github-gke-cluster"
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 30          # Reduce from default 100 or higher
    disk_type    = "pd-standard" # Use standard HDD
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

