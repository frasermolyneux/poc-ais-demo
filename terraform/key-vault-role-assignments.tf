resource "azurerm_role_assignment" "kv_sp" {
  for_each = toset(var.locations)

  scope                = azurerm_key_vault.kv[each.value].id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "kv_demo" {
  for_each = toset(var.locations)

  scope                = azurerm_key_vault.kv[each.value].id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = "3270dd31-29ac-486d-8a16-e9179660c8d7"
}

resource "azurerm_role_assignment" "app" {
  for_each = toset(var.locations)

  scope                = azurerm_key_vault.kv[each.value].id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_web_app.app[each.value].identity.0.principal_id
}

resource "azurerm_role_assignment" "func" {
  for_each = toset(var.locations)

  scope                = azurerm_key_vault.kv[each.value].id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_function_app.func[each.value].identity.0.principal_id
}

resource "azurerm_role_assignment" "logic" {
  for_each = toset(var.locations)

  scope                = azurerm_key_vault.kv[each.value].id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_logic_app_standard.logic[each.value].identity.0.principal_id
}