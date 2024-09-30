resource "azurerm_resource_group" "myazurelinuxvm" {
  name     = "kml_rg_main-38562b46e13443fa"
  location = "West US"
}

resource "azurerm_virtual_network" "myazurelinuxvm" {
  name                = "myazurelinuxvm-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myazurelinuxvm.location
  resource_group_name = "kml_rg_main-38562b46e13443fa"
}

resource "azurerm_subnet" "myazurelinuxvm" {
  name                 = "internal"
  resource_group_name  = "kml_rg_main-38562b46e13443fa"
  virtual_network_name = azurerm_virtual_network.myazurelinuxvm.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "myazurelinuxvm" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = "kml_rg_main-38562b46e13443fa"
  location            = azurerm_resource_group.myazurelinuxvm.location
  allocation_method   = "Static"

  tags = {
    environment = "Dev-1"
  }
}

resource "azurerm_network_interface" "myazurelinuxvm" {
  name                = "myazurelinuxvm-nic"
  location            = azurerm_resource_group.myazurelinuxvm.location
  resource_group_name = "kml_rg_main-38562b46e13443fa"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.myazurelinuxvm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id  = azurerm_public_ip.myazurelinuxvm.id
  }
}

resource "azurerm_linux_virtual_machine" "myazurelinuxvm" {
  name                = "myazurelinuxvm-machine"
  resource_group_name = "kml_rg_main-38562b46e13443fa"
  location            = azurerm_resource_group.myazurelinuxvm.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.myazurelinuxvm.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("my-vm-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}