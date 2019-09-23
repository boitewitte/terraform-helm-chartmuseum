data "helm_repository" "kubernetes_charts" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

locals {
  persistence_storage_class = (
    var.persistence_storage_class != null
      ? [
        {
          name = "persistence.storageClass"
          value = var.persistence_storage_class
        }
      ]
      : []
  )
  persistence_volume_name = (
    var.persistence_volume_name != null
      ? [
        {
          name = "persistence.volumeName"
          value = var.persistence_volume_name
        }
      ]
      : []
  )

  service_account_name = (
    var.service_account_name != null
      ? [
        {
          name = "serviceAccount.name"
          value = var.service_account_name
        }
      ]
      : []
  )

  security_context = (
    var.security_context != null
      ? [
        {
          name = "securityContext"
          value = var.security_context
        }
      ]
      : []
  )

  node_selector = (
    var.node_selector != null
      ? [
        {
          name = "nodeSelector"
          value = var.node_selector
        }
      ]
      : []
  )

  tolerations = (
    var.tolerations != null
      ? [
        {
          name = "tolerations"
          value = var.tolerations
        }
      ]
      : []
  )

  affinity = (
    var.affinity != null
      ? [
        {
          name = "affinity"
          value = var.affinity
        }
      ]
      : []
  )

  storage_alibaba  = (
    var.storage_alibaba != null
      ? [
        {
          name      = "env.open.STORAGE",
          value     = "alibaba"
        },
        {
          name      = "env.open.STORAGE_ALIBABA_BUCKET",
          value     = var.storage_alibaba.bucket
        },
        {
          name      = "env.open.STORAGE_ALIBABA_PREFIX",
          value     = var.storage_alibaba.prefix != null ? var.storage_alibaba.prefix : ""
        },
        {
          name      = "env.open.STORAGE_ALIBABA_ENDPOINT",
          value     = var.storage_alibaba.endpoint != null ? var.storage_alibaba.endpoint : ""
        },
        {
          name      = "env.open.STORAGE_ALIBABA_SSE",
          value     = var.storage_alibaba.sse != null ? var.storage_alibaba.sse : ""
        },
      ]
      : []
  )

  storage_amazon = (
    var.storage_amazon != null
      ? [
        {
          name      = "env.open.STORAGE",
          value     = "amazon"
        },
        {
          name      = "env.open.STORAGE_AMAZON_BUCKET",
          value     = var.storage_amazon.bucket
        },
        {
          name      = "env.open.STORAGE_AMAZON_PREFIX",
          value     = var.storage_amazon.prefix != null ? var.storage_amazon.prefix : ""
        },
        {
          name      = "env.open.STORAGE_AMAZON_ENDPOINT",
          value     = var.storage_amazon.endpoint != null ? var.storage_amazon.endpoint : ""
        },
        {
          name      = "env.open.STORAGE_AMAZON_SSE",
          value     = var.storage_amazon.sse != null ? var.storage_amazon.sse : ""
        },
        {
          name      = "env.open.STORAGE_AMAZON_REGION",
          value     = var.storage_amazon.region
        }
      ]
      : []
  )

  storage_google = (
    var.storage_google != null
      ? [
        {
          name      = "env.open.STORAGE",
          value     = "google"
        },
        {
          name      = "env.open.STORAGE_GOOGLE_BUCKET",
          value     = var.storage_google.bucket
        },
        {
          name      = "env.open.STORAGE_GOOGLE_PREFIX",
          value     = var.storage_google.prefix != null ? var.storage_google.prefix : ""
        }
      ]
      : []
  )

  storage_microsoft = (
    var.storage_microsoft != null
      ? [
        {
          name      = "env.open.STORAGE",
          value     = "microsoft"
        },
        {
          name      = "env.open.STORAGE_MICROSOFT_CONTAINER",
          value     = var.storage_microsoft.container
        },
        {
          name      = "env.open.STORAGE_MICROSOFT_PREFIX",
          value     = var.storage_microsoft.prefix != null ? var.storage_microsoft.prefix : ""
        }
      ]
      : []
  )

  storage     = concat(
    local.storage_alibaba,
    local.storage_amazon,
    local.storage_google,
    local.storage_microsoft
  )

  chart_url = (
    var.chart_url != null
      ? [
        {
          name      = "env.open.CHART_URL",
          value     = var.chart_url
        }
      ]
      : []
  )

  context_path = (
    var.context_path != null
      ? [
        {
          name      = "env.open.CONTEXT_PATH",
          value     = var.context_path
        }
      ]
      : []
  )

  index_limit = (
    var.index_limit != null
      ? [
        {
          name      = "env.open.INDEX_LIMIT",
          value     = var.index_limit
        }
      ]
      : []
  )

  cache_redis = (
    var.cache_redis != null
      ? [
        {
          name      = "env.open.CACHE",
          value     = "redis"
        },
        {
          name      = "env.open.CACHE_REDIS_ADDR",
          value     = var.cache_redis.address
        },
        {
          name      = "env.open.CACHE_REDIS_DB",
          value     = var.cache_redis.database != null ? var.cache_redis.database : ""
        }
      ]
      : []
  )

  cache_redis_sensitive = (
    var.cache_redis != null
      ? [
        {
          name      = "env.secret.CACHE_REDIS_PASSWORD",
          value     = var.cache_redis.password
        }
      ]
      : []
  )

  bearer_auth = (
    var.bearer_auth != null && var.basic_auth == null
      ? [
        {
          name      = "env.open.BEARER_AUTH",
          value     = true
        },
        {
          name      = "env.open.AUTH_REALM",
          value     = var.bearer_auth.realm
        },
        {
          name      = "env.open.AUTH_SERVICE",
          value     = var.bearer_auth.service
        }
      ]
      : []
  )

  basic_auth = (
    var.basic_auth == null
      ? [
        {
          name      = "env.secret.BASIC_AUTH_USER",
          value     = var.basic_auth.user
        }
      ]
      : []
  )

  basic_auth_sensitive = (
    var.basic_auth == null
      ? [
        {
          name      = "env.secret.BASIC_AUTH_PASS",
          value     = var.basic_auth.password
        }
      ]
      : []
  )

  gcp_service_account = (
    var.gcp_service_account != null
      ? [
        {
          name      = "gcp.secret.enabled",
          value     = true
        },
        {
          name      = "gcp.secret.name",
          value     = var.gcp_service_account.name
        },
        {
          name      = "gcp.secret.key",
          value     = var.gcp_service_account.key
        }
      ]
      : []
  )

  ingress = (
    var.ingress != null
      ? concat([
          {
            name      = "ingress.enabled",
            value     = true
          }
        ],
        length(var.ingress.annotations) > 0
          ? [{
              name      = "ingress.annotations",
              value     = var.ingress.annotations
            }]
          : [],
        length(var.ingress.labels) > 0
          ? [{
              name      = "ingress.labels",
              value     = var.ingress.labels
            }]
          : [],
        flatten([
          for index, host in var.ingress.hosts:
            [
              {
                name  = "ingress.hosts[${index}].name",
                value = host.name
              },
              {
                name  = "ingress.hosts[${index}].path",
                value = host.path
              },
              {
                name  = "ingress.hosts[${index}].tls",
                value = host.tls_secret != null
              }
            ]
        ]),
        flatten([
          for index, path in var.ingress.extra_paths:
            [
              {
                name  = "ingress.extraPaths[${index}].path",
                value = path.path
              },
              {
                name  = "ingress.extraPaths[${index}].service",
                value = path.service
              },
              {
                name  = "ingress.extraPaths[${index}].port",
                value = path.port != null
              }
            ]
        ])
      )
  )

  ingress_sensitive = (
    var.ingress != null
      ? [
          for index, host in var.ingress.hosts:
            {
              name  = "ingress.hosts[${index}].tlsSecret",
              value = host.tls_secret
            }
            if host.tls_secret != null
        ]
      : []
  )

  set_string  = concat(
    local.persistence_storage_class,
    local.persistence_volume_name,
    local.service_account_name,
    local.storage,
    local.chart_url,
    local.context_path,
    local.cache_redis,
    local.basic_auth
  )

  set         = concat(
    local.security_context,
    local.node_selector,
    local.tolerations,
    local.affinity,
    local.index_limit,
    local.bearer_auth,
    local.gcp_service_account,
    local.ingress
  )

  set_sensitive = concat(
    local.cache_redis_sensitive,
    local.basic_auth_sensitive,
    local.ingress_sensitive
  )
}

