variable "logs_metrics" {
  description = <<EOT
Map of logs_metrics, attributes below
Required:
    - name
    - compute (block):
        - aggregation_type (required)
        - include_percentiles (optional)
        - path (optional)
    - filter (block):
        - query (required)
Optional:
    - group_by (block):
        - path (required)
        - tag_name (required)
EOT

  type = map(object({
    name = string
    compute = object({
      aggregation_type    = string
      include_percentiles = optional(bool)
      path                = optional(string)
    })
    filter = object({
      query = string
    })
    group_by = optional(list(object({
      path     = string
      tag_name = string
    })))
  }))
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

