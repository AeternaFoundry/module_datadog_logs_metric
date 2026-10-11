resource "datadog_logs_metric" "logs_metrics" {
  for_each = var.logs_metrics

  name = each.value.name

  compute {
    aggregation_type    = each.value.compute.aggregation_type
    include_percentiles = each.value.compute.include_percentiles
    path                = each.value.compute.path
  }

  filter {
    query = each.value.filter.query
  }

  dynamic "group_by" {
    for_each = each.value.group_by != null ? each.value.group_by : []
    content {
      path     = group_by.value.path
      tag_name = group_by.value.tag_name
    }
  }
}

