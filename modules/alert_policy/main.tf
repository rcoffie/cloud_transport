resource "azurerm_monitor_action_group" "action_group" {
  name                = "${var.prefix}-action"
  resource_group_name = var.rg.name
  short_name          = "p0action"

  #   webhook_receiver {
  #     name        = "callmyapi"
  #     service_uri = "http://example.com/alert"
  #   }

  email_receiver {
    name          = "sendtoadmin"
    email_address = "rcoffie22@yahoo.com"
  }
}



resource "azurerm_monitor_activity_log_alert" "activity_log_alert" {
  name                = "${var.prefix}-vm-restart-alert"
  resource_group_name = var.rg.name
  # Below is my azure subscription but i replace it with the above
  scopes              =  ["/subscriptions/d23c01fa-5060-43cd-a999-9dd91ef91994/resourceGroups/cloud-transport/providers/Microsoft.Compute/virtualMachines/cp-vm"]
  description         = "This alert will monitor if any VM restarts"

  criteria {
    resource_id = var.vm.id
    # vm -> activity log -> restart virtual machine -> json -> authorization -> action
    operation_name = "Microsoft.Compute/virtualMachines/restart/action"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group.id


  }
}