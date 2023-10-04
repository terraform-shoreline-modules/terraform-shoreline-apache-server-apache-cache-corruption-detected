resource "shoreline_notebook" "apache_cache_corruption_detected" {
  name       = "apache_cache_corruption_detected"
  data       = file("${path.module}/data/apache_cache_corruption_detected.json")
  depends_on = [shoreline_action.invoke_stop_start_apache,shoreline_action.invoke_clear_cache]
}

resource "shoreline_file" "stop_start_apache" {
  name             = "stop_start_apache"
  input_file       = "${path.module}/data/stop_start_apache.sh"
  md5              = filemd5("${path.module}/data/stop_start_apache.sh")
  description      = "Restart Apache server: One of the easiest ways to resolve this issue is to restart the Apache server. This will flush the cache and start with a fresh cache."
  destination_path = "/agent/scripts/stop_start_apache.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "clear_cache" {
  name             = "clear_cache"
  input_file       = "${path.module}/data/clear_cache.sh"
  md5              = filemd5("${path.module}/data/clear_cache.sh")
  description      = "Clear the Cache: Clearing the cache manually can also help resolve the issue. The cache can be cleared by deleting the cache files manually or using a tool like Apache clean."
  destination_path = "/agent/scripts/clear_cache.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_stop_start_apache" {
  name        = "invoke_stop_start_apache"
  description = "Restart Apache server: One of the easiest ways to resolve this issue is to restart the Apache server. This will flush the cache and start with a fresh cache."
  command     = "`chmod +x /agent/scripts/stop_start_apache.sh && /agent/scripts/stop_start_apache.sh`"
  params      = []
  file_deps   = ["stop_start_apache"]
  enabled     = true
  depends_on  = [shoreline_file.stop_start_apache]
}

resource "shoreline_action" "invoke_clear_cache" {
  name        = "invoke_clear_cache"
  description = "Clear the Cache: Clearing the cache manually can also help resolve the issue. The cache can be cleared by deleting the cache files manually or using a tool like Apache clean."
  command     = "`chmod +x /agent/scripts/clear_cache.sh && /agent/scripts/clear_cache.sh`"
  params      = ["PATH_TO_CACHE_DIRECTORY","PATH_TO_APACHE_CLEAN"]
  file_deps   = ["clear_cache"]
  enabled     = true
  depends_on  = [shoreline_file.clear_cache]
}

