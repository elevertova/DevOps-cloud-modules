module "container_registry" {
  source = "../../../../modules/container-registry"

  repository_name      = var.repository_name
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  force_delete         = false
  tags                 = var.tags
}
