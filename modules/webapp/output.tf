output "app_service_plan_id" {
  value = azurerm_service_plan.webapp.id
}

output "app_service_id" {
  value = azurerm_linux_web_app.webapp.id
}

