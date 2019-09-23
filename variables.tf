variable "name" {
  type        = string
  description = "Release Name"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
  default     = "default"
}

variable "image_pull_policy" {
  type        = string
  description = "Container Pull Policy"
  default     = "IfNotPresent"
}

variable "image_repository" {
  type        = string
  description = "Container image to use"
  default     = "chartmuseum/chartmuseum"
}

variable "image_tag" {
  type        = string
  description = "Container Image tag to deploy"
  default     = "v0.8.8"
}

variable "persistence_access_mode" {
  type        = string
  description = "Access mode to use for PVC"
  default     = "ReadWriteOnce"
}

variable "persistence_enabled" {
  type        = bool
  description = "Whether to use a PVC for persistent storage"
  default     = false
}

variable "persistence_size" {
  type        = string
  description = "Amount of space to claim for PVC"
  default     = "8Gi"
}

variable "persistence_labels" {
  type        = map
  description = "Additional labels for PVC"
  default     = {}
}

variable "persistence_storage_class" {
  type        = string
  description = "Storage Class to use for PVC"
  default     = null
}

variable "persistence_volume_name" {
  type        = string
  description = "Volume to use for PVC"
  default     = null
}

variable "persistence_pv_enabled" {
  type        = bool
  description = "Whether to use a PV for persistent storage"
  default     = false
}

variable "persistence_pv_capacity_storage" {
  type        = string
  description = "Storage size to use for PV"
  default     = "8Gi"
}

variable "persistence_pv_access_mode" {
  type        = string
  description = "Access mode to use for PV"
  default     = "ReadWriteOnce"
}

variable "persistence_pv_nfs_server" {
  type        = string
  description = "NFS server for PV"
  default     = ""
}

variable "persistence_pv_nfs_path" {
  type        = string
  description = "Storage Path"
  default     = ""
}

variable "persistence_pv_pvname" {
  type        = string
  description = "Custom name for private volume"
  default     = ""
}

variable "replica_count" {
  type        = number
  description = "K8s replicas"
  default     = 1
}

variable "resources_limits_cpu" {
  type        = string
  description = "Container maximum CPU"
  default     = "100m"
}

variable "resources_limits_memory" {
  type        = string
  description = "Container maximum memory"
  default     = "128Mi"
}

variable "resources_requests_cpu" {
  type        = string
  description = "Container requested CPU"
  default     = "80m"
}

variable "resources_requests_memory" {
  type        = string
  description = "Container requested memory"
  default     = "64Mi"
}

variable "service_account_create" {
  type        = bool
  description = "Create the Service Account"
  default     = false
}

variable "service_account_name" {
  type        = string
  description = "Name of the serviceAccount to create or use"
  default     = null
}

variable "security_context" {
  type        = map
  description = "Map of securityContext for the pod"
  default     = null
}

variable "node_selector" {
  type        = map
  description = "Map of node labels for pod assignment"
  default     = null
}

variable "tolerations" {
  type        = list(string)
  description = "List of node taints to tolerate"
  default     = null
}

variable "affinity" {
  type        = map
  description = "Map of node/pod affinities"
  default     = null
}

variable "storage_alibaba" {
  type        = object({
    bucket      = string,
    prefix      = string,
    endpoint    = string,
    sse         = string
  })
  description = "Alibaba Storage as Storage Backend"
  default     = null
}

variable "storage_amazon" {
  type        = object({
    bucket      = string,
    prefix      = string,
    region      = string,
    endpoint    = string,
    sse         = string
  })
  description = "Amazon S3 as Storage Backend"
  default     = null
}

variable "storage_google" {
  type        = object({
    bucket      = string,
    prefix      = string
  })
  description = "Google Storage as Storage Backend"
  default     = null
}

variable "storage_microsoft" {
  type        = object({
    container   = string,
    prefix      = string
  })
  description = "Microsoft Storage as Storage Backend"
  default     = null
}

variable "depth" {
  type        = number
  description = "Levels of nested repos for multitenancy."
  default     = 0
}

variable "debug" {
  type        = bool
  description = "Show debug messages"
  default     = false
}

variable "log_json" {
  type        = bool
  description = "Output structured logs in JSON"
  default     = true
}

variable "disable_statefiles" {
  type        = bool
  description = "Disable use of index-cache.yaml"
  default     = false
}

variable "disable_metrics" {
  type        = bool
  description = "Disable Prometheus metrics"
  default     = true
}

variable "disable_api" {
  type        = bool
  description = "Disable all routes prefixed with /api"
  default     = true
}

variable "allow_overwrite" {
  type        = bool
  description = "Allow chart versions to be re-uploaded"
  default     = false
}

variable "chart_url" {
  type        = string
  description = "Absolute url for .tgzs in index.yaml"
  default     = null
}

variable "auth_anonymous_get" {
  type        = bool
  description = "Allow anon GET operations when auth is used"
  default     = false
}

variable "context_path" {
  type        = string
  description = "Set the base context path"
  default     = null
}

variable "index_limit" {
  type        = number
  description = "Parallel scan limit for the repo indexer"
  default     = null
}

variable "cache_redis" {
  type        = object({
    address     = string,
    database    = string,
    password    = string
  })
  description = "Redis Cache configuration"
  default     = null
}

variable "bearer_auth" {
  type        = object({
    realm       = string,
    service     = string
  })
  description = "Enable bearer auth. Basic auth should be null"
  default     = null
}

variable "basic_auth" {
  type        = object({
    user        = string,
    password    = string
  })
  description = "Enable Basic HTTP Authentication"
  default     = null
}

variable "gcp_service_account" {
  type        = object({
    name        = string,
    key         = string
  })
  description = "Configuration for GCP service account"
  default     = null
}

variable "ingress" {
  type        = object({
    annotations = map(string),
    labels      = list(string)
    hosts       = list(
      object({
        name        = string
        path        = string,
        tls_secret  = string
      })
    ),
    extra_paths   = list(
      object({
        path        = string,
        service     = string,
        port        = string
      })
    )
  })
  description = "Ingress Controller configuration"
  default     = null
}

variable "service_type" {
  type        = string
  description = "Kubernetes Service type"
  default     = "ClusterIP"
}
