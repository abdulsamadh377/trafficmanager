resource "azurerm_network_interface" "nic1" {
  name                = "nic-primary"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip1.id
  }
}

resource "azurerm_public_ip" "pip1" {
  name                = "pip-primary"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method  = "Static"
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "primary-vm"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  provision_vm_agent = true
}

# IIS install
resource "azurerm_virtual_machine_extension" "iis1" {
  name                 = "iis-install"
  virtual_machine_id  = azurerm_windows_virtual_machine.vm1.id
  publisher           = "Microsoft.Compute"
  type                = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
{
  "commandToExecute": "powershell Install-WindowsFeature -name Web-Server"
}
SETTINGS
} 