resource "helm_release" "chartmuseum" {
  name        = var.name
  repository  = data.helm_repository.kubernetes_charts.metadata.0.name
  chart       = "stable/chartmuseum"

  set_string  {
    name        = "image.pullPolicy"
    value       = var.image_pull_policy
  }

  set_string  {
    name        = "image.repository"
    value       = var.image_repository
  }

  set_string  {
    name        = "image.tag"
    value       = var.image_tag
  }

  set_string {
    name        = "persistence.accessMode"
    value       = var.persistence_access_mode
  }

  set {
    name        = "persistence.enabled"
    value       = var.persistence_enabled
  }

  set_string {
    name        = "persistence.size"
    value       = var.persistence_size
  }

  set {
    name        = "persistence.labels"
    value       = var.persistence_labels
  }

  set {
    name        = "persistence.pv.enabled"
    value       = var.persistence_pv_enabled
  }

  set_string {
    name        = "persistence.pv.capacity.storage"
    value       = var.persistence_pv_capacity_storage
  }

  set_string {
    name        = "persistence.pv.accessMode"
    value       = var.persistence_pv_access_mode
  }

  set_string {
    name        = "persistence.pv.nfs.server"
    value       = var.persistence_pv_nfs_server
  }

  set_string {
    name        = "persistence.pv.nfs.path"
    value       = var.persistence_pv_nfs_path
  }

  set_string {
    name        = "persistence.pv.pvname"
    value       = var.persistence_pv_pvname
  }

  set {
    name        = "replicaCount"
    value       = var.replica_count
  }

  set_string {
    name        = "resources.limits.cpu"
    value       = var.resources_limits_cpu
  }

  set_string {
    name        = "resources.limits.memory"
    value       = var.resources_limits_memory
  }

  set_string {
    name        = "resources.requests.cpu"
    value       = var.resources_requests_cpu
  }

  set_string {
    name        = "resources.requests.memory"
    value       = var.resources_requests_memory
  }

  set {
    name        = "serviceAccount.create"
    value       = var.service_account_create
  }

  set {
    name        = "env.open.DEPTH"
    value       = var.depth
  }

  set {
    name        = "env.open.DEBUG"
    value       = var.debug
  }

  set {
    name        = "env.open.LOG_JSON"
    value       = var.log_json
  }

  set {
    name        = "env.open.DISABLE_STATEFILES"
    value       = var.disable_statefiles
  }

  set {
    name        = "env.open.DISABLE_METRICS"
    value       = var.disable_metrics
  }

  set {
    name        = "env.open.DISABLE_API"
    value       = var.disable_api
  }

  set {
    name        = "env.open.ALLOW_OVERWRITE"
    value       = var.allow_overwrite
  }

  dynamic "set" {
    for_each = local.set

    content {
      name    = set.value.name
      value   = set.value.value
    }
  }

  dynamic "set_string" {
    for_each = local.set_string

    content {
      name    = set_string.value.name
      value   = set_string.value.value
    }
  }

  dynamic "set_sensitive" {
    for_each = local.set_sensitive

    content {
      name    = set_sensitive.value.name
      value   = set_sensitive.value.value
    }
  }

}
